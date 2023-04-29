" https://alpha2phi.medium.com/neovim-101-mouse-and-menu-a2d2be60b3e1
" :h usr_42.txt
" :h creating-menus
"     :menu — Normal, Visual, and Operator-pending modes
"     :nmenu — Normal mode
"     :vmenu — Visual mode
"     :omenu — Operator-pending mode
"     :menu! — Insert and Command-line mode
"     :imenu — Insert mode
"     :cmenu — Command-line mode
"     :tlmenu — Terminal mode
"     :amenu — All modes (except for Terminal mode)
"
"     :popup HELP
:menu 80.110 MENU.ALE :popup ALE<CR>
:menu 80.120 MENU.HELP :popup HELP<CR>
:menu 80.130 MENU.MD :popup MD<CR>
"     :popup ALE
:menu 110.110 ALE.GO2Definition :ALEGoToDefinition<CR>
:menu 110.120 ALE.FindReferences :ALEFindReferences<CR>
:menu 110.130 ALE.Information :ALEHover<CR>
:menu 110.140 ALE.SearchSymbol :ALESymbolSearch
" :popup HELP
:menu 120.110 HELP.commands :echo CommandHelp()<CR>
:menu 120.120 HELP.forThisProyect :echo MyMenuFuntions()<CR>
" :popup MD
:menu 130.110 MD.GenerateTOC :GenTocMarked<CR>
:menu 130.120 MD.MarkdownPreview :MarkdownPreview<CR>


