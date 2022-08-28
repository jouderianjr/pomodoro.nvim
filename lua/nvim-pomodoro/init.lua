local popup_manager = require "nvim-pomodoro.popup"
local utils = require "nvim-pomodoro.utils"

local second = 1000
local minute = 60 * second

local default_notification_opts = { title = "Pomodoro" }

local settings = {
  focus_period = 15 * minute,
  break_period = 5 * minute,
  long_break_period = 15 * minute,
}

local timer, popup, remaining_time

local function start_timer_loop()
  timer = vim.loop.new_timer()

  timer:start(second, second, function()
    remaining_time = remaining_time - second

    if popup_manager.is_active(popup) then
      popup_manager.set_new_timer(popup, remaining_time)
    end

    if remaining_time == 0 then
      timer:close()
      vim.notify("Finished", "alert", default_notification_opts)
    end
  end)
end

local function start_timer(initial_value)
  popup_manager.open(popup)

  remaining_time = initial_value

  popup_manager.set_new_timer(popup, remaining_time)

  start_timer_loop()
end

local function start_focus()
  start_timer(settings.focus_period)
end

local function start_break()
  start_timer(settings.break_period)
end

local function start_long_break()
  start_timer(settings.long_break)
end

local function toggle_popup()
  if popup_manager.is_active(popup) then
    popup = popup_manager.close(popup)
  else
    popup = popup_manager.open(popup)
    popup_manager.set_new_timer(popup, remaining_time)
  end
end

local function resume()
  start_timer_loop()
end

local function pause()
  timer:close()
end

local function get_status()
  vim.notify("Current time: " .. utils.pretiffy_ms(remaining_time), "alert", default_notification_opts)
end

-- Plugin setup
popup = popup_manager.create()

return {
  start_focus = start_focus,
  start_break = start_break,
  start_long_break = start_long_break,
  toggle_popup = toggle_popup,
  pause = pause,
  resume = resume,
  get_status = get_status,
}
