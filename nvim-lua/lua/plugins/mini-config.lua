-- ============================================================================
-- MINI
-- Collection of NVIM QOL plugins
-- ============================================================================

vim.pack.add({
	"https://www.github.com/echasnovski/mini.nvim",
})
vim.cmd("packadd " .. "mini.nvim")

-- require("mini.ai").setup({}) -- aligns columns and paragraphs
-- require("mini.bufremove").setup({})
-- require("mini.move").setup({}) -- move any selection in any way
-- require("mini.pairs").setup({})
-- require("mini.surround").setup({})

require('mini.comment').setup({ -- toggles comments
  mappings = {
    comment = '<Leader>ci',
    comment_visual = '<Leader>ci',
    comment_line = '<Leader>ci',
  }
})
require("mini.cursorword").setup({}) -- highlights all instances of cursorword
require("mini.indentscope").setup({}) -- visualizes scope using a vertical line
require("mini.trailspace").setup({})
require("mini.notify").setup({lsp_progress = {enable = true}})
require("mini.icons").setup({})
require('mini.clue').setup({ -- keymap popup window
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'n', keys = 'g' },
    { mode = 'n', keys = 'f' },
    -- Add other prefixes you use
  },
  clues = {
    require('mini.clue').gen_clues.builtin_completion(),
    require('mini.clue').gen_clues.g(),
    require('mini.clue').gen_clues.z(),
  },
})
