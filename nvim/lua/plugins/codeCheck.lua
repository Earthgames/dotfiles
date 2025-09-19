---@diagnostic disable: missing-fields
return {
    -- CodeTree
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = "all",
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })
        end,
    },
    -- Manage external editor tooling such as LSP servers, DAP servers, linters, and formatters
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                automatic_enable = true,
            })
            vim.lsp.config("pylsp", {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                maxLineLength = 120,
                            },
                        },
                    },
                },
            })
        end,
    },
    -- Debuger
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            {
                "<F5>",
                function()
                    require("dap").continue()
                end,
                mode = "n",
                desc = "DAP: Continue",
            },
            {
                "<F10>",
                function()
                    require("dap").step_over()
                end,
                mode = "n",
                desc = "DAP: Step Over",
            },
            {
                "<F11>",
                function()
                    require("dap").step_into()
                end,
                mode = "n",
                desc = "DAP: Step Into",
            },
            {
                "<F12>",
                function()
                    require("dap").step_out()
                end,
                mode = "n",
                desc = "DAP: Step Out",
            },
            {
                "<Leader>b",
                function()
                    require("dap").toggle_breakpoint()
                end,
                mode = "n",
                desc = "DAP: Toggle Breakpoint",
            },
            {
                "<Leader>B",
                function()
                    require("dap").set_breakpoint()
                end,
                mode = "n",
                desc = "DAP: Set Breakpoint",
            },
            {
                "<Leader>lp",
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
                end,
                mode = "n",
                desc = "DAP: Set Log Point",
            },
            {
                "<Leader>dr",
                function()
                    require("dap").repl.open()
                end,
                mode = "n",
                desc = "DAP: Open REPL",
            },
            {
                "<Leader>dl",
                function()
                    require("dap").run_last()
                end,
                mode = "n",
                desc = "DAP: Run Last",
            },
            {
                "<Leader>dh",
                function()
                    require("dap.ui.widgets").hover()
                end,
                mode = { "n", "v" },
                desc = "DAP: Hover Info",
            },
            {
                "<Leader>dp",
                function()
                    require("dap.ui.widgets").preview()
                end,
                mode = { "n", "v" },
                desc = "DAP: Preview Info",
            },
            {
                "<Leader>df",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.frames)
                end,
                mode = "n",
                desc = "DAP: Show Frames",
            },
            {
                "<Leader>ds",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.scopes)
                end,
                mode = "n",
                desc = "DAP: Show Scopes",
            },
        },
    },

    -- Formatter
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    svelte = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    graphql = { "prettier" },
                    lua = { "stylua" },
                    python = { "isort", "black" },
                    sql = { "sleek" },
                },
                format_on_save = {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                },
            })
            conform.formatters.stylua = {
                prepend_args = { "--config-path", os.getenv("HOME") .. "/.config/nvim/other/stylua.toml" },
            }

            vim.keymap.set({ "n", "v" }, "<leader>mp", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                })
            end, { desc = "Format file or range (in visual mode)" })
        end,
    },
    -- Linter
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            python = { "pylint" },
        }

        lint.linters.pylint.args = {
            "--max-line-length",
            "120",
        }
    end,
}
