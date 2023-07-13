return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
  },
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    require("orgmode").setup_ts_grammar()
    opts.highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "org" },
    }
    opts.ensure_installed = require("astronvim.utils").list_insert_unique(opts.ensure_installed, {
      "bash",
      "comment",
      "git_config",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "json",
      "json5",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "org",
      "python",
      "passwd",
      "rust",
      "regex",
      "rst",
      "toml",
      "vim",
      "vimdoc",
      "yaml",
    })
    opts.auto_install = vim.fn.executable("tree-sitter") == 1
    opts.matchup = { enable = true }
  end,
}
