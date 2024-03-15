return {
  {
    "Sirver/ultisnips",
    event = { "InsertEnter", "CmdlineEnter" },
    init = function()
      vim.cmd("let g:UltiSnipsSnippetDirectories=[$HOME.'/projects/swissknife/vim/snippets/UltiSnips']")
      vim.cmd("let g:UltiSnipsListSnippets='<c-L>'")
    end,
  },
}
