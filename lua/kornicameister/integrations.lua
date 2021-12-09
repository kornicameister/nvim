local g, env = vim.g, vim.env

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.python2_host_prog = env.PYENV_ROOT .. "/versions/neovim2/bin/python"
g.python3_host_prog = env.PYENV_ROOT .. "/versions/neovim3/bin/python"
