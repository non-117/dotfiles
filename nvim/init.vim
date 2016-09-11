if &compatible
  set nocompatible
endif

" dein plugin installed directory
let s:dein_dir = expand('~/.cache/dein')
" dein.vim directory
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" if dein.vim is not exist, execute git clone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" plugin file path
let s:toml      = '~/.config/nvim/rc/dein.toml'
let s:lazy_toml = '~/.config/nvim/rc/dein_lazy.toml'

" load TOML and cache it
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#local('~/.config/nvim/plugin/deoplete/sources/rsense.vim')
  call dein#end()
  call dein#save_state()
endif

" if not installed plugin exist, install it.
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" true color
set termguicolors

"Python3 support
let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'


" Disable AutoCompPop.
let g:acp_enableAtStartup = 0
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" set minimum syntax keyword length
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:deoplete#force_omni_input_patterns')
  let g:deoplete#force_omni_input_patterns = {}
endif
let g:deoplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
let g:deoplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'ruby' : $HOME.'/.vim/dicts/ruby.dict',
  \}
let g:deoplete#keyword_patterns = '\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#complete_common_string()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  " return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

"syntastic settings
let g:syntastic_mode_map = {'mode':'active', 'active_filetypes':['ruby','vim','C++','javascript'], 'passive_filetypes':['python']}
let g:syntastic_ruby_checkers = ['rubocop']

"vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1

" ruby settings
" Rsense
let g:rsenseHome = '/usr/local/Cellar/rsense/0.3/libexec'

" quickrun
augroup MyVimrc
  autocmd!
augroup END

"文字コード自動認識
set fencs=utf-8,shift-jis,euc-jp
set ambw=double

"テーマ
colorscheme molokai
"シンタックスハイライト
syntax on

" Editor
let g:loaded_matchparen = 1 " 標準のかっこ対応を無効に
set encoding=utf8
set fileencoding=utf8
set list "不可視文字を表示
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲ "不可視文字を表示
set number "行番号
set expandtab
set autoindent
set tabstop=2 "Tab文字
set shiftwidth=2 "vimが挿入するインデント
set softtabstop=2
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
" C-fで行が余るのを治すパッチ
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')

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

" gtags
" 検索結果Windowを閉じる
nnoremap <C-w>0 <C-w><C-w><C-w>q
" Grep 準備
nnoremap <C-g> :Gtags -g
" このファイルの関数一覧
nnoremap <C-l> :Gtags -f %<CR>
" カーソル以下の定義元を探す
nnoremap <C-j> :Gtags <C-r><C-w><CR>
" カーソル以下の使用箇所を探す
nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
" 次の検索結果
nnoremap <C-n> :cn<CR>
" 前の検索結果
nnoremap <C-p> :cp<CR>

" /{pattern}の入力中は「/」をタイプすると自動で「\/」が、
" ?{pattern}の入力中は「?」をタイプすると自動で「\?」が 入力されるようになる
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

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
  setlocal autoindent
  setlocal smartindent
  setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
 
  setlocal tabstop=4 shiftwidth=4 softtabstop=4
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

"javascript settings
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

let g:syntastic_javascript_checker = "jshint"

let g:jsx_ext_required = 0

" eslintの追加
let g:syntastic_javascript_checkers=['eslint']
" エラー行にsignを表示
let g:syntastic_enable_signs=1
" location listを常に更新
let g:syntastic_always_populate_loc_list=0
" location listを常に表示
let g:syntastic_auto_loc_list=0
" ファイルを開いたときにチェックする
let g:syntastic_check_on_open=0


"rust settings
" :QuickRun でファイル保存時にシンタックスチェック
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['syntax/rust'] = {
            \   'command' : 'rustc',
            \   'cmdopt' : '-Zparse-only',
            \   'exec' : '%c %o %s:p',
            \   'outputter' : 'quickfix',
            \ }
autocmd MyVimrc FileType BufWritePost *.rs QuickRun -type syntax/rust
