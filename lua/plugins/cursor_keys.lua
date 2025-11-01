-- Plugins to support Cursor-style keybindings
return {
  -- nvim-spectre for project-wide search and replace (like Cmd+Alt+F in Cursor)
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = {
      open_cmd = "vnew",
      live_update = false,
      line_sep_start = "┌-----------------------------------------",
      result_padding = "¦  ",
      line_sep = "└-----------------------------------------",
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
      },
    },
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").toggle()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  -- vim-visual-multi for multi-cursor support (like Cmd+D in Cursor/VS Code)
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      -- Configure vim-visual-multi settings before plugin loads
      vim.g.VM_mouse_mappings = 1
      vim.g.VM_theme = "iceblue"
      vim.g.VM_highlight_matches = "underline"

      -- Set custom maps - we'll override the defaults for Cmd+D style behavior
      vim.g.VM_maps = {
        ["Find Under"] = "",
        ["Find Subword Under"] = "",
        ["Select All"] = "",
        ["Start Regex Search"] = "",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
      }
    end,
    config = function()
      -- Additional configuration after plugin is loaded
      -- The actual keybindings are set in keymaps.lua to support both Cmd and Alt variants
    end,
  },
}
