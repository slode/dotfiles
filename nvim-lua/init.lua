-- ============================================================================
-- Install
--
-- git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
-- ~/.fzf/install
-- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
-- cargo install --locked tree-sitter-cli
-- cargo install --locked ripgrep
--
-- ============================================================================
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/python_nvim/bin/python")

require("config.colors")
require("config.status")
require("config.options")
require("config.keymap")
require("config.autocmds")
-- require("transparency")

-- ============================================================================
-- UTILS
-- ============================================================================

require("float-term")

-- ============================================================================
-- PLUGINS
-- ============================================================================

require("plugins.treesitter-config")
require("plugins.gitsigns-config")
require("plugins.nvim-tree-config")
require("plugins.fzf-config")
require("plugins.mini-config")

-- ============================================================================
-- LSP PLUGINS
-- ============================================================================
--
require("plugins.lsp-config")
