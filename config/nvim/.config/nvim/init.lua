-- [[ Bootstrap Lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Global Settings ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.wrap = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.termguicolors = true
opt.updatetime = 250
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- [[ Keymaps ]]
local key = vim.keymap
key.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
key.set("n", "<leader>x", ":bp|bd #<CR>", { desc = "Close buffer, keep split" })
key.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- [[ LSP Attach Events (Keymaps & UI) ]]
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    key.set('n', 'gd', vim.lsp.buf.definition, opts)
    key.set('n', 'K', vim.lsp.buf.hover, opts)
    key.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    key.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  end,
})

-- UI Polish: Rounded borders for LSP windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- [[ Plugins ]]
require("lazy").setup({
  -- Appearance
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { theme = "catppuccin" } },
  },

  -- Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "javascript", "typescript", "tsx", "ruby", "python", "bash", "markdown" },
        highlight = { enable = true },
      })
    end,
  },

  -- LSP & Formatting (The Modern Config)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "stevearc/conform.nvim",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- 1. Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "ruby_lsp", "pyright", "bashls" },
      })

      -- 2. Modern LSP Config (v0.11+ style)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local servers = { "ts_ls", "ruby_lsp", "pyright", "bashls" }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      -- 3. Auto-tagging for JSX/TSX
      require("nvim-ts-autotag").setup()

      -- 4. Formatting on Save
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          ruby = { "rubocop" },
          python = { "black" },
          sh = { "shfmt" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
      })

      -- 5. Autocompletion Engine
      local cmp = require('cmp')
      cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        })
      })
    end
  },

  -- Navigation & Git
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Search" },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
})
