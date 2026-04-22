vim.filetype.add({
  pattern = {
    ['.*%.yaml'] = {
      priority = -math.huge,
      function(_, bufnr)
        local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, 100, false), '\n')
        if content:match('AWSTemplateFormatVersion') or content:match('Transform:%s*AWS::') then
          return 'yaml.cloudformation'
        end
      end,
    },
    ['.*%.yml'] = {
      priority = -math.huge,
      function(_, bufnr)
        local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, 100, false), '\n')
        if content:match('AWSTemplateFormatVersion') or content:match('Transform:%s*AWS::') then
          return 'yaml.cloudformation'
        end
      end,
    },
    ['.*%.json'] = {
      priority = -math.huge,
      function(_, bufnr)
        local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, 100, false), '\n')
        if content:match('AWSTemplateFormatVersion') then
          return 'json.cloudformation'
        end
      end,
    },
  },
})
