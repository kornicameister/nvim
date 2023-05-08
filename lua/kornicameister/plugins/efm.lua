local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}
local stylua = { formatCommand = "stylua --indent-type spaces -s -", formatStdin = true }

local flake8 = {
  lintCommand = "flake8 --stdin-display-name ${INPUT} -",
  lintStdin = true,
  lintIgnoreExitCode = true,
  lintFormats = { "%f:%l:%c: %m" },
}
local mypy = {
  lintCommand = "mypy --show-column-numbers",
  lintIgnoreExitCode = true,
  lintFormats = {
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %tote: %m",
  },
}

local jq = { lintCommand = "jq ." }
local fixjson = { formatCommand = "fixjson -w" }

return {
  css = { prettier },
  scss = { prettier },
  less = { prettier },
  html = { prettier },
  json = { fixjson, prettier, jq },
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
    { lintCommand = "hadolint --no-color", lintFormats = { "%f:%l %m" } },
  },
  vim = {
    { lintCommand = "vint -", lintStdin = true, lintFormats = { "%f:%l:%c: %m" } },
  },
  python = { flake8, mypy },
  lua = { stylua },
}
