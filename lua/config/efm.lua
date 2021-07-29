local prettier = {
    formatCommand = 'prettier --stdin-filepath ${INPUT}',
    formatStdin = true,
}
local stylua = { formatCommand = 'stylua -s -', formatStdin = true }

return {
    css = { prettier },
    scss = { prettier },
    less = { prettier },
    html = { prettier },
    json = { prettier },
    yaml = {
      { lintCommand = "yamllint -f parsable -", lintStdin = true },
      prettier,
    },
    dockerfile = {
      { lintCommand = "hadolint", lintFormats = { "%f:%l %m" } },
    },
    vim = {
      { lintCommand = "vint -", lintStdin = true, lintFormats = { "%f:%l:%c: %m" } },
    },
    python = {
      { formatCommand = "yapf", formatStdin = true },
      {
        lintCommand = "flake8 --stdin-display-name ${INPUT} -",
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %m" },
      },
      {
        lintCommand = "mypy --show-column-numbers",
        lintFormats = {
          "%f:%l:%c: %trror: %m",
          "%f:%l:%c: %tarning: %m",
          "%f:%l:%c: %tote: %m",
        },
      },
    },
    lua = { stylua }
}
