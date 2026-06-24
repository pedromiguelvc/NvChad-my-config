local ts = require "nvim-treesitter.configs"

ts.setup {
  ensure_installed = {
    -- Main Languages
    "c",
    "cpp",
    "python",
    "go",

    -- Config Languages
    "lua",

    -- Auxiliar Languanges
    "markdown",
    "markdown_inline",
    "vim",
    "regex",
    "bash",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = {
    enable = true,
  },

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
        ["ax"] = "@conditional.outer",
        ["ix"] = "@conditional.inner",
        ["ar"] = "@loop.outer",
        ["ir"] = "@loop.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = false,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]x"] = "@conditional.outer",
        ["]r"] = "@loop.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[x"] = "@conditional.outer",
        ["[r"] = "@loop.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = { ["<leader>a"] = "@parameter.inner" },
      swap_previous = { ["<leader>A"] = "@parameter.inner" },
    },
  },
}
