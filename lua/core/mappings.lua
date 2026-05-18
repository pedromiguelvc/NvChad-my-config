-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },

    -- return to normal mode
    ["jk"] = { "<Esc>", "Return to normal mode" },
  },

  n = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    -- adding blank lines
    ["zj"] = { "o<Esc>k", "Add blank line below" },
    ["zk"] = { "O<Esc>j", "Add blank line above" },

    -- better nevegation scroll
    ["<Up>"] = { "3<C-y>", "Scroll window up" },
    ["<Down>"] = { "3<C-e>", "Scroll window down" },

    -- Move lines
    ["<A-j>"] = { "<cmd> m .+1<CR>==", "Move line down" },
    ["<A-k>"] = { "<cmd> m .-2<CR>==", "Move line up" },

    -- break the line
    ["gj"] = { "i<CR><Esc>", "Split line at cursor" },

    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- Resize windows
    ["<C-Up>"] = { "<cmd> resize +2 <CR>", "Decrease vertical window size" },
    ["<C-Down>"] = { "<cmd> resize -2 <CR>", "Increase vertical window size" },
    ["<C-Right>"] = { "<cmd> vertical resize +2 <CR>", "Increase horizontal window size" },
    ["<C-Left>"] = { "<cmd> vertical resize -2 <CR>", "Decrease horizontal window size" },

    -- Copy
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
    ["<C-y>"] = { '"+yy', "Copy line" },

    -- Navigation
    ["<C-d>"] = { "<C-d>zz", "Scroll down half screen" },
    ["<C-u>"] = { "<C-u>zz", "Scroll up half screen" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },

    -- manage buffers
    ["<leader>x"] = { "<cmd> bdelete <CR>", "Close current buffer" },
    ["<Tab>"] = { "<cmd> bnext <CR>", "Go to next buffer" },
    ["<S-Tab>"] = { "<cmd> bprevious <CR>", "Go to previous buffer" },

    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    -- folding
    ["<leader>fc"] = {
      function()
        vim.wo.foldcolumn = (vim.wo.foldcolumn == "0") and "1" or "0"
      end,
      "Toggle fold column",
    },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
    ["<C-y>"] = { '"+y', "Copy to clipboard register" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["<C-w>gd"] = {
      function()
        vim.cmd "vsplit"
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover {
          border = "rounded",
          max_width = 80,
          max_height = 20,
        }
      end,
      "LSP hover",
    },

    ["gl"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["<leader>e"] = {
      function()
        vim.diagnostic.open_float { border = nil, source = true }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.jump { count = -1 }
      end,
      "Goto prev diagnostic",
    },

    ["]d"] = {
      function()
        vim.diagnostic.jump { count = 1 }
      end,
      "Goto next diagnostic",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },
  },
}

M.treesj = {
  n = {
    ["<leader>tj"] = { "<cmd> TSJToggle <CR>", "Toggle TJS" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep_args <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<leader>fe"] = { "<cmd> Telescope file_browser <CR>", "Open File Browser" },
    ["<leader>fn"] = { "<cmd> Telescope noice <CR>", "Noice History" },
    ["<leader>fl"] = { "<cmd> Telescope resume <CR>", "Telescope last search" },

    ["<leader>fd"] = { -- Custom find directorie
      function()
        local telescope = require "telescope"
        local finders = require "telescope.finders"
        local pickers = require "telescope.pickers"
        local conf = require("telescope.config").values
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"
        local previewers = require "telescope.previewers"
        local entry_display = require "telescope.pickers.entry_display"

        local folder_hl = "TelescopeResultsIdentifier"
        local folder_icon = ""

        local displayer = entry_display.create {
          separator = " ",
          items = {
            { width = 3 }, -- icon
            { remaining = true }, -- path
          },
        }

        local function make_display(entry)
          return displayer {
            { folder_icon, folder_hl },
            { entry.value, "TelescopeResultsIdentifier" },
          }
        end

        local function entry_maker(line)
          return {
            value = line,
            display = make_display,
            ordinal = line,
          }
        end

        local dir_previewer = previewers.new_termopen_previewer {
          title = "Directory Contents",
          get_command = function(entry)
            return {
              "eza",
              "--icons",
              "--group-directories-first",
              "--color=always",
              "-la",
              entry.value,
            }
          end,
        }

        pickers
          .new({}, {
            prompt_title = "Find Directory",
            -- Inherits your layout_config from defaults automatically
            finder = finders.new_oneshot_job(
              { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
              { entry_maker = entry_maker }
            ),
            sorter = conf.file_sorter {},
            previewer = dir_previewer,
            attach_mappings = function(prompt_bufnr)
              actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection then
                  telescope.extensions.file_browser.file_browser { path = selection.value }
                end
              end)
              return true
            end,
          })
          :find()
      end,
      "Find directory → file_browser",
    },

    -- git
    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- ui
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    -- lsp
    ["<leader>ci"] = { "<cmd> Telescope lsp_incoming_calls <CR>", "Telescope incoming calls" },
    ["<leader>co"] = { "<cmd> Telescope lsp_outgoing_calls <CR>", "Telescope outgoing calls" },
    ["<leader>di"] = { "<cmd> Telescope diagnostics <CR>", "Telescope diagnostics" },
    ["<leader>fr"] = { "<cmd> Telescope lsp_references <CR>", "Telescope references" },
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "Find Symbols" },
    ["<leader>ws"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "Workspace symbols" },

    -- vim marks, registers and jumplist
    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "Telescope bookmarks" },
    ["<leader>rg"] = { "<cmd> Telescope registers <CR>", "Telescope registers" },
    ["<leader>jl"] = { "<cmd> Telescope jumplist <CR>", "Telescope jumplist" },
  },
}

M.whichkey = {
  plugin = false,

  n = {
    ["<leader>wk"] = { "<cmd> WhichKey <CR>", "Whichkey maps" },
  },
}

M.lazygit = {
  plugin = false,

  n = {
    ["<leader>lg"] = { "<cmd> LazyGit <CR>", "Open LazyGit" },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>sh"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Toggle Stage hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.leap = {
  n = {
    ["s"] = { "<Plug>(leap-anywhere)", "Leap forward" },
  },
  o = {
    ["s"] = { "<Plug>(leap-anywhere)", "Leap forward" },
  },
}

M.inc_rename = {
  n = {
    ["<leader>rn"] = {
      function()
        return ":IncRename " .. vim.fn.expand "<cword>"
      end,
      "Incremental rename",
      opts = { expr = true },
    },
  },
  v = {
    ["<leader>rn"] = {
      function()
        return ":IncRename " .. vim.fn.expand "<cword>"
      end,
      "LSP rename",
    },
  },
}

return M
