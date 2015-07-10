filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc', {'build' : {'mac':'make -f make_mac.mak'}, }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplcache'
" 補完
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'
" document
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
" method jump
NeoBundle 'szw/vim-tags'
" close begin - end
NeoBundle 'tpope/vim-endwise'
" color scheme
NeoBundle 'tomasr/molokai'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kevinw/pyflakes-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'leafgarland/typescript-vim'
NeoBundleLazy 'vim-jp/cpp-vim', {'autoload' : {'filetypes' : ['cpp','hpp','h']}}
NeoBundleLazy 'majutsushi/tagbar', {'autoload' : {'commands':['TagbarToggle']}, 'build' : {'mac': 'brew install ctags'}}
NeoBundleLazy 'lambdalisue/vim-django-support', {'autoload': {'filetypes': ['python', 'python3', 'djangohtml']}}
"NeoBundleLazy 'davidhalter/jedi-vim', {'autoload': {'filetypes': ['python', 'python3', 'djangohtml']}}
call neobundle#end()
filetype plugin indent on

NeoBundleCheck

"syntastic settings
let g:syntastic_mode_map = {'mode':'active', 'active_filetypes':['ruby','vim','C++','javascript','typescript'], 'passive_filetypes':['python']}
let g:systastic_ruby_checkers = ['rubocop']

"文字コード自動認識
set fencs=utf-8,shift-jis,euc-jp
set ambw=double

"テーマ
colorscheme molokai
syntax on

" Editor
set encoding=utf8
set fileencoding=utf8
set list "不可視文字を表示
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲ "不可視文字を表示
set number "行番号
set tabstop=4 "Tab文字
set shiftwidth=4 "vimが挿入するインデント
set expandtab " TABで空白
set autoindent " 新しい行はインデント
set cindent "賢いインデント
set ignorecase "小文字の検索でも大文字が見つかる
set smartcase "明示的にされたら上は無し
set backspace=indent,eol,start "バックスペースで消せる
set nostartofline "移動コマンドで行頭に行かない
set matchpairs& matchpairs+=<:> "括弧のペア追加
set showmatch "対応括弧をハイライト
set matchtime=1 "対応括弧の表示秒数
set wrap "折り返し
"set shiftround "インデントをshiftwidthの倍数にround
set infercase "補完の際のcaseを区別しない
set incsearch "インクリメンタルサーチ
set hlsearch "検索結果をハイライト
set virtualedit=all "どこでもカーソル
set mouse=a "マウス有効
let mapleader=' '
set formatoptions=q

vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR> "カーソル下の単語を*で検索
vnoremap v $h "vを2回で行末まで選択
"Ctrl + hjklでウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"インサートモードでも移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" 行末、行の最初への移動のキーマップ設定
:map! <C-e> <Esc>$a
:map! <C-a> <Esc>^a
:map <C-e> <Esc>$a
:map <C-a> <Esc>^a

" /{pattern}の入力中は「/」をタイプすると自動で「\/」が、
" ?{pattern}の入力中は「?」をタイプすると自動で「\?」が 入力されるようになる
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
else
    set clipboard& clipboard+=unnamed,autoselect
endif

" カーソルを自動的に()の中へ
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
imap // //<left>
imap /// ///<left>

"Environment
set nobackup
set noswapfile
set nowritebackup
set laststatus=2 "下のアレ
inoremap jj <Esc> "jjでEscと同じ

"Quickrun Config
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {'split':':botright 8sp'}
let g:quickrun_config.cpp = {'command':'clang++', 'cmdopt':'-std=c++1y -Wall -Wextra'}

"vimデフォルトのエクスプローラをvimfilerで置き換える
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動する
let g:vimfiler_safe_mode_by_default = 0

"Lightline settings
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


"Python Settings
function! InitPython()
  setlocal smartindent
  setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class

  set listchars=tab:--,trail:-,extends:»,precedes:«,nbsp:%,eol:↲ 
  nnoremap <buffer> <leader>l :<C-u>call Flake8()<CR>
  IndentGuidesEnable
endfunction
autocmd BufEnter * if &filetype == "python" | call InitPython() | endif
let g:flake8_builtins="_,apply"

"let s:hooks = neobundle#get_hooks("jedi-vim")
"function! s:hooks.on_source(bundle)
  " jediにvimの設定を任せると'completeopt+=preview'するので
  " 自動設定機能をOFFにし手動で設定を行う
"  let g:jedi#auto_vim_configuration = 0
  " 補完の最初の項目が選択された状態だと使いにくいためオフにする
"  let g:jedi#popup_select_first = 0
  " quickrunと被るため大文字に変更
"  let g:jedi#rename_command = '<Leader>R'
  " gundoと被るため大文字に変更 (2013-06-24 10:00 追記)
"  let g:jedi#goto_command = '<Leader>G'
"endfunction

"Ruby Settings
let g:rsenseHome = '/usr/local/Cellar/rsense/0.3/libexec'
let g:rsenseUseOmniFunc = 1
" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

function! InitRuby()
  setlocal tabstop=2 shiftwidth=2 softtabstop=2
endfunction
autocmd BufEnter * if &filetype == "ruby" | call InitRuby() | endif 

" C++11 Settings
augroup cpp-path
  autocmd!
  autocmd FIleType cpp setlocal path=.,/usr/include,/usr/local/include
augroup END

if executable("clang++")
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '--std=c++11 --stdlib=libc++'
  let g:quickrun_config = {}
  let g:quickrun_config['cpp/clang++11'] = {
      \ 'cmdopt': '--std=c++11 --stdlib=libc++',
      \ 'type': 'cpp/clang++'
    \ }
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++11'}
endif

