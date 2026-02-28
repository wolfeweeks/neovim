local js_ts_fts = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
}

local js_ts_ft_set = {}
for _, ft in ipairs(js_ts_fts) do
  js_ts_ft_set[ft] = true
end

local function biome_organize_imports(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local biome_clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })

  if #biome_clients > 0 then
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { "source.organizeImports.biome" },
        diagnostics = {},
      },
      filter = function(action)
        return action and action.kind == "source.organizeImports.biome"
      end,
    })
    return
  end

  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.organizeImports" },
      diagnostics = {},
    },
  })
end

local function biome_safe_fixes(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local biome_clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })

  if #biome_clients == 0 then
    return
  end

  vim.lsp.buf.code_action({
    apply = true,
    context = {
      only = { "source.fixAll.biome" },
      diagnostics = {},
    },
    filter = function(action)
      return action and action.kind == "source.fixAll.biome"
    end,
  })
end

local function biome_safe_fixes_sync(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local biome_clients = vim.lsp.get_clients({ bufnr = bufnr, name = "biome" })
  if #biome_clients == 0 then
    return
  end
  local biome_client = biome_clients[1]

  local params = vim.lsp.util.make_range_params(nil, biome_client.offset_encoding)
  params.context = { only = { "source.fixAll.biome" }, diagnostics = {} }

  local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 2000, biome_client.id)
  if not results then
    return
  end

  for client_id, res in pairs(results) do
    local actions = res and res.result or nil
    if type(actions) == "table" then
      for _, action in ipairs(actions) do
        if action and action.kind == "source.fixAll.biome" then
          local client = vim.lsp.get_client_by_id(client_id) or biome_client
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, client and client.offset_encoding or "utf-16")
          end
          local command = action.command or action
          if command then
            vim.lsp.buf.execute_command(command)
          end
          return
        end
      end
    end
  end
end

local function autoformat_enabled(bufnr)
  if LazyVim and LazyVim.format and LazyVim.format.enabled then
    return LazyVim.format.enabled(bufnr)
  end

  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local baf = vim.b[bufnr].autoformat
  if baf ~= nil then
    return baf
  end
  return vim.g.autoformat == nil or vim.g.autoformat
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      Snacks.util.lsp.on(function(buffer, client)
        local ft = vim.bo[buffer].filetype
        if not js_ts_ft_set[ft] then
          return
        end

        if not vim.b[buffer].biome_safe_fixes_on_save then
          vim.b[buffer].biome_safe_fixes_on_save = true
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("BiomeSafeFixes", { clear = false }),
            buffer = buffer,
            callback = function()
              if not autoformat_enabled(buffer) then
                return
              end
              biome_safe_fixes_sync(buffer)
            end,
          })
        end

        vim.keymap.set("n", "<leader>co", biome_organize_imports, {
          buffer = buffer,
          desc = "Organize Imports (Biome)",
        })

        vim.keymap.set("n", "<leader>cO", biome_safe_fixes, {
          buffer = buffer,
          desc = "Biome Safe Fixes",
        })
      end)
    end,
  },
}
