-- load key map
require("config.map")

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

-- Settings 
-- Disable compatibility with vi which can cause unexpected issues.
vim.opt.compatible = false

vim.cmd([[
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Load an indent file for the detected file type.
filetype indent on
" Turn syntax highlighting on.
syntax on
" Conceal characters
set conceallevel=2
]])
-- Always use the system clipboard for operations
vim.opt.clipboard = "unnamedplus"

-- Add numbers to each line on the left-hand side.
vim.opt.number = true

-- Highlight cursor line underneath the cursor horizontally.
vim.opt.cursorline = true

-- Highlight cursor line underneath the cursor vertically.
-- set cursorcolumn

-- length of an actual \t character:
vim.opt.tabstop = 4
-- length to use when editing text (eg. TAB and BS keys)
-- (0 for ‘tabstop’, -1 for ‘shiftwidth’):
vim.opt.softtabstop = -1
-- length to use when shifting text (eg. <<, >> and == commands)
-- (0 for ‘tabstop’):
vim.opt.shiftwidth = 0
-- round indentation to multiples of 'shiftwidth' when shifting text
-- (so that it behaves like Ctrl-D / Ctrl-T):
vim.opt.shiftround = true
-- Expandes tabs to spaces.
vim.opt.expandtab = true

-- reproduce the indentation of the previous line:
vim.opt.autoindent = true
-- keep indentation produced by 'autoindent' if leaving the line blank:
vim.opt.cpoptions:append "I"

-- use shorter indentation for Haskell scripts:
vim.cmd("autocmd FileType haskell setlocal tabstop=2")

-- While searching though a file incrementally highlight matching characters as you type.
vim.opt.incsearch = true

-- Ignore capital letters during search.
vim.opt.ignorecase = true

-- Override the ignorecase option if searching for capital letters.
-- This will allow you to search specifically for capital letters.
vim.opt.smartcase = true

-- Show partial command you type in the last line of the screen.
vim.opt.showcmd = true

-- Show matching words during a search.
vim.opt.showmatch = true

-- Use highlighting when doing a search.
vim.opt.hlsearch = true

-- Set the commands to save in history default number is 20.
vim.opt.history = 1000

-- Enable auto completion menu after pressing TAB.
vim.opt.wildmenu = true

-- Make wil
-- set wildmode=list:longest

-- There are certain files that we would never want to edit with Vim.
-- Wildmenu will ignore files with these extensions.
vim.opt.wildignore = {"*.docx","*.jpg","*.png","*.gif","*.pdf","*.pyc","*.exe","*.flv","*.img","*.xlsx"}

-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Enable spell checking and set local
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- set popup height
vim.opt.pumheight = 20

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable:
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
autocmd FileType help setlocal nospell
au TermOpen * setlocal nospell
]])

