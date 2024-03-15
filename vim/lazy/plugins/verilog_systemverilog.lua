-- repositorio
-- https://github.com/vhda/verilog_systemverilog.vim

return {
  {
    "https://github.com/vhda/verilog_systemverilog.vim",
    init = function()
      vim.cmd("autocmd FileType verilog setlocal commentstring=//\\ %s")
    end,
  },
}
