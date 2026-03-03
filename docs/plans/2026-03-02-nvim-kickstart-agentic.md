# Neovim Kickstart + Agentic Coding Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace the current nvim config with stock kickstart.nvim, add Copilot completions via blink.cmp, and optimize for agentic coding alongside Claude Code.

**Architecture:** Single-file init.lua based on kickstart.nvim. Customizations layered on top: Catppuccin theme, Copilot as a blink.cmp source, auto-reload for external file changes, diffview.nvim for reviewing diffs, oil.nvim for filesystem navigation. LSP configured for TypeScript/JavaScript with Tailwind CSS.

**Tech Stack:** Neovim, lazy.nvim, blink.cmp, copilot.lua, blink-cmp-copilot, diffview.nvim, oil.nvim, catppuccin/nvim, Mason, conform.nvim

---

### Task 1: Replace init.lua with stock kickstart.nvim

**Files:**
- Overwrite: `config/nvim/.config/nvim/init.lua`
- Delete: `config/nvim/.config/nvim/lazy-lock.json`

**Step 1: Download stock kickstart.nvim init.lua**

Run:
```bash
curl -sL https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua > config/nvim/.config/nvim/init.lua
```

**Step 2: Delete lazy-lock.json**

Run:
```bash
rm config/nvim/.config/nvim/lazy-lock.json
```

**Step 3: Enable Nerd Font**

The Ghostty terminal uses a Nerd Font. Change line ~94 from:
```lua
vim.g.have_nerd_font = false
```
to:
```lua
vim.g.have_nerd_font = true
```

**Step 4: Enable relative line numbers**

Uncomment relative line numbers (around line 105). Change:
```lua
-- vim.o.relativenumber = true
```
to:
```lua
vim.o.relativenumber = true
```

**Step 5: Commit**

```bash
git add config/nvim/.config/nvim/init.lua
git rm config/nvim/.config/nvim/lazy-lock.json
git commit -m "feat(nvim): replace custom config with stock kickstart.nvim"
```

---

### Task 2: Swap theme to Catppuccin Macchiato

**Files:**
- Modify: `config/nvim/.config/nvim/init.lua` (the colorscheme plugin block)

**Step 1: Replace the tokyonight plugin block**

Find this block (around lines 804-824):
```lua
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
```

Replace with:
```lua
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'macchiato',
      transparent_background = true,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
```

**Step 2: Commit**

```bash
git add config/nvim/.config/nvim/init.lua
git commit -m "feat(nvim): swap tokyonight for catppuccin macchiato theme"
```

---

### Task 3: Add Copilot integration via blink.cmp

**Files:**
- Modify: `config/nvim/.config/nvim/init.lua` (add copilot plugin + modify blink.cmp config)

**Step 1: Add copilot.lua plugin**

Add this plugin block after the catppuccin block (but before the closing of the lazy.setup call):
```lua
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
```

**Step 2: Add blink-cmp-copilot as a dependency of blink.cmp**

In the blink.cmp plugin block, add `blink-cmp-copilot` to the dependencies list. Find:
```lua
  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
```

Add after the existing dependencies (after the LuaSnip block's closing `},`):
```lua
      { 'giuxtaposition/blink-cmp-copilot' },
```

**Step 3: Add copilot as a blink.cmp source**

In the blink.cmp `opts.sources` section, change:
```lua
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
```
to:
```lua
      sources = {
        default = { 'lsp', 'path', 'snippets', 'copilot' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-cmp-copilot',
            score_offset = 100,
            async = true,
          },
        },
      },
```

**Step 4: Commit**

```bash
git add config/nvim/.config/nvim/init.lua
git commit -m "feat(nvim): add GitHub Copilot completions via blink.cmp"
```

---

### Task 4: Add auto-reload for external file changes

**Files:**
- Modify: `config/nvim/.config/nvim/init.lua` (add autocommand in the autocommands section)

**Step 1: Add auto-reload autocommand**

After the existing `TextYankPost` autocommand block (around line 231), add:
```lua
-- Auto-reload files changed externally (e.g. by Claude Code)
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  desc = 'Auto-reload files changed outside of Neovim',
  group = vim.api.nvim_create_augroup('kickstart-auto-reload', { clear = true }),
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})
```

**Step 2: Commit**

```bash
git add config/nvim/.config/nvim/init.lua
git commit -m "feat(nvim): add auto-reload for external file changes"
```

---

### Task 5: Add diffview.nvim

**Files:**
- Modify: `config/nvim/.config/nvim/init.lua` (add plugin block)

**Step 1: Add diffview.nvim plugin**

Add this plugin block in the lazy.setup call (after gitsigns is a logical spot):
```lua
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = '[G]it [D]iff view' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = '[G]it File [H]istory' },
    },
    opts = {},
  },
```

**Step 2: Register the git group in which-key**

In the which-key `spec` table, add:
```lua
        { '<leader>g', group = '[G]it' },
```

**Step 3: Commit**

```bash
git add config/nvim/.config/nvim/init.lua
git commit -m "feat(nvim): add diffview.nvim for reviewing changes"
```

---

### Task 6: Add oil.nvim

**Files:**
- Modify: `config/nvim/.config/nvim/init.lua` (add plugin block)

**Step 1: Add oil.nvim plugin**

Add this plugin block in the lazy.setup call:
```lua
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<CR>', desc = 'Open parent directory' },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
```

**Step 2: Commit**

```bash
git add config/nvim/.config/nvim/init.lua
git commit -m "feat(nvim): add oil.nvim for filesystem navigation"
```

---

### Task 7: Configure LSP servers and formatters for TypeScript

**Files:**
- Modify: `config/nvim/.config/nvim/init.lua` (servers table + conform formatters)

**Step 1: Add TypeScript LSP servers**

In the `servers` table inside the nvim-lspconfig config function, add `ts_ls` and `tailwindcss`. The table should look like:
```lua
      local servers = {
        ts_ls = {},
        tailwindcss = {},
        eslint = {},
        stylua = {},
        lua_ls = {
          -- ... existing lua_ls config stays the same
        },
      }
```

**Step 2: Add prettier to Mason ensure_installed**

After `local ensure_installed = vim.tbl_keys(servers or {})`, in the `vim.list_extend` call, add prettier:
```lua
      vim.list_extend(ensure_installed, {
        'prettier',
      })
```

**Step 3: Add prettier as formatter for JS/TS files**

In the conform.nvim `formatters_by_ft` table, add:
```lua
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        json = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
```

**Step 4: Add Treesitter parsers for JS/TS**

In the treesitter config, extend the parsers list. Find:
```lua
      local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
```

Replace with:
```lua
      local parsers = { 'bash', 'c', 'css', 'diff', 'html', 'javascript', 'json', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'tsx', 'typescript', 'vim', 'vimdoc' }
```

**Step 5: Commit**

```bash
git add config/nvim/.config/nvim/init.lua
git commit -m "feat(nvim): configure LSP, formatters, and parsers for TypeScript"
```

---

### Task 8: Verify the configuration

**Step 1: Launch Neovim and check for errors**

Run:
```bash
nvim --headless "+Lazy! sync" +qa
```

Expected: Lazy installs all plugins without errors.

**Step 2: Check health**

Run:
```bash
nvim --headless "+checkhealth" +qa 2>&1 | head -50
```

Review output for any critical errors.

**Step 3: Update CLAUDE.md**

Update the nvim-related sections in CLAUDE.md to reflect the new kickstart-based configuration. Mention key plugins (blink.cmp, copilot, diffview, oil) and the keymaps.

**Step 4: Final commit**

```bash
git add CLAUDE.md
git commit -m "docs: update CLAUDE.md for kickstart.nvim configuration"
```
