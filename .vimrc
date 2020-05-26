" TODO
" - tweak base config
" - stop typescript running on JS files (ale thing)

" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Guard ttymouse as vim and nvim configs are shared`
if !has('nvim')
  set ttymouse=xterm2
endif

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" Colors
Plug 'morhetz/gruvbox'

" Remote Plugin
Plug 'roxma/nvim-yarp'

" Javascript Syntax
Plug 'othree/yajs.vim' 

" JSX Syntax
Plug 'mxw/vim-jsx'

" Linting Fixing
Plug 'w0rp/ale'

" Typescript Syntax
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'Shougo/denite.nvim'
Plug 'leafgarland/typescript-vim'

" TSX Syntax
Plug 'peitalin/vim-jsx-typescript'

Plug 'roxma/vim-hug-neovim-rpc'

" File System Plugins
Plug 'scrooloose/nerdtree'

" Text Object Plugins
Plug 'tpope/vim-surround'

" Vim Wiki Plugin
Plug 'vimwiki/vimwiki'

" Vim Airline Plugin
Plug 'vim-airline/vim-airline'

call plug#end()

"""""""""""""""""""""""""""""""""
"        Plugin Settings        "
"""""""""""""""""""""""""""""""""

"" Ale
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_sign_column_always = 1

let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
highlight ALEErrorSign ctermbg        =NONE ctermfg=red
highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 0
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

"" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"" Deoplete
let g:deoplete#enable_at_startup = 1

"" Vim Wiki 
let g:vimwiki_list = [{'path': '~/git/wiki/', 'syntax': 'markdown', 'ext': '.md'}]

"" NERDTree
map <C-n> :NERDTreeToggle<CR>



"""""""""""""""""""""""""""""""""
"          Vim Settings         "
"""""""""""""""""""""""""""""""""

"" General

set nocompatible " enable Vim improvements

" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set relativenumber  " use relative line numbers
set number          " use line number on current line

set history=500 " remember the last 500 commands

" enable filetype plugins
filetype plugin on
filetype indent on

set autoread " auto read changes made to a file from the outside

"" User interface

set so=7 " line padding from top/bottom of the buffer while navigating

" avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu " enable wild menu (autocompletion line)

" ignore these files in wild menu suggestions 
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set ruler " show cursor position 

set cmdheight=1 " height of the command bar

set hid " hide abandoned buffers

" allow backspacing over indents, line breaks and text inserted in current insert mode
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase " ignore case when searching
set smartcase  " be smart about cases when searching 
set hlsearch   " highlight search results
set incsearch  " show search results while typing

set lazyredraw " don't redraw while executing macros (improves performance)

set magic " enable usual regex syntax

set showmatch " show matching brackets when cursor is over one
set mat=2     " blink rate of matching brackets (tenths of a second)

" disable editor sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set foldcolumn=2 " left gutter width


"" Colors and Fonts

syntax enable " enable syntax highlighting

" enable 256 colors palette in gnome terminal
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set background=dark " tell Vim the terminal uses a dark background

" use a colorscheme
try
  colorscheme gruvbox
catch
endtry

set encoding=utf8    " use utf-8 as standard encoding
set langmenu=en_US   " use English as standard language
set ffs=unix,dos,mac " use Unix as the standard file type


" turn backups off
set nobackup
set nowb
set noswapfile


"" Text, tabs and indents

set expandtab " use spaces instead of tabs
set smarttab  " match adjacent lines when tabbing

" tab width (number of spaces)
set shiftwidth=4
set tabstop=4

" linebreak on 500 characters
set lbr
set tw=500

set ai   " auto indent
set si   " smart indent
set wrap " wrap lines


"" Key mappings

let mapleader = ","

" search for current selection in visual mode with * (forwards) and # (backwards)
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" search forwards with <Space> and backwards with <C-Space>
map <space> /
map <C-space> ?

" disable highlight with <leader><cr>
map <silent> <leader><cr> :noh<cr>

" navigate windows with <C-h/j/k/l>
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
  return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

function! CmdLine(str)
  call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", "\\/.*'$^~[]")
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'gv'
    call CmdLine("Ack '" . l:pattern . "' " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
