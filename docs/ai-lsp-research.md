# AI/LLM + LSP Integration Research for Neovim

## Cel
Integracja AI (Amazon Q / Claude / Kiro) z nvim przez interfejs LSP do diagnostyki kodu,
code review, inline suggestions i chat.

---

## 1. Amazon Q Developer (`awslabs/amazonq.nvim`)

Oficjalny plugin od AWS. **Działa przez LSP** - to jest kluczowe!

- Inline code suggestions przez `textDocument/completion` LSP method
- Chat window (`:AmazonQ`)
- Refactoring (`:AmazonQ refactor`), fix (`:AmazonQ fix`), explain (`:AmazonQ explain`)
- Darmowy tier przez AWS Builder ID
- Wymaga NodeJS >= 18

```lua
-- lazy.nvim
{
  name = 'amazonq',
  url = 'https://github.com/awslabs/amazonq.nvim.git',
  opts = {
    ssoStartUrl = 'https://view.awsapps.com/start', -- Free Tier
  },
}
```

Kluczowe: completions integrują się z nvim-cmp/blink/mini.completion automatycznie.

---

## 2. MCP (Model Context Protocol) - Bridge między nvim a AI

### 2a. `mcphub.nvim` - Hub do zarządzania MCP serverami
- https://github.com/ravitemer/mcphub.nvim
- Zarządza wieloma MCP serverami w nvim
- UI do testowania i używania MCP tools
- Integruje się z chat pluginami (codecompanion, avante)

### 2b. `nvim-lsp-mcp` - Bridge LSP → AI
- https://github.com/trevorprater/nvim-lsp-mcp
- Eksportuje dane LSP (diagnostics, symbols, references) do AI przez MCP
- AI może czytać twoje błędy LSP i proponować fixy

### 2c. `mcp-diagnostics-nvim` - Diagnostyki LSP → AI
- https://github.com/georgeharker/mcp-diagnostics-nvim
- Dzieli się diagnostykami nvim z AI assistantami przez MCP
- Działa z mcphub.nvim lub jako standalone MCP server (Node.js)
- **To jest dokładnie to czego szukasz** - AI widzi twoje błędy LSP

---

## 3. Claude Integration

### 3a. `codecompanion.nvim` - Multi-provider AI chat
- https://github.com/olimorris/codecompanion.nvim
- Wspiera: Claude, Copilot, DeepSeek, Gemini, Ollama, OpenAI, xAI
- Chat + inline code editing
- Integracja z MCP przez mcphub.nvim
- Najbardziej dojrzały multi-provider plugin

### 3b. `claude.vim` - Direct Claude integration
- https://github.com/pasky/claude.vim
- Prosty plugin do pair programming z Claude
- Chat o otwartych buforach

### 3c. Claude Code + nvim (external)
- Claude Code CLI może łączyć się z nvim przez `$NVIM` socket
- `nvim --server "$NVIM" --remote-expr` do ewaluacji Vimscript/Lua
- Może czytać diagnostyki, bufory, treesitter nodes

---

## 4. Strategia: AI jako LSP Diagnostics Provider

Podejście: użyj `none-ls.nvim` (fork null-ls) do wstrzykiwania diagnostyk z AI.

```
[Twój kod] → [LSP servers] → diagnostyki
                                    ↓
                            [mcp-diagnostics-nvim] → MCP → AI (Claude/Q)
                                    ↓
                            AI response → [none-ls] → diagnostyki w nvim
```

Alternatywnie: amazonq.nvim już działa jako LSP server i daje diagnostyki inline.

---

## 5. Przykład z mbarneyjr/mbnvim/review.nvim

Ten gość zrobił custom plugin do code review:
- `.claude-plugin` + `.mcp.json` - integracja z Claude przez MCP
- MCP server (Node.js) bootstrapowany przez `bootstrap.mjs`
- Skills/prompts do nvim code review
- Claude dostaje kontekst nvim i robi review kodu

---

## 6. Rekomendowana Strategia (Tier approach)

### Tier 1: Inline Suggestions (natychmiast)
- **amazonq.nvim** - darmowy, LSP-based, inline completions
- Integruje się z istniejącym nvim-cmp

### Tier 2: Chat + Code Edit (następny krok)
- **codecompanion.nvim** z Claude jako provider
- Lub **avante.nvim** dla Cursor-like experience (sidebar, diffs)

### Tier 3: AI Diagnostics przez MCP (zaawansowane)
- **mcphub.nvim** jako hub
- **mcp-diagnostics-nvim** do feedowania LSP diagnostyk do AI
- Custom MCP server do wstrzykiwania AI diagnostyk z powrotem do nvim

### Tier 4: Custom LSP-like AI diagnostics (hardcore)
- Napisz custom source dla none-ls.nvim
- Wysyłaj kod do Claude/Q API
- Parsuj odpowiedź jako LSP diagnostyki
- Wyświetlaj inline w nvim jak normalne LSP errors/warnings

---

## 7. Linki

- amazonq.nvim: https://github.com/awslabs/amazonq.nvim
- codecompanion.nvim: https://github.com/olimorris/codecompanion.nvim
- avante.nvim: https://github.com/yetone/avante.nvim
- mcphub.nvim: https://github.com/ravitemer/mcphub.nvim
- nvim-lsp-mcp: https://github.com/trevorprater/nvim-lsp-mcp
- mcp-diagnostics-nvim: https://github.com/georgeharker/mcp-diagnostics-nvim
- copilot-lsp: https://github.com/copilotlsp-nvim/copilot-lsp
- claude.vim: https://github.com/pasky/claude.vim
- none-ls.nvim: https://github.com/nvimtools/none-ls.nvim
