-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local is_mac = vim.loop.os_uname().sysname == "Darwin"

-- Helper function to safely set keymaps
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Helper function to wrap pcall for keymaps that might fail
local function safe_map(mode, lhs, rhs, opts)
  pcall(function()
    map(mode, lhs, rhs, opts)
  end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- macOS Command Key Bindings (Cursor/VS Code style)
-- ═══════════════════════════════════════════════════════════════════════════

if is_mac then
  -- File operations
  safe_map("n", "<D-p>", function()
    require("telescope.builtin").find_files()
  end, { desc = "Find Files (Cmd+P)" })

  safe_map("n", "<D-P>", function()
    require("telescope.builtin").commands()
  end, { desc = "Command Palette (Cmd+Shift+P)" })

  -- Sidebar/Explorer
  safe_map("n", "<D-b>", function()
    vim.cmd("Neotree toggle")
  end, { desc = "Toggle Neo-tree (Cmd+B)" })

  -- Buffer operations
  safe_map("n", "<D-t>", function()
    require("telescope.builtin").buffers()
  end, { desc = "Switch Buffers (Cmd+T)" })

  safe_map("n", "<D-`>", "<C-^>", { desc = "Toggle Last Buffer (Cmd+`)" })

  safe_map("n", "<D-w>", function()
    local buf = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_buf_get_option(buf, "modified")
    if modified then
      local choice = vim.fn.confirm("Buffer has unsaved changes. Save?", "&Yes\n&No\n&Cancel", 3)
      if choice == 1 then -- Yes
        vim.cmd("write")
        vim.cmd("bdelete")
      elseif choice == 2 then -- No
        vim.cmd("bdelete!")
      end
      -- Cancel does nothing
    else
      vim.cmd("bdelete")
    end
  end, { desc = "Close Buffer (Cmd+W)" })

  safe_map("n", "<D-]>", function()
    vim.cmd("BufferLineCycleNext")
  end, { desc = "Next Buffer (Cmd+])" })

  safe_map("n", "<D-[>", function()
    vim.cmd("BufferLineCyclePrev")
  end, { desc = "Previous Buffer (Cmd+[)" })

  -- Go to buffer by number (Cmd+1 through Cmd+9)
  for i = 1, 9 do
    safe_map("n", "<D-" .. i .. ">", function()
      vim.cmd("BufferLineGoToBuffer " .. i)
    end, { desc = "Go to Buffer " .. i })
  end

  -- Window splits
  safe_map("n", "<D-\\>", "<cmd>vsplit<cr>", { desc = "Vertical Split (Cmd+\\)" })
  safe_map("n", "<D-=>", "<cmd>split<cr>", { desc = "Horizontal Split (Cmd+=)" })

  -- Search operations
  safe_map("n", "<D-f>", function()
    -- Start search with current word under cursor
    local word = vim.fn.expand("<cword>")
    if word ~= "" then
      vim.fn.setreg("/", word)
      vim.cmd("set hlsearch")
      vim.cmd("normal! n")
    else
      vim.cmd("normal! /")
    end
  end, { desc = "In-file Search (Cmd+F)" })

  safe_map("n", "<D-F>", function()
    require("telescope.builtin").live_grep()
  end, { desc = "Project Search (Cmd+Shift+F)" })

  safe_map("n", "<D-M-f>", function()
    require("spectre").toggle()
  end, { desc = "Project Replace (Cmd+Alt+F)" })

  safe_map("n", "<D-A-f>", function()
    require("spectre").toggle()
  end, { desc = "Project Replace (Cmd+Alt+F)" })

  -- LSP operations
  safe_map("n", "<D-r>", function()
    vim.lsp.buf.rename()
  end, { desc = "Rename Symbol (Cmd+R)" })

  safe_map("n", "<D-.>", function()
    vim.lsp.buf.code_action()
  end, { desc = "Code Action (Cmd+.)" })

  safe_map("n", "<D-k>", function()
    vim.lsp.buf.hover()
  end, { desc = "Hover Documentation (Cmd+K)" })

  safe_map("n", "<D-g>", function()
    require("telescope.builtin").lsp_definitions()
  end, { desc = "Go to Definition (Cmd+G)" })

  -- Multi-cursor operations (vim-visual-multi)
  -- <D-d> to select next occurrence (like Cmd+D in VS Code)
  safe_map({ "n", "v" }, "<D-d>", "<Plug>(VM-Find-Under)", { desc = "Select Next Occurrence (Cmd+D)" })

  -- <D-S-d> to skip current and select next (like Cmd+K Cmd+D in VS Code)
  safe_map({ "n", "v" }, "<D-S-k>", "<Plug>(VM-Skip-Region)", { desc = "Skip and Select Next (Cmd+Shift+K)" })

  -- <D-S-l> or <D-S-d> for selecting all occurrences (like Cmd+Shift+L in VS Code)
  safe_map({ "n", "v" }, "<D-S-l>", "<Plug>(VM-Select-All)", { desc = "Select All Occurrences (Cmd+Shift+L)" })

  -- Additional multi-cursor controls
  safe_map("n", "<D-M-Down>", "<Plug>(VM-Add-Cursor-Down)", { desc = "Add Cursor Down (Cmd+Alt+Down)" })
  safe_map("n", "<D-M-Up>", "<Plug>(VM-Add-Cursor-Up)", { desc = "Add Cursor Up (Cmd+Alt+Up)" })
end

-- ═══════════════════════════════════════════════════════════════════════════
-- Option/Alt Key Fallbacks (for terminals that don't pass Command key)
-- ═══════════════════════════════════════════════════════════════════════════

-- File operations
map("n", "<M-p>", function()
  require("telescope.builtin").find_files()
end, { desc = "Find Files (Alt+P)" })

map("n", "<M-P>", function()
  require("telescope.builtin").commands()
end, { desc = "Command Palette (Alt+Shift+P)" })

-- Sidebar/Explorer
map("n", "<M-b>", function()
  vim.cmd("Neotree toggle")
end, { desc = "Toggle Neo-tree (Alt+B)" })

-- Buffer operations
map("n", "<M-t>", function()
  require("telescope.builtin").buffers()
end, { desc = "Switch Buffers (Alt+T)" })

map("n", "<M-w>", function()
  local buf = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(buf, "modified")
  if modified then
    local choice = vim.fn.confirm("Buffer has unsaved changes. Save?", "&Yes\n&No\n&Cancel", 3)
    if choice == 1 then
      vim.cmd("write")
      vim.cmd("bdelete")
    elseif choice == 2 then
      vim.cmd("bdelete!")
    end
  else
    vim.cmd("bdelete")
  end
end, { desc = "Close Buffer (Alt+W)" })

map("n", "<M-]>", function()
  vim.cmd("BufferLineCycleNext")
end, { desc = "Next Buffer (Alt+])" })

map("n", "<M-[>", function()
  vim.cmd("BufferLineCyclePrev")
end, { desc = "Previous Buffer (Alt+[)" })

-- Window splits
map("n", "<M-\\>", "<cmd>vsplit<cr>", { desc = "Vertical Split (Alt+\\)" })
map("n", "<M-=>", "<cmd>split<cr>", { desc = "Horizontal Split (Alt+=)" })

-- Search operations
map("n", "<M-f>", function()
  local word = vim.fn.expand("<cword>")
  if word ~= "" then
    vim.fn.setreg("/", word)
    vim.cmd("set hlsearch")
    vim.cmd("normal! n")
  else
    vim.cmd("normal! /")
  end
end, { desc = "In-file Search (Alt+F)" })

map("n", "<M-F>", function()
  require("telescope.builtin").live_grep()
end, { desc = "Project Search (Alt+Shift+F)" })

map("n", "<M-S-f>", function()
  require("spectre").toggle()
end, { desc = "Project Replace (Alt+Shift+F)" })

-- LSP operations
map("n", "<M-r>", function()
  vim.lsp.buf.rename()
end, { desc = "Rename Symbol (Alt+R)" })

map("n", "<M-.>", function()
  vim.lsp.buf.code_action()
end, { desc = "Code Action (Alt+.)" })

map("n", "<M-k>", function()
  vim.lsp.buf.hover()
end, { desc = "Hover Documentation (Alt+K)" })

map("n", "<M-g>", function()
  require("telescope.builtin").lsp_definitions()
end, { desc = "Go to Definition (Alt+G)" })

-- Multi-cursor operations (vim-visual-multi)
-- <M-d> to select next occurrence (Alt fallback for Cmd+D)
map({ "n", "v" }, "<M-d>", "<Plug>(VM-Find-Under)", { desc = "Select Next Occurrence (Alt+D)" })

-- <M-S-k> to skip current and select next
map({ "n", "v" }, "<M-S-k>", "<Plug>(VM-Skip-Region)", { desc = "Skip and Select Next (Alt+Shift+K)" })

-- <M-S-l> for selecting all occurrences (Alt fallback for Cmd+Shift+L)
map({ "n", "v" }, "<M-S-l>", "<Plug>(VM-Select-All)", { desc = "Select All Occurrences (Alt+Shift+L)" })

-- Additional multi-cursor controls with Alt
map("n", "<M-Down>", "<Plug>(VM-Add-Cursor-Down)", { desc = "Add Cursor Down (Alt+Down)" })
map("n", "<M-Up>", "<Plug>(VM-Add-Cursor-Up)", { desc = "Add Cursor Up (Alt+Up)" })
