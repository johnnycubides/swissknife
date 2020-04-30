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
