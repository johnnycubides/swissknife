" ULTISNIPET CONFIG
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/my-snippets/UltiSnips']
let g:UltiSnipsListSnippets="<c-l>"

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
