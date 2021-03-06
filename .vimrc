
" A custom Vimrc file
" Maintainer : Antoine Albertelli <antoine.albertelli@gmail.com>
" Based on original vimrc by Bram Moolenaar <bram@vimrc>
"

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" vim plug plugins
packadd! dracula

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
    " Puts all backup files in ~/.vim/backup"
    set backup		" keep a backup file
    set backupdir=~/.vim/backup
endif

set history=50		" keep 50 lines of command line history
set ruler   		" show the cursor position all the time
set showcmd	    	" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" FIXME Doesnt work very well with gnome term.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" set colorscheme
" colorscheme peachpuff 
colorscheme dracula
" highlight column 80
set colorcolumn=80

" Show line numbers
set number

" Set window minimal widths
set winwidth=95
set winminwidth=40

" Sets ctags lookup dir 
set tags=tags;/

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Maps all the exotic files to the correct syntax. "
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 
au BufNewFile,BufRead *.dasm,*.dpcu setf dcpu 

"Hitting enter in command mode after a search will clear the search pattern"
noremap <CR> :noh<CR><CR>

"4 space indentation"
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab 

" The terminal uses dark background."
set background=dark 

" Adds highlighting for @todo"
highlight todoTags guifg=red guibg=green
syntax match todoTags /todo/



" Maps NERDTree to F2 "
" map <F2> :NERDTreeToggle<CR>
map <F2> <c-w><c-w>
imap <F2> <esc><c-w><c-w>

" Maps write & close to F3 "
map <F3> :wq<CR>
" Maps autocomplete to tab (tab works with shift+tab "
imap <Tab> <C-N>

" Maps F5 to pdflatex when opening a tex file. "
au BufNewFile,BufRead *.tex map <F5> :! pdflatex % <CR>

" Automatically opens NERDTree if vim is called without a filename "
" autocmd vimenter * if !argc() | NERDTree | endif

" Autoclose Vim if the only window left open is NERDTree "
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

set scrolloff=8     "scroll @ 8 lines before end

"http://stackoverflow.com/questions/849084/what-fold-should-i-use-in-vim
" Folding stuff
hi Folded guibg=red guifg=Red cterm=bold ctermbg=DarkGrey ctermfg=lightblue
hi FoldColumn guibg=grey78 gui=Bold guifg=DarkBlue
set foldcolumn=2
set foldclose=
set foldmethod=syntax
set foldnestmax=10
set foldlevel=999
"set fillchars=vert:\|,fold:\
"set foldminlines=1
" Toggle fold state between closed and opened.

" If there is no fold at current line, just moves forward.
" If it is present, reverse it's state.
fu! ToggleFold()
  if foldlevel('.') == 0
    normal! l
  else
    if foldclosed('.') < 0
      . foldclose
    else
      . foldopen
    endif
  endif
  echo
endf
" Map this function to Space key.
noremap <space> :call ToggleFold()<CR>

au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
"set cpoptions=ces$
"To use the snipmate plugin ces$ does not work. Use B$ instead.
set cpoptions=B$

" tell VIM to always put a status line in, even if there is only one window
set laststatus=2

" Show the current mode
set showmode

" Make command line two lines high
set ch=1

set pastetoggle=<f4>

set statusline=%<\ %f\%m%r\ %y\ %=%-35.(Line:\ %l\ of\ %L,\ Col:\ %c%V\ Buf:#%n\ (%P)%)

map <Left>  :echo "trololo!"<cr>
map <Right> :echo "trololo!"<cr>
map <Up>    :echo "trololo!"<cr>
map <Down>  :echo "trololo!"<cr>


set wildmenu
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpe?g,*.png,*.xpm,*.gif,*.pyc

" Toggle between relative and absolute line-numbers "
nnoremap <F6> :call ToggleNumbers()<cr>

function! ToggleNumbers()
    if &number
        set relativenumber
    else
        set number
    endif
endfunction

" Remove search highlight with <slash slash enter> "
nmap <silent> // :nohlsearch<cr>

" Toggles between English, French, German and no spell check.
function! ToggleSpell()
    if &spell
        if &spelllang == "en_us"
           setlocal spelllang=fr
           echo "French spell check"
        elseif &spelllang == "fr"
           setlocal spelllang=de_ch
           echo "German(CH) spell check"
        else
           setlocal nospell
           echo "No spell check"
        endif
    else
        setlocal spell spelllang=en_us
        echo "English(US) spell check"
    endif
endfunction

" Map spell check toggling to F8 "
nnoremap <S-F8> :call ToggleSpell()<CR>

" Map <F8> to go to next misspelled word "
map <F8> ]s
" Map F9 to show spell check word propositions "
map <F9> z=

filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

" Auto complete closing brackets "
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap (<CR>  (<CR>)<Esc>O 
inoremap {{     {
inoremap {{{    {{{
inoremap {}     {}
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap [      []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap "      <c-v>"<c-v>"<Left>

let g:ConqueTerm_InsertOnEnter = 1

let g:syntastic_cpp_compiler_options = '-std=c++11'
