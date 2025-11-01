return {
  "yetone/avante.nvim",
  build = "make",
  event = "VeryLazy",
  version = false,
  opts = {
    instructions_file = "avante.md",
    provider = "claude",
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-5",
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 64000,
        },
      },
      fireworks = {
        __inherited_from = "openai",
        api_key_name = "FIREWORKS_API_KEY",
        endpoint = "https://api.fireworks.ai/inference/v1",
        model = "accounts/fireworks/models/kimi-k2-instruct-0905",
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 32768,
        },
      },
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
