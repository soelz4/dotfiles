" pathogen
execute pathogen#infect()

" vim-plug
call plug#begin('~/.vim/plugged')

" ale
Plug 'dense-analysis/ale'
" vim-lsp
Plug 'prabirshrestha/vim-lsp'
" vim-lsp-ale
Plug 'rhysd/vim-lsp-ale'
" vim-lsp-settings
Plug 'mattn/vim-lsp-settings'
" asyncomplete
Plug 'prabirshrestha/asyncomplete.vim'
" asyncomplete-lsp
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" rust
Plug 'rust-lang/rust.vim'
" vim icons
Plug 'ryanoasis/vim-devicons'
" nerd tree
Plug 'preservim/nerdtree'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" everforest
Plug 'sainnhe/everforest'
" dracula
Plug 'dracula/vim', {'as': 'dracula'}
" rose pine
Plug 'rose-pine/vim'
" vim-colors-solarized
Plug 'altercation/vim-colors-solarized'
" solarized8
Plug 'lifepillar/vim-solarized8'
" lightline
Plug 'itchyny/lightline.vim'
" vim-vinegar
Plug 'tpope/vim-vinegar'
" vim-tmux-navigator
Plug 'christoomey/vim-tmux-navigator'
" vim-test
Plug 'vim-test/vim-test'
" vim-sneak
Plug 'justinmk/vim-sneak'
" vim-surround
Plug 'tpope/vim-surround'
" vim-repeat
Plug 'tpope/vim-repeat'

call plug#end()

" init
set encoding=utf-8
set showcmd
set background=dark
set ruler
set laststatus=2
syntax on
filetype plugin indent on
let g:rustfmt_autosave = 1
" let g:ale_linters = {'rust': ['analyzer']}
let g:everforest_background = 'soft'
let g:everforest_better_performance = 1
let g:lightline = {'colorscheme': 'deus'}
let &t_ut=''
colorscheme solarized8_flat
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set autoindent
set smartindent
set mouse = "a"
set nobackup
set noswapfile
set noundofile
set nowritebackup

" bash lsp
if executable('bash-language-server')
	au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'allowlist': ['sh', 'bash'],
        \ })
endif

" tmux-vim-color
if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" rust-analyzer with vim-lsp
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \ })
endif

" everforest config
if has('termguicolors')
	set termguicolors
endif
