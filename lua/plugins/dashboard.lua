return {
  "glepnir/dashboard-nvim",
  enabled = true,
  event = "VimEnter",
  opts = function()
    local logo = [[
|       \                   
| ▓▓▓▓▓▓▓\ ______  __    __ 
| ▓▓__| ▓▓|      \|  \  |  \
| ▓▓    ▓▓ \▓▓▓▓▓▓\ ▓▓  | ▓▓
| ▓▓▓▓▓▓▓\/      ▓▓ ▓▓  | ▓▓
| ▓▓  | ▓▓  ▓▓▓▓▓▓▓ ▓▓__/ ▓▓
| ▓▓  | ▓▓\▓▓    ▓▓\▓▓    ▓▓
 \▓▓   \▓▓ \▓▓▓▓▓▓▓_\▓▓▓▓▓▓▓
                  |  \__| ▓▓
                   \▓▓    ▓▓
                    \▓▓▓▓▓▓
    ]]

    local footer = "Welcome to Your Orange ASCII Dashboard"

    local opts = {
      theme = "doom",
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
          { action = "lua require('snipe').open_buffer_menu()",                  desc = " Snipe Buffers",   icon = "📄 ", key = "b" },
          { action = "lua require('telescope.builtin').oldfiles()",              desc = " Recent files",    icon = "🕒 ", key = "r" },
          { action = "Telescope projects",                                       desc = " Projects",        icon = "📁 ", key = "p" },
        },
        footer = vim.split(footer, "\n"),
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
}
