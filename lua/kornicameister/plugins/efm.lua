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
local yapf = { formatCommand = "yapf --quiet", formatStdin = true }
local mypy = {
  lintCommand = "mypy --show-column-numbers",
  lintIgnoreExitCode = true,
  lintFormats = {
    "%f:%l:%c: %trror: %m",
    "%f:%l:%c: %tarning: %m",
    "%f:%l:%c: %tote: %m",
  },
}

local shfmt = { formatCommand = "shfmt -ci -s -bn", formatStdin = true }
local shellcheck = {
  lintCommand = "shellcheck -f gcc -x",
  lintSource = "shellcheck",
  lintFormats = { "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m", "%f:%l:%c: %tote: %m" },
}

local jq = { lintCommand = "jq ." }

return {
  css = { prettier },
  scss = { prettier },
  less = { prettier },
  html = { prettier },
  json = { prettier, jq },
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
  python = { flake8, yapf, mypy },
  lua = { stylua },
  sh = { shfmt, shellcheck },
}
