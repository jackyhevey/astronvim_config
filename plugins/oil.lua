return {
  "stevearc/oil.nvim",
  config = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "-",
      function()
        return require("oil").open()
      end,
      desc = "Open parent directory",
    },
  },
  init = function()
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      -- Capture the protocol and lazy load oil if it is "oil-ssh", besides also lazy
      -- loading it when the first argument is a directory.
      local adapter = string.match(vim.fn.argv(0), "^([%l-]*)://")
      if (stat and stat.type == "directory") or adapter == "oil-ssh" then
        require("lazy").load { plugins = { "oil.nvim" } }
      end
    end
    if not require("lazy.core.config").plugins["oil.nvim"]._.loaded then
      vim.api.nvim_create_autocmd("BufNew", {
        callback = function()
          if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
            require("lazy").load { plugins = { "oil.nvim" } }
            -- Once oil is loaded, we can delete this autocmd
            return true
          end
        end,
      })
    end
  end,
  opts = {
    skip_confirm_for_simple_edits = true,
    delete_to_trash = true,
    trash_command = "trash",
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["gx"] = {
        callback = function()
          local oil = require("oil")
          local cwd = oil.get_current_dir()
          local entry = oil.get_cursor_entry()
          if cwd and entry then
            local os_name = vim.uv.os_uname().sysname
            if os_name == "Darwin" then
              vim.fn.jobstart {
                "open",
                string.format("%s/%s", cwd, entry.name),
              }
            elseif os_name == "Linux" then
              vim.fn.jobstart {
                "xdg-open",
                string.format("%s/%s", cwd, entry.name),
              }
            else
              return
            end
          end
        end,
        desc = "Open file under cursor",
        nowait = true,
      },
    },
  },
}