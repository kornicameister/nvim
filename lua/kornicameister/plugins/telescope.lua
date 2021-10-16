local telescope = require("telescope")

telescope.load_extension("lsp_handlers")
telescope.setup({
	vimgrep_arguments = {
		"ag",
		"--nogroup",
		"--nocolor",
		"--vimgrep",
	},
	extensions = {
		lsp_handlers = {
			code_action = {
				telescope = require("telescope.themes").get_dropdown({}),
			},
		},
	},
})

local opts = {
	noremap = true,
	silent = true,
}
require("which-key").register({
	["<leader>sg"] = {
		"<cmd>lua require('telescope.builtin').live_grep()<cr>",
		"Searching: Grep",
	},
}, opts)
