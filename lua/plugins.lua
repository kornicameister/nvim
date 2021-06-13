local execute = vim.api.nvim_command
local fn = vim.fn
local g = vim.g

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
        {
            'tpope/vim-fugitive',
            cmd = {'Git', 'Gcommit', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}
        },
        'octref/rootignore',
        'tpope/vim-git',
        'rhysd/git-messenger.vim',
        {
            'rhysd/committia.vim',
            setup = [[require('config.committia')]],
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
        },
        'ConradIrwin/vim-bracketed-paste',
        'scrooloose/nerdcommenter',
        'tpope/vim-surround',
        'zhimsel/vim-stay'
    }

    -- UI
    use {
        'dylanaraps/wal.vim',
        'ryanoasis/vim-devicons',
        'psliwka/vim-smoothie',
        {
            'luochen1990/rainbow',
            setup = function()
                local g = vim.g
                g.rainbow_active = 1
            end
        },
        {
            'vim-airline/vim-airline',
            setup = [[require('config.airline')]]
        },
        {
          'camspiers/lens.vim',
          requires = { 'camspiers/animate.vim' },
          setup = function()
            local g = vim.g
            g['lens#disabled_filetypes'] = {'fzf'}
          end
        }
    }

    -- other
    use {
        'tpope/vim-repeat',
        'svermeulen/vimpeccable',
        'wakatime/vim-wakatime',
        {
          "folke/which-key.nvim",
          config = function()
            require("which-key").setup {
              presets = {
                g = true
              }
            }
          end
        },
        {
           'famiu/nvim-reload',
            requires = { 'nvim-lua/plenary.nvim' }
        },
        {
            'iamcco/markdown-preview.nvim',
            run = 'cd app && yarn install',
            cmd = 'MarkdownPreview',
        }
    }

end)
