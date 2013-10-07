set nocompatible
filetype off

" **** Prep Vundle ****
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" **** Bundles ****
Bundle 'gmarik/vundle'

Bundle 'Valloric/YouCompleteMe'
Bundle 'mileszs/ack.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kien/ctrlp.vim'
Bundle 'sjbach/lusty'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'jnwhiteh/vim-golang'
Bundle 'w0ng/vim-hybrid'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'kana/vim-textobj-user'
Bundle 'tpope/vim-haml'
Bundle 'majutsushi/tagbar'
Bundle 'airblade/vim-gitgutter'
Bundle 'derekwyatt/vim-scala'
Bundle 'gre/play2vim'


Bundle 'VimClojure'
Bundle 'argtextobj.vim'

filetype plugin indent on
syntax on
colorscheme hybrid
runtime macros/matchit.vim

" **** Set Options ****
" dont redraw the window while executing macros or other commands
set lazyredraw
" 256 colors
set t_Co=256
" turn off modeline support
set nomodeline
" use the system clipboard as the anonymous register
set clipboard=unnamed
" set locations to look for autocomplete matches .: current buff, b: other
" loaded buffers, u: other unloaded buffers, t: tags,
set complete=.,b,u,t
" turn on generic onmni completion
set omnifunc=syntaxcomplete#Complete
" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full
" no swapfiles
set noswapfile
" encoding utf-8
set encoding=utf-8
" keep 3 lines of context around the cursor while scrolling up and down
set scrolloff=3
" auto indent on
set autoindent
" allow background 'hidden' buffers to have unsaved changes
set hidden
" use wildmenu for tab completion of commands
set wildmenu
" use visual bell instead of beeping
set visualbell
" highlight line containing the cursor
set cursorline
" improve redraw smoothness on fast connections/terminals
set ttyfast
" display row,col info in status line
set ruler
" make backspace key traverse linebreaks and insert mode begining
set backspace=indent,eol,start
" always display the status line
set laststatus=2
" ignore case when searching
set ignorecase
" search is case insensitive unless caps
set smartcase
" search incrementally
set incsearch
" show matching brace when inserting new one
set showmatch
" highlight search results
set hlsearch
" Display extra whitespace
set list listchars=tab:»·,trail:·,extends:>,precedes:<
" don't make it look like there are line breaks where there aren't
set nowrap
" have % bounce between angled brackets, as well as the other kinds
set matchpairs+=<:>
" show line numbers
set nu
" use relative line numbers
set relativenumber
" dont insert an eol char when editing binary files
set binary noeol
" treat lines starting with a quote mark as comments (for `Vim' files)
set comments+=b:\"
" remove the toolbars in gvim
set guioptions-=T
set guioptions-=L
set guioptions-=r
"bigger font so i don't go blind
set guifont=Inconsolata-dz\ for\ Powerline:h13
" use two-space tabs by default
set tabstop=2
" two spaces for indentation
set shiftwidth=2
" two spaces for soft tabs
set softtabstop=2
" insert spaces when tab is pressed
set expandtab


" **** Custom Bindings ****
let mapleader = ","
" tab bounces between matching pairs
nnoremap <tab> %
vnoremap <tab> %
" move a whole line at once
nnoremap j gj
nnoremap k gk
" jj exits insert mode
inoremap jj <ESC>
" allow for repeated indentation while maintaining visual selection
vnoremap < <gv
vnoremap > >gv
" hide search highlighting on enter
nnoremap <silent> <CR> :noh<CR><CR>
" close buffer with ,q
nnoremap <silent> <leader>q :bd<CR>
" have Y behave analogously to D and C rather than to dd and cc (which is
" already done by yy):
noremap Y y$
" navigate splits
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-n> :vsplit <CR>
nmap <silent> <C-s> :split <CR>
" Highlight the 80th column
highlight OverLength ctermbg=yellow ctermfg=white guibg=yellow guifg=white
nnoremap <leader>oo :match OverLength /\%81v./<CR>
nnoremap <leader>no :match none<CR>

" **** AutoCommands ****
" recognize some other file extensions
autocmd BufNewFile,BufRead *.rhtml set filetype=eruby
autocmd BufNewFile,BufRead *.erb* set filetype=eruby
autocmd BufNewFile,BufRead *.rake set filetype=ruby
autocmd BufNewFile,BufRead *.pm set filetype=perl
autocmd BufNewFile,BufRead *.t set filetype=perl
" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
autocmd FileType make set noexpandtab shiftwidth=8
" use 4 space indention for perl files instead of 2
autocmd Filetype perl setlocal sw=4 sts=4 ts=4


" **** Plugin Specific Settings ****
" Tagbar
let g:tagbar_usearrows = 1
map <Leader>t :TagbarToggle<CR>

" Lusty Juggler
let g:LustyJugglerSuppressRubyWarning = 1

" Ack.vim
" use silver searcher
let g:ackprg = 'ag -i --nogroup --nocolor --column'
nnoremap <leader>a :Ack<space>

" CtrlP
let g:ctrlp_custom_ignore = '\.git\|\.hg\|\.svn\|vendor/\|log/\|tmp/'
let g:ctrlp_dotfiles = 0

" Syntastic
let g:syntastic_always_populate_loc_list=1

" Airline Statusbar
let g:airline_powerline_fonts = 1
let g:airline_enable_syntastic=1
let g:airline_enable_ctrlp=1
let g:airline_theme='dark'

