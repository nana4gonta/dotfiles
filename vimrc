" エンコーディング
set fenc=utf-8
set fencs=iso-2022-jp,euc-jp,cp932,utf-8
set enc=utf-8

" 毎行の前に行番号を表示する
set number
" カーソルが何行目の何列目に置かれているかを表示する
set ruler
"タブ文字、行末など不可視文字を表示する
set list

" タブ幅制御
set tabstop=4
set softtabstop=4
set shiftwidth=4

" タブをスペースで入力
set expandtab

" シンタックス
syntax on

" 閉じ括弧が入力されたとき、対応する開き括弧にわずかの間ジャンプする
set showmatch
set clipboard=unnamed
set pastetoggle=<F12>

"全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" 256色化
set t_Co=256


" Vundle
set nocompatible
filetype off
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif
" let NeoBundle manage NeoBundle
" required
NeoBundle 'Shougo/neobundle.vim'
" recomended to install
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'

" original repos on github
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'surround.vim'
NeoBundle 'nathanaelkane/vim-indent-guides.git'
NeoBundle 'hsitz/VimOrganizer.git'
NeoBundle 'tpope/vim-endwise'
filetype on
filetype indent plugin on


" VimOrganizer
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org call org#SetOrgFileType()


" neocomplcache
let g:neocomplcache_enable_at_startup = 1
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" VimShell
if has("mac")
    let g:vimproc_dll_path = $HOME."/.vim/autoload/vimproc_mac.so"
elseif has("unix")
    let g:vimproc_dll_path = $HOME."/.vim/autoload/vimproc_unix.so"
endif
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>
vmap <silent> ,s :VimShellSendString
nnoremap <silent> ,irb :VimShellInteractive irb<CR>

" vim-endwise and neocomplcache
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
