return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- Copy absolute path
      {
        "<leader>yp",
        function()
          local path = vim.fn.expand("%:p")
          vim.fn.setreg("+", path)
          vim.notify("Copied absolute path: " .. path, vim.log.levels.INFO)
        end,
        desc = "Copy absolute path",
      },
      -- Copy relative path
      {
        "<leader>yr",
        function()
          local path = vim.fn.expand("%:.")
          vim.fn.setreg("+", path)
          vim.notify("Copied relative path: " .. path, vim.log.levels.INFO)
        end,
        desc = "Copy relative path",
      },
    },
  },
}
