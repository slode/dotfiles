-- ============================================================================
-- COLOR SCHEME
-- ============================================================================

vim.pack.add({
	"https://github.com/ishan9299/nvim-solarized-lua",
})

vim.cmd("packadd " .. "nvim-solarized-lua")
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd.colorscheme("solarized")
