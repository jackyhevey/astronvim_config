return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  {
    "simrat39/rust-tools.nvim",
    cond = not vim.g.vscode,
    opts = { tools = { inlay_hints = { auto = false } } },
  },
  {
    "m-demare/hlargs.nvim",
    cond = not (vim.g.vscode or vim.g.neovide),
    event = "User AstroFile",
    opts = {
      color = "#FF7A00", --"#ef9062",
      paint_arg_usages = true,
    },
  },
  {
    "Exafunction/codeium.vim",
    cond = not vim.g.vscode,
    event = "LspAttach",
    config = function()
      -- stylua: ignore start
      vim.keymap.set("i", "<C-g>", function() return vim.api.nvim_call_function("codeium#Accept", {}) end, { expr = true })
      vim.keymap.set("i", "<C-;>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {1}) end, { expr = true })
      vim.keymap.set("i", "<C-,>", function() return vim.api.nvim_call_function("codeium#CycleCompletions", {-1}) end, { expr = true })
      vim.keymap.set("i", "<C-x>", function() return vim.api.nvim_call_function("codeium#Clear", {}) end, { expr = true })
      -- stylua: ignore end
      vim.keymap.set("n", "<leader>;", function()
        if vim.g.codeium_enabled == true then
          vim.cmd("CodeiumDisable")
        else
          vim.cmd("CodeiumEnable")
        end
      end, { noremap = true, desc = "Toggle Codeium" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
    event = "User Astrofile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
      aliases = {
        ["b"] = { ")", "}", "]" },
      },
    },
  },
  {
    "echasnovski/mini.ai",
    event = { "User AstroFile", "InsertEnter" },
    opts = {
      silent = true,
      search_method = "cover_or_nearest",
    },
  },
  {
    "mechatroner/rainbow_csv",
    cond = not vim.g.vscode,
    ft = { "csv", "tsv" },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    cond = not vim.g.vscode,
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    config = function(_, opts) require("rainbow-delimiters.setup")(opts) end,
  },
  {
    "luckasRanarison/nvim-devdocs",
    cond = not vim.g.vscode,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    cmd = {
      "DevdocsFetch",
      "DevdocsInstall",
      "DevdocsUninstall",
      "DevdocsOpen",
      "DevdocsOpenFloat",
      "DevdocsUpdate",
      "DevdocsUpdateAll",
    },
  },
  {
    "almo7aya/openingh.nvim",
    cond = not vim.g.vscode,
    cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
    keys = function()
      local prefix = "<leader>g"
      return {
        { prefix .. "o", "<cmd>OpenInGHRepo<CR>", desc = "Open git repo in web", mode = { "n" } },
        { prefix .. "f", "<cmd>OpenInGHFile<CR>", desc = "Open git file in web", mode = { "n" } },
        { prefix .. "f", "<cmd>OpenInGHFileLines<CR>", desc = "Open git lines in web", mode = { "x" } },
      }
    end,
  },
}
