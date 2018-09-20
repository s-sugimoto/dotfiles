"""" プラグインのセットアップ
call plug#begin('~/.vim/plugged')

Plug 'nathanaelkane/vim-indent-guides' " インデントに色を付けて見やすくする
Plug 'tpope/vim-surround' " かっこ入力補助
Plug 'bronson/vim-trailing-whitespace' " 行末の空白を強調する
Plug 'terryma/vim-multiple-cursors' " カーソルを分裂させる
Plug 'plasticboy/vim-markdown' " markdown補助
Plug 'godlygeek/tabular' " markdownの表整形
Plug 'airblade/vim-gitgutter' " git差分を視覚化
Plug 'tpope/vim-fugitive' " gitコマンドをvimから実行する
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

""" プラグインの設定
"" vim-indent-guidsの設定
let g:indent_guides_enable_on_vim_startup = 1 " vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_auto_colors=0 " 自動カラーを無効にする
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#3c3c3c ctermbg=darkgray " 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#262626 ctermbg=gray " 偶数インデントのカラー

""" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

""" 表示関係
set t_Co=256 " 256色対応
set background=dark " 背景を黒くする
colorscheme hybrid " カラーテーマ設定
syntax on " syntaxを有効化
set list " 不可視文字の可視化
set listchars=tab:»-,trail:- " 可視化する不可視文字の設定
set number " 行番号の表示
set ruler " カーソル位置が右下に表示される
set wildmenu " コマンドライン補完が強力になる
set showcmd " コマンドを画面の最下部に表示する
set nowrap " 自動折り返しを無効化
set textwidth=0 " 自動的に改行が入るのを無効化
set t_vb= " Beep音を無効化
set novisualbell "Beep音を無効化
set foldmethod=indent " 折り畳み単位の設定
set foldlevel=100 " ファイルを開くときに折り畳みをしない

""" 編集関係
set infercase " 補完時に大文字小文字を区別しない
set virtualedit=all " カーソルを文字が存在しない部分でも動けるようにする
set hidden " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch " 対応する括弧などをハイライト表示する
set matchtime=3 " 対応括弧のハイライト表示を3秒にする
set autoindent " 改行時にインデントを引き継いで改行する
set shiftwidth=2 " インデントにつかわれる空白の数
set softtabstop=2 " <Tab>押下時の空白数
set expandtab " <Tab>押下時に<Tab>ではなく、ホワイトスペースを挿入する
set tabstop=2 " <Tab>が対応する空白の数
set shiftround " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set nf= " インクリメント、デクリメントを10進数にする
set matchpairs& matchpairs+=<:> " 対応括弧に'<'と'>'のペアを追加
set backspace=indent,eol,start " バックスペースでなんでも消せるようにする
" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus,unnamed
else
    set clipboard& clipboard+=unnamed
endif
" Swapファイル, Backupファイルを全て無効化する
set nowritebackup
set nobackup
set noswapfile

""" 検索関係
set ignorecase " 大文字小文字を区別しない
set smartcase " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch " インクリメンタルサーチ
set hlsearch " 検索マッチテキストをハイライト
" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

""" キー設定
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
" カーソル移動
nnoremap gk gg
nnoremap gj G
nnoremap gl $
nnoremap gh ^
vnoremap gl $
vnoremap gh ^
" 分割
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap ssh :vnew <CR>
nnoremap ssj :new <CR> <C-w>J
nnoremap ssk :new <CR>
nnoremap ssl :vnew <CR> <C-w>L
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" 一行コピーで改行を含めない
nnoremap yl ^v$<left>y
" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %
inoremap jj <C-c>
" [ と打ったら [] って入力されて括弧の中にいる(以下同様)
inoremap [ []<left>
inoremap ( ()<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>
" タブ間の移動
nnoremap <C-n> gt
nnoremap <C-p> gT

""" マクロ
" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif
    if a:bang == ''
        pwd
    endif
endfunction
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
" モードによってカーソルの形を変える
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif

