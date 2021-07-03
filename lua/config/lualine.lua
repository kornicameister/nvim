-- oryginal idea taken from
-- https://github.com/Pasqat/my-turn/blob/c4cd1ab0c34e48b4daa054812c58e0c014d620d8/evil_lualine.lua
local o = vim.opt

o.showmode = false

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

require("lualine").setup({
  options = {
    theme = "material-nvim",
    disabled_filetypes = { "fzf" },
    component_separators = "|",
    section_separators = { "", "" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  sections = {
    lualine_a = { { "mode", upper = true } },
    lualine_b = {
      {
        "branch",
        icon = "",
        condition = conditions.check_git_workspace,
      },
      {
        "diff",
        symbols = { added = " ", modified = "柳 ", removed = " " },
        condition = conditions.hide_in_width,
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        condition = conditions.buffer_not_empty,
        color = { gui = "bold" },
      },
      {
        function()
          local function format_file_size(file)
            local size = vim.fn.getfsize(file)
            if size <= 0 then
              return ""
            end
            local sufixes = { "b", "k", "m", "g" }
            local i = 1
            while size > 1024 do
              size = size / 1024
              i = i + 1
            end
            return string.format("%.1f%s", size, sufixes[i])
          end
          local file = vim.fn.expand("%:p")
          if string.len(file) == 0 then
            return ""
          end
          return format_file_size(file)
        end,
        condition = conditions.buffer_not_empty,
      },
    },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = {
      {
        "diagnostics",
        sources = { "nvim_lsp" },
        symbols = { error = " ", warn = " ", info = " " },
      },
      {
        function()
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
        end,
        icon = "  ",
      },
    },
    lualine_z = {
      { "progress", condition = conditions.hide_in_width },
      { "location", condition = conditions.hide_in_width },
    },
  },
  extensions = {
    "fugitive",
    "fzf",
    "quickfix",
  },
})

