# nvim
My personal neovim setup, OS agnostic as much as possible

## Potential improvements

### van/vin text objects (Neovim 0.12 built-in)
Neovim 0.12 has built-in `van`/`vin` text objects for treesitter node selection.
Works as standard vim motions: `dan` (delete node), `can` (change node), `yan` (yank node).
Could potentially replace custom `<C-space>` incremental selection.
Supports operator-pending mode which custom implementation doesn't.
