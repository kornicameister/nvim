require("bufjump").setup({})
require("which-key").register({
  ["]]"] = {
    ":lua require('bufjump').forward()<cr>",
    "location: next",
  },
  ["[["] = {
    ":lua require('bufjump').backward()<cr>",
    "location: previous",
  },
}, {silent=true, noremap=true})
