-- ============================================================================
-- FZF
-- Fuzzy file finder
--
-- Install:
-- git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
-- ~/.fzf/install
-- cargo install ripgrep
-- ============================================================================

vim.pack.add({
	"https://www.github.com/ibhagwan/fzf-lua",
})

vim.cmd("packadd " .. "fzf-lua")

require("fzf-lua").setup({})

local function smart_files()
  local fzf = require("fzf-lua")
  -- Check if we are in a git repo
  local is_git = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match("true")

  if is_git then
    fzf.git_files()
  else
    fzf.files()
  end
end

vim.keymap.set("n", "ff", function()
	smart_files() -- require("fzf-lua").files()
end, { desc = "FZF Files" })

vim.keymap.set("n", "fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })

vim.keymap.set("n", "fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })

vim.keymap.set("n", "fd", function()
    require("fzf-lua").lsp_definitions({ jump1 = true })
end, { desc = "FZF LSP Definitions" })

vim.keymap.set("n", "fr", function()
    require("fzf-lua").lsp_references()
end, { desc = "FZF LSP References" })

vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })

vim.keymap.set('n', 'fw', function()
    require('fzf-lua').grep_cword()
end,
{ desc = 'FZF Grep Word' })

vim.keymap.set("n", "fs", function()
    require("fzf-lua").lsp_document_symbols()
end, { desc = "FZF LSP Symbols" })

vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })

vim.keymap.set("n", "<leader>fxx", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

-- Not used with pylsp

-- vim.keymap.set("n", "<leader>ft", function()
--     require("fzf-lua").lsp_typedefs()
-- end, { desc = "FZF LSP Typodefs" })

-- vim.keymap.set("n", "<leader>fw", function()
--     require("fzf-lua").lsp_workspace_symbols()
-- end, { desc = "FZF LSP Workspace Symbols" })

-- vim.keymap.set("n", "<leader>fi", function()
--     require("fzf-lua").lsp_implementations()
-- end, { desc = "FZF LSP Implementations" })
