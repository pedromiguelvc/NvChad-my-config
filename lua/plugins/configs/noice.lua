local noice = require "noice"

noice.setup {
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    progress = { enabled = false },
    hover = {
      enabled = true,
      silent = true,
      opts = {
        border = { style = "rounded" },
        position = { row = 2 },
        size = {
          max_height = 20,
          max_width = 80,
        },
      },
    },
    signature = {
      enabled = true,
      opts = {
        size = {
          max_height = 10,
          max_width = 80,
        },
      },
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  routes = {
    { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
    { filter = { event = "msg_showcmd", kind = "cmdline" }, opts = { skip = true } },
    { filter = { event = "msg_show", find = "search hit BOTTOM" }, opts = { skip = true } },
    { filter = { event = "msg_show", find = "search hit TOP" }, opts = { skip = true } },
    { filter = { event = "msg_show", find = "%d+ lines yanked" }, opts = { skip = true } },
    { filter = { event = "msg_show", kind = "wmsg" }, opts = { skip = true } },
    { filter = { event = "notify", min_height = 1 }, view = "mini", opts = { skip = false } },
  },
  messages = { enabled = true },
  popupmenu = { enabled = true },
  commands = {
    history = {
      -- options for the message history that you get with `:Noice`
      opts = { enter = true, format = "details" },
      filter = {
        any = {
          { event = "notify" },
          { error = true },
          { warning = true },
          { event = "msg_show", kind = { "" } },
          { event = "lsp", kind = "message" },
        },
      },
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = true, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
}
