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
let g:NERDTreeWinSize = 40

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

" COC Configuration
" https://github.com/neoclide/coc.nvim#example-vim-configuration
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Jan 25, 2023 configuración temporal de VUE según esta configuración
"[vim-vue-plugin] Hey, it seems that you just upgraded. Please use `g:vim_vue_plugin_config` to replace previous configs                                                                                                                                                  
" [vim-vue-plugin] For details, please check README.md ## Configuration or https://github.com/leafOfTree/vim-vue-plugin
" https://github.com/leafOfTree/vim-vue-plugin#configuration
" START
let g:vim_vue_plugin_config = { 
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['typescript'],
      \   'style': ['css'],
      \},
      \'full_syntax': [],
      \'initial_indent': [],
      \'attribute': 0,
      \'keyword': 0,
      \'foldexpr': 0,
      \'debug': 0,
      \}
" END
"
" Configuración plugin chatgpt
" lua require("chatgpt").setup()

"Activar ayudas de comando usados definidos por usuarios
source ~/.config/nvim/commandHelp.vim
source ~/.config/nvim/myMenu.vim
nnoremap <F1> :popup MENU<CR>

"### ÁREA DE MIS FUNCIONES ###
"## FUNCIÓN PARA AJUSTAR COMENTARIOS##
" Esta función también está acompañada del autocmd para ajustar algunos
" comandos en el momento de abrir un tipo de archivo
" ## START ##
function CommentstringChange(...)
  " a: representa las entradas por argumentos
  if a:1 == 0
    echo "Configurando comentarios con // %s"
    set commentstring=//\ %s
  elseif a:1 == 1
    echo "Configurando comentarios con /*\ %s\ */"
    set commentstring=/*\ %s\ */
  else
    echo "Los posibles formatos de configuración son:"
    echo "arg 0 -> // %s"
    echo "arg 1 -> /* %s */"
    echo "\nSi desea otros formatos puede agregarlos con set commentstring, ejemplo:"
    echo "set commentstring=//\ %s"
  endif
endfunction
" Auto configuración del commentstring
autocmd FileType verilog setlocal commentstring=//\ %s
" ## END ##

function Code()
  setlocal tabstop=2 shiftwidth=2
endfunction
" Local projects.vim config
function VimLocalExist()
if filereadable("./.pro.vim")
  source ./.pro.vim
elseif filereadable("./pro.vim")
  source ./pro.vim
endif
endfunction

call VimLocalExist()
