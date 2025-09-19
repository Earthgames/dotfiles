---------------------------------------------------------------------------
--
--           ███╗   ██╗██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
--		     ████╗  ██║██║   ██║██║████╗ ████║██╔══██╗██╔════╝
--	    	 ██╔██╗ ██║██║   ██║██║██╔████╔██║██████╔╝██║
-- 			 ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
-- 			 ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
-- 			 ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
--
---------------------------------------------------------------------------

-- Setup -----------------------------------------------
require("config.lazy")

-- empty setup using defaults
require("todo-comments").setup()

-- Language server
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, opts)
    end,
})

-- Rust tools
vim.g.rustaceanvim = {
    tools = {
        float_win_config = {
            auto_focus = true,
        },
    },
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set("n", "<C-.>", function()
                vim.cmd.RustLsp("codeAction")
            end, { buffer = bufnr })
        end,
    },
}

-- haskell tools
vim.g.haskell_tools = {
    tools = {
        hover = {
            auto_focus = true,
        },
    },
}

vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=DraculaFg guibg=DraculaBg]])

local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSP Diagnostics Options Setup
vim.diagnostic.config({
    signs = {
        active = true,
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
        },
    },
})

vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DiagnosticError", linehl = "", numhl = "DiagnosticError" }
)
vim.fn.sign_define(
    "DapStopped",
    { text = "", texthl = "DiagnosticWarn", linehl = "WarningMsg", numhl = "DiagnosticWarn" }
)
vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- debugger rust
local dap = require("dap")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "/usr/bin/codelldb",
        args = { "--port", "${port}" },
    },
}

dap.configurations.rust = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
}

local dapui = require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- Completion Plugin Setup
local cmp = require("cmp")
cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Add tab support
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    -- Installed sources:
    sources = {
        { name = "path" }, -- file paths
        { name = "nvim_lsp" }, -- from language server
        { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
        { name = "nvim_lua" }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = "buffer" }, -- source current buffer
        { name = "vsnip" }, -- nvim-cmp source for vim-vsnip
        { name = "calc" }, -- source for math calculation
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "menu", "abbr", "kind" },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = "λ",
                vsnip = "⋗",
                buffer = "Ω",
                path = "🖫",
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

-- Settings ----------------------------------------------------------------
vim.cmd([[
    nnoremap <F3> :NvimTreeToggle<CR>

    " Transparent background
    hi Normal guibg=NONE ctermbg=NONE

    highlight Normal ctermbg=NONE

    " Rust config
    syntax enable
    filetype plugin indent on
    let g:rustfmt_autosave = 1

    " LaTex config
    " This enables Vim's and neovim's syntax-related features. Without this, some
    " VimTeX features will not work (see ":help vimtex-requirements" for more
    " info).

    lua require('Comment').setup()
    " Viewer options: One may configure the viewer either by specifying a built-in
    " viewer method:

    " Rainbow brackets vscode theme
    highlight link RainbowDelimiterRed DraculaFg
    highlight link RainbowDelimiterYellow DraculaPink
    highlight link RainbowDelimiterBlue DraculaCyan
    highlight link RainbowDelimiterOrange DraculaGreen
    highlight link RainbowDelimiterGreen DraculaPurple
    highlight link RainbowDelimiterViolet DraculaOrange
    highlight link RainbowDelimiterCyan DraculaRed
]])
