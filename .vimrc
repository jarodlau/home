
" Sat 10 Sep 2011 08:46:37 PM CST
" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
set encoding=utf-8

" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=500		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
"set showcmd		" display incomplete commands
"set incsearch		" do incremental searching

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"  syntax on
"  set hlsearch
"endif

"" Only do this part when compiled with support for autocommands.
"if has("autocmd")
"
"  " Enable file type detection.
"  " Use the default filetype settings, so that mail gets 'tw' set to 72,
"  " 'cindent' is on in C files, etc.
"  " Also load indent files, to automatically do language-dependent indenting.
"  filetype plugin indent on
"
"  " Put these in an autocmd group, so that we can delete them easily.
"  augroup vimrcEx
"  au!
"
"  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78
"
"  " When editing a file, always jump to the last known cursor position.
"  " Don't do it when the position is invalid or when inside an event handler
"  " (happens when dropping a file on gvim).
"  " Also don't do it when the mark is in the first line, that is the default
"  " position when opening a file.
"  autocmd BufReadPost *
"    \ if line("'\"") > 1 && line("'\"") <= line("$") |
"    \   exe "normal! g`\"" |
"    \ endif
"
"  augroup END
"
"else
"
"  set autoindent		" always set autoindenting on
"
"endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set autoread
set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
 
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.

set scrolloff=7     " Set 7 lines to the curors - when moving vertical..

set wildmenu

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set cmdheight=2     "The commandbar height

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
 
set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
                    "
set mat=2           "How many tenths of a second to blink

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set nolazyredraw    "Don't redraw while executing macros 

set magic           "Set magic on, for regular expressions
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
"set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
 
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
set si              "Smart indet
set wrap            "Wrap lines
 
" set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

set whichwrap+=<,>,h,l

set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
 
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
                    "


" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set nobackup		" do not keep a backup file, use versions instead

if has("vms")
    set undodir=c:\Windows\Temp
else
    "把undo历史保存在文件里,这样undo不会因为vim的关闭而丢失
    set undofile
    set undodir=~/.tmp/undo
endif


if has("gui_running")
	""gvim下鼠标中间粘贴系统剪贴板里的内容
	map <S-Insert> <MiddleMouse>
	map! <S-Insert> <MiddleMouse>
	set t_Co=256
	colorscheme elflord 
    set background=dark
	""去除gvim的工具栏toolbar
	set guioptions-=T
	set guitablabel=%t
    set nonu  
	""设置gvim里的显示字体，用的是微软雅黑和consolas的混合字体
	"set guifont=YaHei\ Mono\ 12
	""gvim的菜单字体和状态栏信息调为为中文
	set langmenu=zh_CN.UTF-8
	language message zh_CN.UTF-8
else
	colorscheme default "zellner
    set background=dark
    set nonu
endif

"set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
set mouse=a         " Enable the use of the mouse.
set mousemodel=popup 

filetype plugin indent on
syntax on


" KEYBONGDINGS
"
let mapleader = ","
let g:mapleader = ","
""快速移动文件里的行，比如crtl+向下的方向键，就会把当前行向下挪一行
nmap 		<C-Down> 	:<C-u>move .+1<CR>
nmap 		<C-Up> 		:<C-u>move .-2<CR>
imap 		<C-Down> 	<C-o>:<C-u>move .+1<CR>
imap 		<C-Up> 		<C-o>:<C-u>move .-2<CR>
vmap 		<C-Down> 	:move '>+1<CR>gv
vmap		<C-Up> 		:move '<-2<CR>gv
""快速切换是否显示行数
"nmap 		<leader>n 	:set nu!<CR>
"imap 		<leader>n 	<C-o>:set nu!<CR>

" FUNCTIONS
"
"Make Vim restore cursor position in files
if has("autocmd")
    au BufReadPost * 
            \if line("'\"") > 1 && line("'\"") <= line("$") |
            \exe "normal! g`\"" | endif
endif

" insert the time with <F2>
imap <F2> <C-R>=strftime("%c")<CR>

" PROGRAME
"

" QuickFix Window Toggle
com! -bang -nargs=? QFix cal QFixToggle(<bang>0)
fu! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = buffnr("$")
        en
    endf
    nn      <leader>q :QFix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
"map <space> /
"map <c-space> ?
"map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
map <right> :bn<cr>
map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


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

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"""""""""""""""""""""""""""""""""""""
"=> statusline
"""""""""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
