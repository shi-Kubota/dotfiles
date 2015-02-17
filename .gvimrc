
set showtabline=1            " 2つ以上タブページがある場合に表示
set guioptions-=m            " メニューバー非表示
set guioptions-=T            " ツールバー非表示
set visualbell t_vb=         " ビープ音なし

set columns=120              " 横幅
set lines=60                 " 行数

set background=dark

" カラースキーマ
colorscheme molokai

" フォント設定
set guifontwide=Ricty_Diminished:h12
set guifont=Ricty_Diminished:h12

" ノーマルモードではセミコロンをコロンに。
nnoremap ; :

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

