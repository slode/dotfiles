-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = "," -- space for leader
vim.g.maplocalleader = "," -- space for localleader

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Search
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set('n', '*', [[*N]], { noremap = true, silent = true, desc = "Search without move" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Copy/Paste
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window splits
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "[S]plit [V]ertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "[S]plit [H]orizontally" })

-- vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
-- vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
-- vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
-- vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines of code vertically
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Peristent indent selection
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Keep cursor position
vim.keymap.set("n", "<leader>J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

-- Jump by word in Normal Mode
vim.keymap.set('n', '<C-Left>', 'b', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', 'w', { noremap = true, silent = true })

-- Jump by word in Insert Mode
vim.keymap.set('i', '<C-Left>', '<C-O>b', { noremap = true, silent = true })
vim.keymap.set('i', '<C-Right>', '<C-O>w', { noremap = true, silent = true })

-- Diagnostics
vim.keymap.set("n", "<leader>dt", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[D]iagnostics [T]oggle" })

-- Diagnostics
vim.keymap.set("n", "<leader>df", function()
    vim.diagnostic.open_float({ scope = "line" })
end, { desc = "[D]iagnostics [F]loat"})

-- vim.keymap.set("n", "<leader>d", function()
--     vim.diagnostic.open_float({ scope = "cursor" })
-- end, { desc = "Open Cursor Diagnostics" })

vim.keymap.set("n", "<leader>dq", function()
    vim.diagnostic.setloclist({ open = true })
end, { desc = "[D]iagnostic [Q]uicklist" })

vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "[N]ext [D]iagnostic" })
vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "[P]revious [D]iagnostic" })

