return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"

      vim.g.tex_flavor = "latex"
      vim.g.tex_conceal = ""
      -- vim.g:vimtex_fold_manual = 1
      -- VimTeX uses latexmk as the default compiler backend. If you use it, which is
      -- strongly recommended, you probably don't need to configure anything. If you
      -- want another compiler backend, you can change it as follows. The list of
      -- supported backends and further explanation is provided in the documentation,
      -- see ":help vimtex-compiler".
      -- vim.g.vimtex_compiler_method = 'tectonic'
    end,
  },
  "Konfekt/FastFold",
  "matze/vim-tex-fold",
}
