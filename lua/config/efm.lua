local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}
local stylua = { formatCommand = "stylua -s -", formatStdin = true }

local flake8 = {
  lintCommand = "flake8 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %m" },
}
local yapf = { formatCommand = "yapf", formatStdin = true }

return {
  css = { prettier },
  scss = { prettier },
  less = { prettier },
  html = { prettier },
  json = { prettier },
  xml = { prettier },
  markdown = {
    prettier,
    {
      lintCommand = "markdownlint -s",
      lintStdin = true,
      lintFormats = {
        "%f:%l %m",
        "%f:%l:%c %m",
        "%f: %l: %m",
      },
    },
  },
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
    flake8,
    yapf,
    {
      lintCommand = "mypy --show-column-numbers",
      lintFormats = {
        "%f:%l:%c: %trror: %m",
        "%f:%l:%c: %tarning: %m",
        "%f:%l:%c: %tote: %m",
      },
    },
  },
  lua = { stylua },
}
