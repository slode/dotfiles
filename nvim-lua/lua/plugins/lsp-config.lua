-- ============================================================================
-- Language Server Protocols
-- ============================================================================
vim.pack.add({
    "https://www.github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
})

vim.cmd("packadd " .. "nvim-lspconfig")
vim.cmd("packadd " .. "mason.nvim")
vim.cmd("packadd " .. "mason-lspconfig.nvim")

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "pylsp", "lua_ls" },
    automatic_enable = true,
})

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
local diagnostic_signs = {
    Error = " ",
    Warn = " ",
    Hint = "",
    Info = "",
}

vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 4 },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
            [vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
            [vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
            [vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        focusable = false,
        style = "minimal",
    },
})

vim.opt.autocomplete = true

-- Configure omnifunc and buffer sources
vim.o.complete = ".,o"
vim.o.completeopt = "fuzzy,menuone,noselect"

do
    local orig = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        return orig(contents, syntax, opts, ...)
    end
end

local function lsp_on_attach(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
        return
    end

    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { noremap = true, silent = true, buffer = ev.buf, desc = 'LSP: ' .. desc })
    end

    -- Navigation
    map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition]")
    map("gr", vim.lsp.buf.references, "[G]oto [R]eferences]")
    map("K", vim.lsp.buf.hover, "Hover Documentation")

    -- Refactoring
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ctions")
    map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")

    if client:supports_method("textDocument/codeAction", ev.buf) then
        map("<leader>coi", function()
            vim.lsp.buf.code_action({
                context = { only = { "source.organizeImports" }, diagnostics = {} },
                apply = true,
                bufnr = ev.buf,
            })
            vim.defer_fn(function()
                vim.lsp.buf.format({ bufnr = ev.buf })
            end, 50)
        end, "[C]ode [O]rganize [I]mports")
    end
end

vim.api.nvim_create_autocmd("LspAttach", { callback = lsp_on_attach })


vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
})
vim.lsp.config('pylsp', {
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', '.git' },
    settings = {
        pylsp = {
            plugins = {
                -- Linter & Formatter settings
                pycodestyle = { enabled = false }, -- Disable if using Ruff plugin
                pyflakes = { enabled = false },
                mccabe = { enabled = true },
            }
        }
    }
})

vim.lsp.config('ruff', {
    init_options = {
        settings = {
            args = { "--select=E,F,UP,N,I" }, -- Optional ruff settings
        }
    }
})

vim.lsp.config("bashls", {})

vim.lsp.config("ts_ls", {})

vim.lsp.enable({
    "lua_ls",
    "pylsp",
    "ruff",
    "bashls",
    "ts_ls",
})
