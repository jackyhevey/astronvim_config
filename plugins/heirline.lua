local is_available = require("astronvim.utils").is_available
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astronvim.utils.status")
    -- custom heirline statusline component for harpoon
    status.component.harpoon_index = {
      provider = function()
        if not is_available("harpoon") then return end
        local marked = require("harpoon.mark")
        local filename = vim.api.nvim_buf_get_name(0)
        local ok, index = pcall(marked.get_index_of, filename)
        if ok and index and index > 0 then
          return "󱡀 " .. index .. " "
        else
          return
        end
      end,
    }
    -- custom heirline statusline component for grapple
    status.component.grapple = {
      provider = function()
        if not is_available("grapple.nvim") then return end
        local grapple = require("grapple")
        local key = grapple.key { buffer = 0 }
        if key ~= nil then return " " .. key .. " " end
      end,
    }

    opts.tabline = nil
    opts.statusline = {
      -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = { padding = { left = 1, right = 1 } },
      }, -- add the mode text
      status.component.file_info {
        filetype = {},
        filename = false,
      },
      status.component.builder {
        { provider = function() return vim.bo.fenc end },
        surround = {
          separator = "left",
          condition = function() return vim.bo.fenc ~= "utf-8" end,
        },
        hl = { fg = "orange" },
        update = "BufModifiedSet",
      },
      status.component.git_branch(),
      status.component.harpoon_index,
      status.component.grapple,
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.builder {
        {
          provider = function()
            local map = { ["unix"] = "LF", ["mac"] = "CR", ["dos"] = "CRLF" }
            return map[vim.bo.fileformat]
          end,
        },
        surround = {
          separator = "right",
        },
      },
      status.component.nav(),
    }
    return opts
  end,
}
