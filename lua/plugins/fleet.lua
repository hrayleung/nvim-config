return {
  {
    "razcoen/fleet.nvim",
    priority = 1000,
  },
  {
    "f-person/auto-dark-mode.nvim",
    cond = vim.fn.has("mac") == 0,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.opt.background = "dark"
        vim.cmd.colorscheme("fleet")
      end,
      set_light_mode = function()
        vim.opt.background = "light"
        vim.cmd.colorscheme("fleet")
      end,
    },
  },
  {
    "cormacrelf/dark-notify",
    cond = vim.fn.has("mac") == 1,
    config = function()
      require("dark_notify").run({
        schemes = {
          dark = {
            background = "dark",
            colorscheme = "fleet",
          },
          light = {
            background = "light",
            colorscheme = "fleet",
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "fleet",
    },
  },
}
