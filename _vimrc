" 设置不兼容VI模式,在增强模式下运行
set nocompatible " vundle 必需
"==========(初始配置)==========
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			if empty(&shellxquote)
				let l:shxq_sav = ''
				set shellxquote&
			endif
			let cmd = '"' . $VIMRUNTIME . '\diff"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
	if exists('l:shxq_sav')
		let &shellxquote=l:shxq_sav
	endif
endfunction

"==========(基本配置)==========
" 配置字体
"set guifont=YaHei\ Consolas\ Hybrid:h12:cANSI
set guifont=Consolas\ for\ Powerline\ FixedD:h12
set guifontwide=YaHei\ Consolas\ Hybrid:h12:cANSI
" 保存文件的格式顺序 
set fileformats=unix,dos
" vim打开文件时根据这个选项来识别文件编码
set fileencodings=ucs-bom,utf-8,chinese,cp936,gbk
" 保存文件时,使用的编码
set fileencoding=utf-8
" 程序运行时使用的编码
set encoding=utf-8
" 解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" 设置配色方案
colorscheme torte
" 启动时 窗口最大化
au GUIEnter * simalt ~x
" 当文件在外部被修改，自动更新该文件
set autoread 
set autowrite
" 失去焦点后自动保存文件
au FocusLost * :up
" 开启行号标记
set number
" 高亮搜索的关键字 
set hlsearch 
" 搜索忽略大小写 
set ignorecase
" 在输入括号时光标会短暂地跳到与之相匹配的括号处,不影响输入 
set showmatch 
" 防止特殊字符无法正常显示
set ambiwidth=double
" 自动设置当前目录为正在编辑的目录
set autochdir
" 自动补全命令时候使用菜单式匹配列表 
set wildmenu
" 不换行
set nowrap
" 自动隐藏鼠标
set mousehide
" 不显示工具栏
set guioptions-=T

" 使PHP识别EOT字符串 
hi link phpheredoc string

"避免在操作中频繁出现“请按Enter或其他命令继续”
"以及出现“更多”的提示而需要按空格键继续
set nomore

" 禁止生成临时文件
set nobackup
set noundofile
set noswapfile
set noerrorbells
set nowritebackup

" 继承前一行的缩进方式
set autoindent
" 为C程序提供自动缩进
set smartindent
set cindent

" 一个tab是4个字符
set tabstop=4
" 自动缩进的字符个数 
set shiftwidth=4
" 按一次tab前进4个字符
set softtabstop=4
" 用空格代替tab
set expandtab

" 显示一些不显示的空白字符,trail:结尾空白
" 通过 set list 和 set nolist 控制是否显示或是用 set list! 切换显示
set listchars=tab:>-,eol:$,trail:-

" Highlight current line 高亮当前行和列
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

"==========(代码折叠)==========
" 可折叠 foldenable/nofoldenable
set foldenable
" manual    手动折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的内容进行折叠
" marker    使用标记款待折叠，默认标记为{{{和}}}
set foldmethod=syntax
setlocal foldlevel=1
" 默认不折叠
set foldlevelstart=99
" 按空格折叠代码
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"==========(选中搜索)==========
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

"==========(vundle插件)==========
" 插件管理插件。
" 所有插件在 Filetype 之间添加。可以是以下三种形式：
" vim.org 上的脚本名                 Plugin php
" Plugin github 上的作者/项目名称    Plugin gmark/vundle
" Plugin 一个完整的 Git 路径         Plugin git://git.wincent.com/commit.git
" Vundle常用指令
" :PluginList                       列出已经安装的插件
" :PluginInstall                    安装所有配置文件中的插件
" :PluginInstall!                   更新所有插件
" :PluginSearch                     搜索插件
" :PluginClean!                     根据配置文件删除插件
filetype off  "必须
" 此处规定Vundle的路径  
set rtp+=$VIM/vimfiles/bundle/vundle/  
call vundle#rc('$VIM/vimfiles/bundle/')  
Bundle 'gmarik/vundle'  
filetype plugin indent on  "必须

" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'drmingdrmer/xptemplate'
Plugin 'pangloss/vim-javascript'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'easymotion/vim-easymotion'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'skammer/vim-css-color' 
Plugin 'othree/html5.vim'
Plugin 'mattn/emmet-vim'
Plugin 'asins/vimcdoc'
Plugin 'darthmall/vim-vue'


" plugin on www.vim.org
Plugin 'jsbeautify'

"==========(vimcdoc插件)==========
"vim中文帮助文档
set helplang=cn

"==========(emmet-vim插件)==========
"html推导工具

"==========(html5.vim插件)==========
"html5高亮

"==========(vim-css-color插件)==========
" CSS 颜色值背景显示定义的颜色
" g:cssColorVimDoNotMessMyUpdatetime is used when 
" updatetime value set by plugin (100ms) is interfering with your configuration.
let g:cssColorVimDoNotMessMyUpdatetime = 1

"==========(jsbeautify插件)==========
" <leader>ff  格式化js文件

"==========(vim-jsbeautify插件)==========
nmap <F9>  : call HtmlBeautify()<cr>
nmap <F10> : call CSSBeautify()<cr>
nmap <F11> : call JsBeautify()<cr>
vmap <F9>  : call RangeHtmlBeautify()<cr>
vmap <F10> : call RangeCSSBeautify()<cr>
vmap <F11> : call RangeJsBeautify()<cr>

"==========(minibufexxpl插件)==========
let g:miniBufExplMapWindowNavVim = 1   
let g:miniBufExplMapWindowNavArrows = 1   
let g:miniBufExplMapCTabSwitchBufs = 1   
let g:miniBufExplModSelTarget = 1  
let g:miniBufExplorerMoreThanOne=0
" 当前激活文件颜色
hi MBEVisibleActiveNormal  guifg=#A6DB29 
" 前一个文件
map <F7> :MBEbp<CR>
" 后一个文件
map <F8> :MBEbn<CR> 

"==========(vim-easymotion插件)==========
"默认的触发键是<leader><leader> 也就是两个\ 
" Turn on case insensitive feature   <leader><leader>f
let g:EasyMotion_smartcase = 1

"==========(tabular插件)==========
"触发命令 :Tab /|  以|对齐

"==========(vim-surround插件)==========
"@see https://github.com/tpope/vim-surround
"例举几个常用命令 cs"'  cs'<q>  cst"  ds" ysiw]  cs[{  cs[}  yss{

"==========(nerd_tree插件)==========
let g:NERDChristmasTree = 1              "色彩显示
let g:NERDTreeShowHidden = 1             "显示隐藏文件
let g:NERDTreeWinPos = 'left'            "窗口显示位置
let g:NERDTreeHighlightCursorline = 1    "高亮当前行
let g:NERDTreeWinSize=35                 "窗口宽度
let g:NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let g:NERDTreeShowBookmarks=1
nmap <F4> :NERDTreeToggle<CR>

" Exit Vim when the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Focus main window, not NERDTree 开启后,默认打开目录,聚焦主窗口
"augroup NERD
"  autocmd!
"  autocmd VimEnter * NERDTree
"  autocmd VimEnter * wincmd p
"augroup END

"==========(phpcomplete插件)==========
"使用<c-x><c-o>进行自动不全 v7以上自带
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

"==========(xptemplate插件)==========
"此插件默认绑定<c-\>  配置@see https://github.com/drmingdrmer/xptemplate
"编码中难免会有许多重复的代码片段,每次键入这些片段明显是不明智的做法,于是就有大牛写了snipMate插件,不过还有一个更加强大的插件：xptemplate。
filetype plugin on
"触发键绑定到Tab
let g:xptemplate_key = '<Tab>'
"括号补全
let g:xptemplate_brace_complete = "([{\"'"
"补全的括号中不要空格
let g:xptemplate_vars = "SParg="

"==========(vim-javascript插件)==========
"vim自带的javascript缩进简直没法使用，同时还有html里的javascript缩进也是一塌糊涂。而强大的插件vim-javascript则解决了上面的问题。
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow  = 1

"==========(tagbar插件)==========
"tagbar是一个taglist的替代品，比taglist更适合c++使用，函数能够按类区分，支持按类折叠显示等，显示结果清晰简洁。
"由于taglist在使用过程中对中文支持不好，当文件夹是中文的时候，没法生成taglist，于是这里我使用tagbar，它可以很好的解决中文的问题。
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F5> :TagbarToggle<CR>

"==========(vim-airline插件)==========
"vim-airline其实是powerline的copy，它相比powerline有几个好处：它是纯vim script，powerline则用到python；它简单，速度比powerline快
set t_Co=256 
set laststatus=2 " Always display the status line
set lazyredraw
" 设置主题
let g:airline_theme="powerlineish" 
" 这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts=1 
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" 关闭空白符检测
let g:airline#extensions#whitespace#enabled=0
" powerline symbols
let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
let g:airline_left_alt_sep = '>'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '<'
"let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

"==========(ctrlp插件)==========
"全局搜索是一个基于文件名的搜索功能,可以快速定位一个文件。这是ctrlp这个插件提供的功能。
"ctrlp默认会使用grep进行搜索,效率低且慢。可以使用ag去替换默认的搜索功能。ag是一款轻量级的搜索工具,速度非常快。

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

if executable('ag')
	" Use Ag over Grep
	set grepprg=ag\ --nogroup\ --nocolor
	" Use ag in CtrlP for listing files.
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	" Ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif
