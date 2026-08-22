-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local plugins = {

  "nvim-lua/plenary.nvim",

  {
    "NvChad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
    config = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "NvChad/ui",
    lazy = false,
    config = function()
      require "nvchad"
    end,
  },

  "nvzone/volt",
  "nvzone/menu",
  { "nvzone/minty", cmd = { "Huefy", "Shades" } },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return { override = require "nvchad.icons.devicons" }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "devicons")
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSUpdate", "TSUninstall", "TSLog" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    config = function()
      dofile(vim.g.base46_cache .. "syntax")

      local ts = require "plugins.configs.treesitter"
      ts.ensure_parsers_installed()
      ts.setup_highlight_indent()

      require("nvim-treesitter-textobjects").setup {
        select = ts.textobjects_select,
      }

      local select = require "nvim-treesitter-textobjects.select"
      local move = require "nvim-treesitter-textobjects.move"
      local swap = require "nvim-treesitter-textobjects.swap"

      local function map_select(keys, query)
        vim.keymap.set({ "x", "o" }, keys, function()
          select.select_textobject(query, "textobjects")
        end)
      end

      map_select("af", "@function.outer")
      map_select("if", "@function.inner")
      map_select("ac", "@class.outer")
      map_select("ic", "@class.inner")
      map_select("aa", "@parameter.outer")
      map_select("ia", "@parameter.inner")
      map_select("ax", "@conditional.outer")
      map_select("ix", "@conditional.inner")
      map_select("ar", "@loop.outer")
      map_select("ir", "@loop.inner")
      map_select("ab", "@block.outer")
      map_select("ib", "@block.inner")

      local function map_move(keys, fn, query)
        vim.keymap.set({ "n", "x", "o" }, keys, function()
          fn(query, "textobjects")
        end)
      end

      map_move("]f", move.goto_next_start, "@function.outer")
      map_move("]]", move.goto_next_start, "@class.outer")
      map_move("]x", move.goto_next_start, "@conditional.outer")
      map_move("]r", move.goto_next_start, "@loop.outer")

      map_move("[f", move.goto_previous_start, "@function.outer")
      map_move("[[", move.goto_previous_start, "@class.outer")
      map_move("[x", move.goto_previous_start, "@conditional.outer")
      map_move("[r", move.goto_previous_start, "@loop.outer")

      vim.keymap.set("n", "<leader>a", function()
        swap.swap_next "@parameter.inner"
      end)
      vim.keymap.set("n", "<leader>A", function()
        swap.swap_previous "@parameter.inner"
      end)
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts = function()
      return require "plugins.configs.gitsigns"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "saghen/blink.cmp",
    version = "*", -- use a prebuilt release (avoids needing rust/cargo)
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function()
          require "plugins.configs.snip"
        end,
      },

      -- autopairing of (){}[] etc; blink.cmp handles bracket-insertion on
      -- completion accept itself (completion.accept.auto_brackets), so no
      -- extra cmp-specific hook is needed here anymore.
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
      },
    },
    opts = function()
      return require "plugins.configs.blink"
    end,
    opts_extend = { "sources.default" },
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-symbols.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    cmd = "Telescope",
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    event = "BufEnter",
    cmd = "WhichKey",
    config = function()
      return require "plugins.configs.which_key"
    end,
  },

  {
    "https://codeberg.org/andyg/leap.nvim",
    lazy = false,
    config = function()
      return require "plugins.configs.leap"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      return require "plugins.configs.lualine"
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      return require "plugins.configs.noice"
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },

  {
    "nguyenvukhang/nvim-toggler",
    lazy = false,
    config = function()
      return require "plugins.configs.toggler"
    end,
  },

  -- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
  },

  {
    "stevearc/conform.nvim", -- For autoformatting on save
    event = "VeryLazy",
    config = function()
      require "plugins.configs.conform"
    end,
  },

  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    config = function()
      return require "plugins.configs.inc_rename"
    end,
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    event = "LspAttach",
    config = function()
      require "plugins.configs.treesj"
    end,
  },
}

require("lazy").setup(plugins, require "plugins.configs.lazy_nvim")
