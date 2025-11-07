return {
  "wakatime/vim-wakatime",
  event = "VeryLazy",
  -- WakaTime works out of the box, but you can configure it here if needed
  opts = {
    -- Uncomment and set your WakaTime API key if you want to override the default
    -- wakatime_api_key = "your-api-key-here",
    
    -- Optional: Disable verbose logging
    -- wakatime_log_file = vim.fn.stdpath("data") .. "/wakatime.log",
  },
}
