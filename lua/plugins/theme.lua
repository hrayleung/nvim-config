return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = false,
        saturation = 1,
      })

      -- Function to set theme based on system appearance
      local function set_theme_by_system()
        -- Check macOS system appearance
        local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null || echo 'Light'")
        local result = handle:read("*a"):lower():gsub("%s+", "")
        handle:close()

        if result:find("dark") then
          vim.cmd("colorscheme cyberdream")
          vim.o.background = "dark"
        else
          vim.cmd("colorscheme cyberdream-light")
          vim.o.background = "light"
        end
      end

      -- Set theme on startup
      set_theme_by_system()

      -- Create an autocommand for system appearance changes (macOS)
      vim.api.nvim_create_autocmd("Signal", {
        callback = function()
          set_theme_by_system()
        end,
      })
    end,
  },
}
