set nocompatible              " required
filetype off                  " required
syntax on

" UI Config
set showcmd             " show command in bottom bar
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]

" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight
let mapleader = ","
nnoremap <leader><space> :nohlsearch<CR>

" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

"Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'jnurmine/Zenburn'
Plugin 'sjl/badwolf'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'pearofducks/ansible-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-unimpaired'
Plugin 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:ycm_autoclose_preview_window_after_completion=1

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

set nu

" Prettify JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
" autocmd Syntax json sou ~/.vim/syntax/json.vim

" Prettify Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" In Ruby files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2
 
 " Yaml indents
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab

 " UltiSnips trigger config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" Ansible highliting
autocmd BufRead,BufNewFile ~/*/ansible*/*.yaml set ft=ansible
autocmd BufRead,BufNewFile ~/*/ansible*/*.yml set ft=ansible
autocmd BufRead,BufNewFile ~/*/ansible*/hosts set ft=ansible_hosts

" Syntastic options
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1
"let g:syntastic_yaml_checkers = ['yamllint']
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'goimports', 'structcheck', 'errcheck', 'gosimple', 'unconvert', 'dupl']
let g:go_metalinter_autosave = 1

"ALE fixers
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['autopep8', 'add_blank_lines_for_python_control_statements', 'trim_whitespace'],
\}
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"vim-airline
"let g:airline_solarized_bg='dark'
let g:airline_theme='base16_monokai'

"tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab
