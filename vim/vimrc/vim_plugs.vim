"En el .vimrc antes de call plug#end() inserte lo siguiente:
" " Include user's extra bundle
" if filereadable(expand("~/.vim_plugs.vim"))
"  source ~/.vim_plugs.vim
" endif
"Así podrá agregar los plugins agregados por usted sin afectar los traidos por
"bootstarp
" My Plug List
"plugin that provides Tern-based JavaScript editing support.
Plug 'ternjs/tern_for_vim' "provides Tern-based JavaScript editing support
Plug 'sickill/vim-monokai' "tema
Plug 'lmintmate/blue-mood-vim' "tema basado en ecmas
"Plug 'elzr/vim-json'
Plug 'chrisbra/csv.vim'
"Plug 'xolox/vim-easytags'
Plug 'Quramy/tsuquyomi' "Make your Vim a TypeScript IDE
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
"Plug 'rafi/awesome-vim-colorschemes' "sin poder probar!!!

"Flutter support for vim
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim-markdown-composer for nvim and vim
" si no compila ejecute el comando manualmente en el directorio de instalación
" .../plugged/vim-markdown-compose
" cargo build --release
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" vim-markdownr
" Plug 'godlygeek/tabular'
" Plug 'plasticboy/vim-markdown'

" PERSONALIZAZCIÓN
if has('nvim')
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vimrc_more
else
  source ~/.vimrc_more
endif
