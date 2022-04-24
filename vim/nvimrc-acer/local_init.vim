" ULTISNIPET CONFIG
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/my-snippets/UltiSnips']
let g:UltiSnipsListSnippets="<c-l>"

" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/home/johnny/.config/nvim/plugged/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

"" Tabs. general
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"color similar al dado en gvim
set termguicolors
" identificar linea en la que se encuentra
set cursorline
" Usar numero de linea relativa
set rnu
" Color of number line
highlight LineNr guifg=LightGreen

" Nerdtree size
let g:NERDTreeWinSize = 30

" CONFIG markdown-previewer.vim
let g:mkdp_auto_start = 0

" https://github.com/neovim/neovim/wiki/FAQ
" Cambio de color del cursor
set termguicolors 
hi Cursor guifg=green guibg=green
hi Cursor2 guifg=red guibg=red
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50

" Problema con c <C-J> ambigüedad path ~/.config/nvim/plugged/c.vim:483
let g:C_Ctrl_j = 'off'

:function Es()
: set spell spelllang=es
endfunction

:function En()
: set spell spelllang=en
endfunction

"title
set titleold=Terminal
set titlestring=VIM_\ヽ\(\ヅ\)\ノ_%F

" Local projects.vim config
function VimLocalExist()
if filereadable("./.pro.vim")
  source ./.pro.vim
elseif filereadable("./pro.vim")
  source ./pro.vim
endif
endfunction

call VimLocalExist()
