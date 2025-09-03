return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = -30,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = "curved",
      winblend = 3,
      title_pos = "center",
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Terminal window navigation
    function _G.set_terminal_keymaps()
      local keymap_opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], keymap_opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], keymap_opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], keymap_opts)
    end

    -- Auto-command to set terminal keymaps
    vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
  end,
}