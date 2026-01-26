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

-- Window Navigation
key.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
key.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
key.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
key.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Buffer Navigation
key.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
key.set("n", "<S-Tab>", ":bprev<CR>", { desc = "Previous buffer" })

-- Testing
key.set("n", "<leader>tt", function() require('neotest').run.run() end, { desc = "Test: Run nearest test" })
key.set("n", "<leader>tf", function() require('neotest').run.run(vim.fn.expand("%")) end, { desc = "Test: Run file" })
key.set("n", "<leader>ta", function() require('neotest').run.run({ suite = true }) end, { desc = "Test: Run all tests" })
key.set("n", "<leader>ts", function() require('neotest').summary.toggle() end, { desc = "Test: Toggle summary" })
key.set("n", "<leader>to", function() require('neotest').output.open({ enter = true }) end, { desc = "Test: Show output" })

-- [[ LSP Attach Events (Keymaps & UI) ]]
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, desc = "" }
    
    -- Navigation
    key.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    key.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    key.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
    key.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    
    -- Documentation & Help
    key.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show documentation" }))
    key.set('i', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Show signature help" }))
    
    -- Code Actions
    key.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
    key.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
    
    -- React/TypeScript specific
    key.set('n', '<leader>ci', function() 
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports.ts" } } }) 
    end, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
    key.set('n', '<leader>cf', vim.lsp.buf.format, vim.tbl_extend("force", opts, { desc = "Format document" }))
    
    -- Diagnostics
    key.set('n', '[d', vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    key.set('n', ']d', vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
    key.set('n', '<leader>e', vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
  end,
})

-- UI Polish: Rounded borders for LSP windows
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- [[ Plugins ]]
require("lazy").setup({
  -- Essential Quality of Life
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end
  },

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
        ensure_installed = { "lua", "vim", "javascript", "typescript", "tsx", "ruby", "python", "bash", "markdown", "json", "css", "scss", "html" },
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
      "JoosepAlviste/nvim-ts-context-commentstring",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- 1. Setup Mason
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "ruby_lsp", "pyright", "bashls", "tailwindcss" },
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
        snippet = { 
          expand = function(args) 
            require('luasnip').lsp_expand(args.body)
          end 
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'friendly-snippets' },
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

  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-jest')({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
      })
    end,
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mxsdev/nvim-dap-vscode-js",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npm run compile",
      },
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- TypeScript/JavaScript debugging setup
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
      })

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require'dap.utils'.pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end

      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Debug keybindings
      key.set('n', '<F5', dap.continue, { desc = "Debug: Start/Continue" })
      key.set('n', '<F1>', dap.step_into, { desc = "Debug: Step Into" })
      key.set('n', '<F2>', dap.step_over, { desc = "Debug: Step Over" })
      key.set('n', '<F3>', dap.step_out, { desc = "Debug: Step Out" })
      key.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      key.set('n', '<leader>B', function()
        dap.set_breakpoint(nil, nil, vim.fn.input('Breakpoint condition: '))
      end, { desc = "Debug: Set Breakpoint with Condition" })
    end
  },

  -- Text Objects for better navigation
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end
  },
})
