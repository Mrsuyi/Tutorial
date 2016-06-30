"====================================================================
"                               hotkey
"====================================================================
"autocmd BufWritePost $MYVIMRC source $MYVIMRC "load vimrc instantly
filetype on        "recognize file type
filetype plugin on "and load different plugin
syntax enable      "enable default
syntax on          "enable third-party

set nocompatible   "not compatible with old version
set mouse=a        "enable mouse
set wildmenu       "vim-cmd auto complete

"show
set background=dark
set laststatus=2    "status bar
set ruler           "cursor-pos
set number          "line-num
set nowrap          "no wrap

"search
set hlsearch        "highlight result
set incsearch       "search instantly

"fold
set foldmethod=syntax
set nofoldenable

"indent
filetype indent on
set expandtab     "auto change tab to space
set autoindent    "auto copy current-line's tab to new line
set cindent       "auto add extra tab on new line
set tabstop=4     "show tab as X space
set shiftwidth=4  "add X space when use << >>
set softtabstop=4 "treat consistant space as tab


"====================================================================
"                      vundle(plugin management)
"====================================================================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'kshenoy/vim-signature'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/DrawIt'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'derekwyatt/vim-protodef'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'gcmt/wildfire.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'suan/vim-instant-markdown'
Plugin 'lilydjwg/fcitx.vim'
call vundle#end()

filetype plugin indent on


"====================================================================
"                          plugin settings
"====================================================================

" theme
set guifont=YaHei\ consolas\ Hybrid\ 11.5
colorscheme molokai
hi Comment cterm=italic,bold
hi Normal ctermfg=254 ctermbg=none
hi ColorColumn ctermbg=236
let g:Powerline_colorscheme='solarized256'

" edit
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" youcompleteme
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf=0


"====================================================================
"                               hotkey
"====================================================================

" leaderkey
let mapleader=";"  "set leader key

" input mode
"inoremap " ""<left>
"inoremap [ []<left>
"inoremap ( ()<left>
"inoremap { {}<left>

" normal mode
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qa<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>W :wq<cr>
nnoremap <leader>v :vsp<cr>
nnoremap <leader>g <C-w>p
nnoremap <leader>h <C-w>w
nnoremap <leader>l :Explore<cr>
nnoremap <leader>n :noh<cr>

" plugin hotkey
nnoremap <leader>d :YcmCompleter GoTo<CR>
