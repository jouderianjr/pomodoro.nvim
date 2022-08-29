local utils = require "nvim-pomodoro.utils"
local M = {}

M.create = function()
  return { window = nil, buffer = nil }
end

M.open = function(popup)
  if M.is_active(popup) then
    return popup
  else
    popup.buffer = vim.api.nvim_create_buf(false, true)

    -- TODO: Check this option
    vim.api.nvim_buf_set_option(popup.buffer, "bufhidden", "wipe")

    local width = 21
    local height = 1

    local win_width = vim.api.nvim_get_option "columns"

    local opts = {
      style = "minimal",
      relative = "editor",
      border = "double",
      width = width,
      height = height,
      row = 0,
      col = win_width - width,
    }

    popup.window = vim.api.nvim_open_win(popup.buffer, false, opts)

    return popup
  end
end

M.close = function(popup)
  vim.api.nvim_win_close(popup.window, true)

  return { window = nil, buffer = nil }
end

M.set_new_timer = function(popup, remaining_time)
  vim.schedule(function()
    vim.api.nvim_buf_set_lines(popup.buffer, -2, -1, true, { "Remaining time: " .. utils.pretiffy_ms(remaining_time) })
  end)
end

M.is_active = function(popup)
  return popup.window ~= nil and popup.buffer ~= nil
end

return M
