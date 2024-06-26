local is_available = require("astronvim.utils").is_available
return {
  "rebelot/heirline.nvim",
  cond = not vim.g.vscode,
  opts = function(_, opts)
    local status = require("astronvim.utils.status")
    -- custom heirline statusline component for grapple
    status.component.grapple = function()
      return status.component.builder {
        provider = function()
          return "󰛢 " .. require("grapple").name_or_index()
        end,
        condition = function()
          if not is_available("grapple.nvim") then return end
          return require("grapple").exists()
        end,
      }
    end

    status.component.line_end = function()
      return status.component.builder {
        {
          provider = function()
            local map = { ["unix"] = "LF", ["mac"] = "CR", ["dos"] = "CRLF" }
            return map[vim.bo.fileformat]
          end,
        },
        surround = {
          separator = "right",
        },
      }
    end

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
      status.component.grapple(),
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      -- lsp causes issue on mac with tokyonight(https://discord.com/channels/939594913560031363/1100223017017163826)
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.line_end(),
      status.component.nav(),
    }
    return opts
  end,
}
