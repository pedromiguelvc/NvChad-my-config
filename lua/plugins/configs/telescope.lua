local telescope = require "telescope"
local actions = require "telescope.actions"
local fb_actions = require "telescope._extensions.file_browser.actions"
local live_grep_args_actions = require "telescope-live-grep-args.actions"

local function close_buffer(prompt_bufnr)
  local sucess, err = pcall(actions.delete_buffer, prompt_bufnr)

  if not sucess then
    print("Error: This buffer cannot be closed! (" .. err .. ")")
  end
end

local function select_and_center(prompt_bufnr)
  actions.select_default(prompt_bufnr)
  vim.schedule(function()
    vim.cmd "normal! zz"
  end)
end

local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = "  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "normal",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.65,
        results_width = 0.35,
      },
      vertical = {
        mirror = false,
      },
      width = 0.95,
      height = 0.85,
      preview_cutoff = 0,
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    path_display = { shorten = { len = 2, exclude = { -1, -2 } } },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    mappings = {
      n = {
        ["<CR>"] = select_and_center,
        ["q"] = actions.close,
        ["x"] = close_buffer,
        ["<C-h>"] = actions.file_split,
        ["<Up>"] = actions.cycle_history_prev,
        ["<Down>"] = actions.cycle_history_next,
      },
      i = {
        ["<CR>"] = select_and_center,
      },
    },
  },

  pickers = {
    oldfiles = { cwd_only = true },
    find_files = { initial_mode = "insert" },
    live_grep = { initial_mode = "insert" },
    grep_string = { initial_mode = "insert" },
    current_buffer_fuzzy_find = { initial_mode = "insert" },
    lsp_document_symbols = { initial_mode = "insert" },
    lsp_dynamic_workspace_symbols = { initial_mode = "insert" },
  },

  extensions_list = { "themes", "terms", "fzf", "live_grep_args", "file_browser", "lazygit" },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      lazy = true,
      case_mode = "smart_case",
    },
    file_browser = {
      dir_icon = "",
      path = "%:p:h",
      select_buffer = true,
      grouped = true,
      mappings = {
        n = {
          ["<bs>"] = fb_actions.goto_parent_dir, -- g is the default
          ["."] = fb_actions.toggle_hidden,
          ["e"] = false,
          ["h"] = false,
        },
        i = {
          ["<bs>"] = false, -- Unbinding backspace
        },
      },
    },
  },
}

for _, extension in ipairs(options.extensions_list) do
  telescope.load_extension(extension)
end

return options
