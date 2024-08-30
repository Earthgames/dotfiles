"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"            ███╗   ██╗██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"		     ████╗  ██║██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"	    	 ██╔██╗ ██║██║   ██║██║██╔████╔██║██████╔╝██║
" 			 ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
" 			 ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
" 			 ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  

	" Settings 
	" Disable compatibility with vi which can cause unexpected issues.
	set nocompatible
	
	" Enable type file detection. Vim will be able to try to detect the type of file in use.
	filetype on
	
	" Enable plugins and load plugin for the detected file type.
	filetype plugin on
	
	" Load an indent file for the detected file type.
	filetype indent on
	
	" Turn syntax highlighting on.
	syntax on
	
	" Add numbers to each line on the left-hand side.
	set number
	
	" Highlight cursor line underneath the cursor horizontally.
	set cursorline
	
	" Highlight cursor line underneath the cursor vertically.
	" set cursorcolumn
	
	" Set shift width to 4 spaces.
	set shiftwidth=4
	
	" Set tab width to 4 columns.
	set tabstop=4
	
	" While searching though a file incrementally highlight matching characters as you type.
	 set incsearch
	
	" Ignore capital letters during search.
	set ignorecase
	
	" Override the ignorecase option if searching for capital letters.
	" This will allow you to search specifically for capital letters.
	set smartcase
	
	" Show partial command you type in the last line of the screen.
	set showcmd
	
	" Show matching words during a search.
	set showmatch
	
	" Use highlighting when doing a search.
	set hlsearch
	
	" Set the commands to save in history default number is 20.
	set history=1000
	
	" Enable auto completion menu after pressing TAB.
	set wildmenu
	
	" Make wil
	" set wildmode=list:longest
	
	" There are certain files that we would never want to edit with Vim.
	" Wildmenu will ignore files with these extensions.
	set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
	
	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup
	
	" Enable spell checking and set local
	"set spell spelllang=en_us
	
	" set popup height
	set pumheight=20
	
	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable:
	" delays and poor user experience.
	set updatetime=300
	
	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes
"
	" PLUGINS 
	"
	call plug#begin('~/.vim/plugged')
	
	" LaTex setup
    Plug 'lervag/vimtex'
    Plug 'Konfekt/FastFold'
    Plug 'matze/vim-tex-fold'

	" Plug 'lstwn/broot.vim'
	
	" FileTree
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'nvim-tree/nvim-tree.lua'

	" CodeTree
	Plug 'nvim-treesitter/nvim-treesitter'

	" Rainbow brackets
	Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim'
	
	" Git
	Plug 'TimUntersberger/neogit'
	Plug 'nvim-lua/plenary.nvim'
	{{#if laptop}}

	"Battery
	Plug 'lambdalisue/battery.vim'
	{{/if}}

	" Discord
	Plug 'andweeb/presence.nvim'

	" Status bar
	Plug 'vim-airline/vim-airline'
	Plug 'enricobacis/vim-airline-clock'

	" Colourscheme
	Plug 'dracula/vim',{'as':'dracula'}
	
	" manage external editor tooling such as LSP servers, DAP servers, linters, and formatters 
	Plug 'williamboman/mason.nvim'	
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'

	" Debugger
	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'

	" Linter
	Plug 'mfussenegger/nvim-lint'	

	" Fromatter
	Plug 'mhartington/formatter.nvim'

	" Comments
	Plug 'numToStr/Comment.nvim'

	" Rust analyzer
	Plug 'mrcjkb/rustaceanvim'

	" Completion framework:
    Plug 'hrsh7th/nvim-cmp' 

    " LSP completion source:
    Plug 'hrsh7th/cmp-nvim-lsp'

    " Useful completion sources:
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'hrsh7th/cmp-vsnip'                             
    Plug 'hrsh7th/cmp-path'                              
    Plug 'hrsh7th/cmp-buffer'                            
    Plug 'hrsh7th/vim-vsnip'

	call plug#end()

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
	syntax enable

	lua require('Comment').setup()
	
	" Viewer options: One may configure the viewer either by specifying a built-in
	" viewer method:
	let g:vimtex_view_method = 'zathura'
	let g:tex_flavor  = 'latex'
	let g:tex_conceal = ''
	let g:vimtex_fold_manual = 1
	" VimTeX uses latexmk as the default compiler backend. If you use it, which is
	" strongly recommended, you probably don't need to configure anything. If you
	" want another compiler backend, you can change it as follows. The list of
	" supported backends and further explanation is provided in the documentation,
	" see ":help vimtex-compiler".
	let g:vimtex_compiler_method = 'tectonic'
"
	" VIMSCRIPT 

	" This will enable code folding.
	augroup filetype_vim
		autocmd FileType vim setlocal foldmethod=indent
		autocmd FileType rust setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr() nofoldenable  
	augroup END

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

"
	" STATUS LINE 
	"
	" Clear status line when vimrc is reloaded.
	set statusline=
	
	" Airline config
	let g:airline_powerline_fonts = 1
	{{#if laptop}}
  	let g:airline#extensions#battery#enabled = 1
	{{/if}}
	
	" Status line left side.
	let g:airline_section_y = ''
	
	" Status line middle side
	let g:airline_section_c ='%F %R %M'
	
	" Status line right side.
	let g:airline_section_z ='%p%% :%l/%L☰ ℅:%c'

" Load lua/init.lua
lua require('init')
