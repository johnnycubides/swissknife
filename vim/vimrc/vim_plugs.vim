"En el .vimrc antes de call plug#end() inserte lo siguiente:
" " Include user's extra bundle
" if filereadable(expand("~/.vim_plugs.vim"))
"  source ~/.vim_plugs.vim
" endif
"Así podrá agregar los plugins agregados por usted sin afectar los traidos por
"bootstarp
" My Plug List
Plug 'chrisbra/csv.vim'
