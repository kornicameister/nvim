local execute = vim.api.nvim_command
local fn = vim.fn

local packar_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packar_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim', '--depth',
        1, packar_path
    })
    execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
    -- self manage for packer
    use 'wbthomason/packer.nvim'

    -- git
    use {
        'tpope/vim-fugitive',
        'octref/rootignore',
        'tpope/vim-git',
        {
            'rhysd/committia.vim',
            setup = [[require('config.committia')]]
        },
        {
            'airblade/vim-gitgutter',
            setup = [[require('config.gitgutter')]]
        }
    }

    -- editor enhanced
    use {
        {
            'lukas-reineke/indent-blankline.nvim',
            branch = 'lua',
            setup = [[require('config.indentline')]]
        },
        {
            'ap/vim-css-color',
            ft = {'css', 'scss', 'sass', 'elm', 'typescript', 'vue'}
        }
    }

    -- UI
    use {'dylanaraps/wal.vim', 'ryanoasis/vim-devicons', 'psliwka/vim-smoothie'}

    -- other
    use {'svermeulen/vimpeccable', 'wakatime/vim-wakatime'}

end)
