return {
  settings = {
    pylsp = {
      plugins = {
        -- disable diagnostics (basedpyright handles these)
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        pylint = { enabled = false },

        -- keep useful non-diagnostic features
        jedi_completion = { enabled = true },
        jedi_hover = { enabled = false }, -- basedpyright handles hover
        jedi_references = { enabled = false },
        jedi_signature_help = { enabled = true },
        jedi_symbols = { enabled = false },
        rope_autoimport = { enabled = true },
        rope_completion = { enabled = true },
      },
    },
  },
}
