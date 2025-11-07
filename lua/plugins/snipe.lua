return {
  "leath-dub/snipe.nvim",
  keys = {
    { "gb", function() require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu" },
  },
  opts = {
    ui = {
      position = "topleft",
      border = "single",
      preselect_current = true,
      text_align = "left",
      persist_tags = true,
    },
    hints = {
      dictionary = "sadflewcmpghio",
      prefix_key = ".",
    },
    navigate = {
      leader = ",",
      leader_map = {
        ["d"] = function(m, i) require("snipe").close_buf(m, i) end,
        ["v"] = function(m, i) require("snipe").open_vsplit(m, i) end,
        ["h"] = function(m, i) require("snipe").open_split(m, i) end,
      },
      next_page = "J",
      prev_page = "K",
      under_cursor = "<cr>",
      cancel_snipe = "<esc>",
      close_buffer = "D",
      open_vsplit = "V",
      open_split = "H",
    },
    sort = "default",
  },
}
