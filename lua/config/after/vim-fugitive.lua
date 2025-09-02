-- <leader>gs toggles Fugitive's status window.
-- If it's open, close it (all fugitive windows in this tab).
-- If none are open, run :Git to open status.
-- If closing the *last* window, pop open NvimTree so Neovim doesn't exit.
vim.keymap.set("n", "<leader>gs", function()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	local fugwins = {}

	for _, w in ipairs(wins) do
		local b = vim.api.nvim_win_get_buf(w)
		local ft = vim.bo[b].filetype
		local name = vim.api.nvim_buf_get_name(b) or ""
		if ft == "fugitive" or name:match("^fugitive://") then
			table.insert(fugwins, w)
		end
	end

	if #fugwins > 0 then
		-- Avoid quitting NVIM if this is the last window
		if vim.fn.winnr("$") == 1 then
			local ok, api = pcall(require, "nvim-tree.api")
			if ok then
				api.tree.open()
			end
		end
		for _, w in ipairs(fugwins) do
			if vim.api.nvim_win_is_valid(w) then
				pcall(vim.api.nvim_win_close, w, true)
			end
		end
	else
		vim.cmd("Git")
		vim.cmd("wincmd _")
	end
end, { silent = true, desc = "Fugitive: toggle status" })

-- Make <CR> in :Git status open the file in a right-side vsplit
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fugitive",
	callback = function(ev)
		vim.opt_local.splitright = true

		vim.keymap.set("n", "<CR>", function()
			-- parse filename from the status line (works even if cursor is on the "M")
			local line = vim.fn.getline(".")
			local file = line:match("^%s*[%w%?][%w%? ]*%s+(.+)$")

			if file and #file > 0 then
				-- Open the file in a vertical split on the right (in the TOP row),
				-- then move *into that split* before making it full height.
				vim.cmd("rightbelow Gvsplit " .. vim.fn.fnameescape(file))
				vim.cmd("wincmd l") -- go to the new right-hand split
				vim.cmd("wincmd L") -- make THIS split the full-height right column

				-- ensure MiniDiff overlay toggles after the new buffer is fully ready
				local buf = vim.api.nvim_get_current_buf()
				vim.schedule(function()
					local md = require("mini.diff")
					pcall(md.attach, buf) -- harmless if already attached
					pcall(md.toggle_overlay, buf) -- toggle overlay for this buffer
				end)
			else
				vim.cmd("normal! <CR>")
			end
		end, { buffer = ev.buf, silent = true, desc = "Fugitive: open file at cursor in right vsplit" })
	end,
})

-- === Generate commit message with OpenCode in Fugitive's commit buffer ===
local function _sanitize_output(text)
	-- If the model wraps output in ``` blocks, strip them.
	text = text:gsub("^%s*```%w*%s*", ""):gsub("%s*```%s*$", "")
	-- Trim leading/trailing whitespace
	return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function _git_root()
	local ok, res = pcall(vim.system, { "git", "rev-parse", "--show-toplevel" }, { text = true })
	if not ok or not res then
		return nil
	end
	local waited = res:wait()
	if waited.code ~= 0 then
		return nil
	end
	return (waited.stdout or ""):gsub("%s+$", "")
end

local function generate_commit_message()
	-- Make sure we have opencode installed
	if vim.fn.executable("opencode") == 0 then
		vim.notify("`opencode` not found on PATH", vim.log.levels.ERROR)
		return
	end

	local root = _git_root()
	if not root or #root == 0 then
		vim.notify("Not inside a git repository", vim.log.levels.ERROR)
		return
	end

	-- Quick check: ensure there are staged changes
	local staged = vim.system({ "git", "diff", "--cached", "--name-only" }, { cwd = root, text = true }):wait()
	if staged.code ~= 0 then
		vim.notify("Failed to inspect staged changes", vim.log.levels.ERROR)
		return
	end
	if (staged.stdout or ""):gsub("%s+", "") == "" then
		vim.notify("No staged changes. Stage files before generating a message.", vim.log.levels.WARN)
		return
	end

	-- Ask OpenCode for a clean, Conventional Commit–style message.
	local prompt = table.concat({
		"Generate a concise, high-quality commit message from the *staged* diff.",
		"Rules:",
		'- Use imperative mood (e.g., "fix:", "feat:"). Prefer Conventional Commits if possible.',
		"- Keep the subject ≤ 72 chars.",
		"- If helpful, include a short body with wrapped lines (≤ 72 chars) and bullets.",
		"- Do *not* include code fences or markdown headings.",
		'- Do *not* include any prose in your response (e.g. "Based on your diff..."), only output the commit message',
		"- Do *not* pay any attention to untracked files or unstaged changes.",
		"- Base it strictly on the staged diff. If you need file context, read files in the diff.",
	}, "\n")

	local result = vim.system({
		"opencode",
		"run",
		prompt .. "\n\nUse: git status, git diff --cached, and read all files in the staged diff.",
		"-m",
		"anthropic/claude-3-5-haiku-20241022",
	}, { cwd = root, text = true }):wait(60000)

	if result.code ~= 0 then
		vim.notify("OpenCode error: " .. (result.stderr or "unknown"), vim.log.levels.ERROR)
		return
	end

	local msg = _sanitize_output(result.stdout or "")
	if msg == "" then
		vim.notify("OpenCode returned empty message", vim.log.levels.WARN)
		return
	end

	-- Split commit buffer into "header" (before first #) and "comment" lines
	local bufnr = vim.api.nvim_get_current_buf()
	local all_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	-- Find first comment line
	local first_comment = nil
	for i, line in ipairs(all_lines) do
		if line:match("^#") then
			first_comment = i
			break
		end
	end

	local generated = vim.split(msg, "\n", { plain = true })

	if first_comment then
		-- Replace everything before the comment block with the generated message
		vim.api.nvim_buf_set_lines(bufnr, 0, first_comment - 1, false, generated)
	else
		-- No comment block? just replace whole buffer
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, generated)
	end
	vim.cmd.normal({ args = { "gg" }, bang = true })
	vim.notify("Commit message generated by OpenCode ✓", vim.log.levels.INFO)
end

-- Create mapping/command when the Fugitive commit buffer opens
vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	callback = function(args)
		vim.api.nvim_buf_create_user_command(args.buf, "AICommit", generate_commit_message, {})
		vim.keymap.set(
			"n",
			"<leader>gm",
			generate_commit_message,
			{ buffer = args.buf, silent = true, desc = "Generate commit message with OpenCode" }
		)
	end,
})

-- Slightly different background so the Fugitive pane reads like a sidebar
vim.opt_local.winhighlight = "Normal:NormalSB,NormalNC:NormalSB,SignColumn:SignColumnSB"
