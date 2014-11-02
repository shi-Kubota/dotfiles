
set showtabline=1            " 2つ以上タブページがある場合に表示
set guioptions-=m            " メニューバー非表示
set guioptions-=T            " ツールバー非表示
set visualbell t_vb=         " ビープ音なし

set columns=120              " 横幅
set lines=60                 " 行数

" カラースキーマ
colorscheme molokai

" フォント設定
set guifontwide=Ricty_Diminished:h12
set guifont=Ricty_Diminished:h12

" ノーマルモードではセミコロンをコロンに。
nnoremap ; :

" タブ切り替え
nmap <Tab> gt
nmap <S-Tab> gT

" >>> 日本語入力 ------------------------------------------

" 日本語入力をリセット
au BufNewFile,BufRead * set iminsert=0

" ESCでIMEを確実にOFF
inoremap <ESC> <ESC>:set iminsert=0<CR>
" 挿入モード終了時に IME 状態を保存しない
inoremap <silent> <Esc> <Esc>
inoremap <silent> <C-[> <Esc>
" 「日本語入力固定モード」切り替えキー
inoremap <silent> <C-j> <C-^>

" <<< End 日本語入力 --------------------------------------

" >>> NERDTree --------------------------------------------

"let NERDTreeShowHidden = 1   "不可視ファイル表示

" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') && file_name == ""
  autocmd VimEnter * call ExecuteNERDTree()
endif

" カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
"b:nerdstatus = 1 : NERDTree 表示中
"b:nerdstatus = 2 : NERDTree 非表示中

  if !exists('g:nerdstatus')
    execute 'NERDTree ./'
    let g:windowWidth = winwidth(winnr())
    let g:nerdtreebuf = bufnr('')
    let g:nerdstatus = 1

  elseif g:nerdstatus == 1
    execute 'wincmd t'
    execute 'vertical resize' 0
    execute 'wincmd p'
    let g:nerdstatus = 2
    elseif g:nerdstatus == 2
    execute 'wincmd t'
    execute 'vertical resize' g:windowWidth
    let g:nerdstatus = 1

  endif
endfunction
noremap <c-e> :<c-u>:call ExecuteNERDTree()<cr>

" <<< End NERDTree ----------------------------------------

