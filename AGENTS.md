# Neovim Configuration Codebase Guidelines

## Testing & Validation
- Run `:checkhealth` in Neovim to verify plugin installation and configuration
- Test individual plugin configs by reloading with `:Lazy reload <plugin-name>`
- Validate Lua syntax: `luac -p <file.lua>` or `nvim -u NONE -c "luafile %"`

## Code Style & Conventions
- **File Structure**: Main config in `init.lua`, modular configs in `lua/config/`, plugins in `lua/plugins/`
- **After Directory**: `lua/config/after/` contains post-plugin setup (globals, autocmds, plugin-specific tweaks)
- **Plugin Specs**: Return table from `lua/plugins/*.lua` files using lazy.nvim spec format
- **Formatting**: Use Stylua for Lua files (configured in conform.nvim)
- **Naming**: Use snake_case for Lua files and variables, kebab-case for plugin names
- **Imports**: Use `require("module.name")` for Lua modules, avoid global variables
- **Plugin Config**: Prefer `opts = {}` for simple configs, `config = function()` for complex setup

## LSP & Diagnostics
- LSP servers managed via Mason, auto-enabled through mason-lspconfig
- Ensure servers listed in `ensure_installed` (lua_ls, ts_ls, bashls, jsonls, marksman)
- Keymaps bound in LspAttach autocmd (see lua/plugins/lsp.lua:50-66)

## Error Handling
- Use `pcall()` for optional dependencies (see lsp.lua:31)
- Check vim.v.shell_error after system calls (see lazy.lua:6)
- Provide user feedback via vim.api.nvim_echo for critical errors