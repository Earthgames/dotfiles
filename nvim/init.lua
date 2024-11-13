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
require("nvim-tree").setup()
require("todo-comments").setup()

-- lang server and other things
-- require("williamboman/mason.nvim").setup({
--     ui = {
--         icons = {
--             package_installed = "✓",
--             package_pending = "➜",
--             package_uninstalled = "✗"
--         }
--     }
-- })

-- Language server
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
  end,
})

-- Rust tools
vim.g.rustaceanvim = {
    tools = {
        float_win_config = {
            auto_focus = true
        }
    },
    server = {
        on_attach = function(client, bufnr)
            vim.keymap.set('n', '<C-.>', function() vim.cmd.RustLsp('codeAction') end, {buffer = bufnr})
        end
    }
}

-- haskell tools
vim.g.haskell_tools = {
  tools = {
      hover = {
        auto_focus = true,
      }
  },
  hls = {
    on_attach = function(client, bufnr, ht)
      -- Set keybindings, etc. here.
    end,
    -- ...
  },
}

vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=DraculaFg guibg=DraculaBg]]

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

-- Rounded borders
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Debug setup
-- local dap = require('dap')
--
-- dap.adapters.lldb = {
--   type = 'executable',
--   command = '/usr/bin/lldb-dap',
--   name = 'lldb'
-- }
--
-- dap.adapters.rust_lldb = {
--   type = 'executable',
--   command = '/usr/bin/rust-lldb',
--   name = 'rust-lldb'
-- }
--
-- dap.configurations.cpp = {
--   {
--     name = 'Launch',
--     type = 'lldb',
--     request = 'launch',
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
--   },
-- }
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = {
--   {
--     name = 'Launch',
--     type = 'rust-lldb',
--     request = 'launch',
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = {},
--   }
-- }


-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp'},      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua'},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer'},        -- source current buffer
    { name = 'vsnip'},         -- nvim-cmp source for vim-vsnip
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

-- Settings ----------------------------------------------------------------
vim.cmd([[
    nnoremap <F3> :NvimTreeToggle<CR>

    " Colourscheme
    colorscheme dracula

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
    let g:vimtex_view_method = 'zathFormats embedded code blocks - Can format code blocks inside markdown files or similar (see injected language formatting)ura'
    let g:tex_flavor  = 'latex'
    let g:tex_conceal = ''
    let g:vimtex_fold_manual = 1
    " VimTeX uses latexmk as the default compiler backend. If you use it, which is
    " strongly recommended, you probably don't need to configure anything. If you
    " want another compiler backend, you can change it as follows. The list of
    " supported backends and further explanation is provided in the documentation,
    " see ":help vimtex-compiler".
    let g:vimtex_compiler_method = 'tectonic'

    " VIMSCRIPT

    " Rainbow brackets vscode theme
    highlight link RainbowDelimiterRed DraculaFg
    highlight link RainbowDelimiterYellow DraculaPink
    highlight link RainbowDelimiterBlue DraculaCyan
    highlight link RainbowDelimiterOrange DraculaGreen
    highlight link RainbowDelimiterGreen DraculaPurple
    highlight link RainbowDelimiterViolet DraculaOrange
    highlight link RainbowDelimiterCyan DraculaRed

    " Matching brackets
    inoremap { {}<Esc>ha
    inoremap ( ()<Esc>ha
    inoremap [ []<Esc>ha
    inoremap " ""<Esc>ha
    inoremap ' ''<Esc>ha
]])

