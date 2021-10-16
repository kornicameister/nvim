do
	local bufnr = vim.api.nvim_get_current_buf()
	require("cmp").setup.buffer({
		sources = {
			{ name = "nvim_lua" },
			{ name = "buffer" },
		},
	})
end
