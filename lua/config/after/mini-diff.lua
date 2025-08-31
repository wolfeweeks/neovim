local md = require("mini.diff")

md.setup()

vim.keymap.set("n", "<leader>gha", function ()
  md.toggle_overlay()
end, { desc = "MiniDiff: show all hunk diffs (overlay)" })
