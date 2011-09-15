" 作者相关 {{{
" DesCRiption: 适合自己使用的vimrc文件,for Linux/Windows, GUI/Console
" Last Change: Sun 11 Sep 2011 08:39:53 AM CST
" Author:      Jarod Lau at jarodlau at gmail dot com
" Version:     1.0.0
"}}}

" F2插入时间戳
"imap <F2> <c-r>=strftime("%d%m%y %H:%M:%S")<cr>
imap <F2> <c-r>=strftime("%c")<cr>

" 当vimrc被编辑后,重新挂载
" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
" 在vim文件中保存光标位置
" Make Vim restore cursor position in files
if has("autocmd")
    au BufReadPost * 
                \if line("'\"") > 1 && line("'\"") <= line("$") |
                \exe "normal! g`\"" | endif
endif

" [ Base 基本]"{{{

" 设置leader为,
let mapleader=","
let g:mapleader=","

set mouse=a

" 即使当前已修改 buffer 未保存仍可以切换到其他 buffer
set hidden

" 关闭" 除($，^，.，*)外的正则特殊符号需加"\"转义
set magic

" 处理未保存或只读文件的时候，弹出确认
set confirm
" 使用 vim 的扩展功能，不兼容 vi
set nocompatible

" vim 工作编码,以何种编码显示，文件编码与之不匹配，则iconv转换[?]"{{{
set encoding=utf-8
" 新建/保存文件使用编码
set fileencoding=utf-8
" 文件编码匹配原则：由大到小（有利于找到合适编码）
"set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
set fileencodings=ucs-bom,utf-8,cp936,gbk,gb2312,gb18030,big5,euc-jp,euc-kr,latin1 
"}}}
" 文件在外部被修改，自动读取更新
set autoread
" 自动语法高亮
syntax on
" 检测文件类型
filetype on
" 检测文件类型插件
filetype plugin on
" 文件格式修改
filetype indent on
" 不设定在插入状态无法用退格键和 Delete 键删除回车符
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
" 显示行号
set number
" 上下可视行数
set scrolloff=6
" 设定 tab 长度为 4
set tabstop=4
" 设置按BackSpace的时候可以一次删除掉4个空格
set softtabstop=4
" 设定 << 和 >> 命令移动时的宽度为 4
set shiftwidth=4
set history=1024
" 不突出显示当前行
set nocursorline
" 覆盖文件时不备份
set nobackup
" 设定undo到文件分为win和*nux(linux,unix)2种情况
if has("vms")
    set undodir=c:\Windows\Temp
else
    "把undo历史保存在文件里,这样undo不会因为vim的关闭而丢失
    set undofile
    set undodir=~/.tmp/undo
endif
" 自动切换当前目录为当前文件所在的目录
set autochdir
" 搜索时忽略大小写，但在有一个或以上大写字母时仍大小写敏感
set ignorecase
set smartcase
"" 搜索到文件两端时不重新搜索
"set nowrapscan
" 实时搜索
set incsearch
" 搜索时高亮显示被找到的文本
set hlsearch
" 关闭错误声音
set noerrorbells
set novisualbell
set t_vb=

"}}}


" 不自动换行
"set nowrap
"How many tenths of a second to blink
set mat=2
" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set hidden

" [ Tab 缩进 ]"{{{
" 自动缩进
set autoindent
" 智能自动缩进
set smartindent

set smarttab
set cindent
"}}}

" 设定命令行的行数为 1
set cmdheight=1
" 显示状态栏 (默认值为 1, 无法显示状态栏)
set laststatus=2

" [ Match 匹配 ]"{{{
"显示括号配对情况
set showmatch
" 命令行自动补全所使用的菜单
set wildmenu
" 开启modeline自动识别文件
set modeline
" 自动添加modeline函数
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
	" files.
function! AppendModeline()
	let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
			\ &tabstop, &shiftwidth, &textwidth)
	"let l:modeline = substitute(&commentstring, "%s", l:modeline,
	"		)
	call append(line("$"), l:modeline)
	endfunction
	" 快捷键为 .ml ,ml
	nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
"}}}

" 解决自动换行格式下, 如高度在折行之后超过窗口高度结果这一行看不到的问题
set display=lastline
" 设定配色方案
colorscheme desert
set background=dark
" 设置在状态行显示的信息
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)

" 显示Tab符
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
"启动时不显示 捐赠提示
set shortmess=atl

"blank      空白
"buffers    缓冲区
"curdir     当前目录
"folds      折叠
"help       帮助
"options    选项
"tabpages   选项卡
"winsize    窗口大小
"slash      转换文件路径中的\为/以使session文件兼容unix
"unix       设置session文件中的换行模式为unix
set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize,slash,unix,resize

" {{{ 开始折叠
set foldenable
" 设置语法折叠
" manual  手工定义折叠
" indent  更多的缩进表示更高级别的折叠
" expr    用表达式来定义折叠
" syntax  用语法高亮来定义折叠
" diff    对没有更改的文本进行折叠
" marker  对文中的标志折叠
set foldmethod=marker
"折叠相关的快捷键
"zR 打开所有的折叠
"za Open/Close (toggle) a folded group of lines.
"zA Open a Closed fold or close and open fold recursively.
"zi 全部 展开/关闭 折叠
"zo 打开 (open) 在光标下的折叠
"zc 关闭 (close) 在光标下的折叠
"zC 循环关闭 (Close) 在光标下的所有折叠
"zM 关闭所有可折叠区域
"当使用marker方式时，需要用标记来标示代码的折叠，系统默认是
"{{{和}}},最好不要改动
"可以使用以下命令来创建和删除折叠
"zf 创建折叠，比如在marker方式下：
"	zf56G 创建从当前行起到56行的代码折叠
"	10zf和10zf+或zf10[down] 创建从当前行起到后10行的代码折叠
"	10zf-或者zf10[up] 创建从当前行起到之前10行的代码折叠
"	在括号处zf% 创建从当前行起到对应的匹配的括号上去((),{},
"	[],<>等)
"当foldmethod为manual或者marker时有效
"zd 删除(delete)在光标下的折叠
"	marker时有效
"zD 循环删除(delete)光标下的折叠(嵌套删除折叠)
"zE 除去(Eliminate)窗口里"所有"的折叠
" 设置折叠区域的宽度
set foldcolumn=0
" 设置折叠层数为
setlocal foldlevel=10
" 新建的文件，刚打开的文件不折叠
"autocmd! BufNewFile,BufRead * setlocal nofoldenable
" }}}

" Alt-W切换自动换行
noremap <a-w> :exe &wrap==1 ? 'set nowrap' : 'set wrap'<cr>

" 选中状态下 Ctrl+c 复制
vnoremap <c-c> "+y

" Shift + Delete 插入系统剪切板中的内容
noremap <S-Del> "+p
inoremap <S-Del> <esc>"+pa
vnoremap <S-Del> d"+P

"设置代码折叠方式为 手工  indent
"set foldmethod=indent
"设置代码块折叠后显示的行数
set foldexpr=1

if has("gui_running")
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
	colorscheme torte
	set background=dark
    set showtabline=1 " 隐藏Tab栏
endif

"编辑vim配置文件
if has("unix")
    set fileformats=unix,dos,mac
    nmap <leader>e :tabnew $HOME/.vimrc<cr>
    let $VIMFILES = $HOME."/.vim"
else
    set fileformats=dos,unix,mac
    nmap <leader>e :tabnew $VIM/_vimrc<cr>
    let $VIMFILES = $VIM."/vimfiles"
endif

" Alt-Space is System menu
if has("gui")
  noremap <m-space> :simalt ~<cr>
  inoremap <m-space> <c-o>:simalt ~<cr>
  cnoremap <m-space> <c-c>:simalt ~<cr>
endif

" 设定doc文档目录
let helptags=$VIMFILES."/doc"
set helplang=cn
"set nobomb

" {{{全文搜索选中的文字
vnoremap <silent> <leader>f y/<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
vnoremap <silent> <leader>F y?<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>
" }}}

" [ Keybings 绑定 ] "{{{
" 删除所有行未尾空格
nnoremap <f12> :%s/[ \t\r]\+$//g<cr>

" 窗口切换
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k

" Buffers/Tab操作快捷方式!
nnoremap <s-h> :bprevious<cr>
nnoremap <s-l> :bnext<cr>
nnoremap <s-j> :tabnext<cr>
nnoremap <s-k> :tabprev<cr>

" 插入模式下上下左右移动光标
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <c-o>gj
inoremap <c-k> <c-o>gk

"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
nnoremap <leader>1 :set filetype=xhtml<cr>
nnoremap <leader>2 :set filetype=css<cr>
nnoremap <leader>3 :set filetype=javascript<cr>
nnoremap <leader>4 :set filetype=php<cr>

"}}}

" PHP Twig 模板引擎语法"{{{
au BufRead,BufNewFile *.twig set syntax=twig

" Python 文件的一般设置，比如不要 tab 等
"autocmd FileType python set tabstop=4 shiftwidth=4 expandtab

" 设置字典 ~/.vim/dict/文件的路径
"autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dic
"autocmd filetype css set dictionary=$VIMFILES/dict/css.dic
"autocmd filetype php set dictionary=$VIMFILES/dict/php.dic

autocmd! FileType * exec "set dict+=$VIMFILES/dict/".&ft.".dic"
"set tags+=$VIM/vimfiles/tags/normal/*
"autocmd! FileType * exec "set tags+=$VIM/vimfiles/tags/".&ft."/*"
"inoremap <expr><tab>  pumvisible() ? "\<c-n>" : "\<tab>"
"inoremap <expr><s-tab>  pumvisible() ? "\<c-p>" : "\<tab>"


"Check the syntax of a PHP file
function! CheckPHPSyntax()
    if &filetype != 'php'
        echohl WarningMsg | echo 'This is not a PHP file !' | echohl None
        return
    endif
    setlocal makeprg=php\ -l\ -n\ -d\ html_errors=off\ %
    "setlocal makeprg=php\ -l\ -n\ %
    setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    echohl WarningMsg | echo 'Syntax checking output:' | echohl None

    if &modified == 1
        silent write
    endif
    silent make
    clist
endfunction

au filetype php map <F11> :call CheckPHPSyntax()<CR>

"Run a PHP Script
function! ExecutePHPScript()
    if &filetype != 'php'
        echohl WarningMsg | echo 'This is not a PHP file !' | echohl None
        return
    endif
    setlocal makeprg=php\ -f\ %
    setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    echohl WarningMsg | echo 'Execution output:' | echohl None
    if &modified == 1
        silent write
    endif
    silent make
    clist
endfunction

"function! RunSelectPHPScript()
    "'<,'>w !php
"endfunction

au filetype php nnoremap <C-F11> :call ExecutePHPScript()<CR>
au filetype php inoremap <C-F11> <Esc> :call ExecutePHPScript()<CR>
"au filetype php vnoremap <C-F11> <Esc> :call RunSelectPHPScript()<CR>
"}}}
