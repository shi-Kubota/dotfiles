

" >>> 文字コード, 改行コード ------------------------------
set encoding=utf-8
set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2
set fileformats=unix,dos,mac

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = s:fileencodings_default .','. &fileencodings
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

" <<< End 文字コード, 改行コード --------------------------

" >>> Neobundle Settings. ---------------------------------
filetype plugin indent off

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'          "Git wrapper Plugin
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'szw/vim-tags'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'derekwyatt/vim-scala'
" colorscheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'

NeoBundleLocal ~/.vim/bundle/manual

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" <<< End Neobundle Settings. -----------------------------

" >>> Basic Settings. -------------------------------------
set laststatus=2
set number                  " 行番号表示
set title                   " タイトルを表示
set nobackup                " バックアップファイルを作成しない
set noswapfile              " No Swap
set noundofile              " undoファイルを作成しない
set history=100             " keep 100 lines of command line history
set ruler                   " show the cursor position all the time
set ambiwidth=double
set display=uhex            " 表示できない文字を16進数で表示
set scrolloff=5             " 常にカーソル位置から5行余裕を取る
set virtualedit=block       " 矩形選択でカーソル位置の制限を解除
set autoread                " 他でファイルが編集された時に自動で読み込む
set background=dark

set tabstop=2               " タブサイズ
set shiftwidth=2            " インデント幅
set softtabstop=0

" 一つ前の行に基づくインデント
set expandtab               " タブを空白に置き換える
set autoindent              " 新しい行のインデントを現在行と同じにする

" 編集中の行に下線を引く
autocmd InsertLeave * setlocal nocursorline
autocmd InsertEnter * setlocal cursorline
autocmd InsertLeave * highlight StatusLine ctermfg=145 guifg=#c2bfa5 guibg=#000000
autocmd InsertEnter * highlight StatusLine ctermfg=12 guifg=#1E90FF

" カラースキーマ
colorscheme molokai	
if &term =~ "xterm-256color" || "screen-256color"
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

syntax enable
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c

" タブ・行末の空白・改行を可視化
set list
set listchars=tab:>-,trail:_,eol:.,extends:>,precedes:<

" Programming
set showmatch "対応する括弧を表示
set grepprg=internal "内蔵grep

" 左右のカーソル移動で行間移動可能にする。
set whichwrap=b,s,<,>,[,]

" 検索設定
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
nohlsearch "reset highlight
nnoremap <silent> [space]/ :noh<CR>
map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N

" 入力補完
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/ *$//

" <<< End Basic Settings. -------------------------------------

" >>> vim-airline -----------------------------------------
let g:airline#extensions#whitespace#enabled = 0

" <<< End vim-airline -------------------------------------

