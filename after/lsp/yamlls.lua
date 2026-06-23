local cfn_tags = {
  '!And sequence',
  '!Base64',
  '!Cidr sequence',
  '!Condition',
  '!Equals sequence',
  '!FindInMap sequence',
  '!GetAZs',
  '!GetAtt',
  '!GetAtt sequence',
  '!If sequence',
  '!ImportValue',
  '!Join sequence',
  '!Not sequence',
  '!Or sequence',
  '!Ref',
  '!Select sequence',
  '!Split sequence',
  '!Sub',
  '!Sub sequence',
  '!Transform mapping',
}

return {
  filetypes = { 'yaml', 'yaml.cloudformation' },
  on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype == 'yaml.cloudformation' then
      client.settings = vim.tbl_deep_extend('force', client.settings or {}, {
        yaml = { customTags = cfn_tags },
      })
      client:notify('workspace/didChangeConfiguration', { settings = client.settings })
    end
  end,
}
