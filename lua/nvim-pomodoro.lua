local second = 1000
local minute = 60 * second

local notification_title = "Pomodoro"

local default_notification_opts = { title = notification_title }

local settings = {
  focus_period = 10 * second,
  -- focus_period = 25 * minute,
  break_period = 5 * minute
}

local FOCUS_STATUS = "focus_status"
local BREAK_STATUS = "break_status"
local PAUSED_STATUS = "PAUSED_STATUS"
local NOT_READY_STATUS = "NOT_READY_STATUS"

local timer

local status = NOT_READY_STATUS
local remaining_time = settings.focus_period

local function set_initial_period()
  if status == NOT_READY_STATUS then
    remaining_time = settings.focus_period
  elseif status == FOCUS_STATUS then
    remaining_time = settings.break_period
  end

  print("set initial period" .. remaining_time)
end

local function start_timer()
  timer = vim.loop.new_timer()

  set_initial_period()

  if status == NOT_READY_STATUS then
    status = FOCUS_STATUS
  elseif status == FOCUS_STATUS then
    status = BREAK_STATUS
  end

  vim.notify("Pomodoro started", "alert", default_notification_opts)

  timer:start(second, second, function()
    remaining_time = remaining_time - second

    print(remaining_time)

    if remaining_time == 0 then
      timer:close()

      vim.notify(status .. " finished", "alert", default_notification_opts)
    end
  end)
end

local function pause_timer()
  timer:close()
  status = PAUSED_STATUS

  vim.notify(
    "Pomodoro paused at " .. remaining_time, "alert",
    default_notification_opts
  )
end

local function get_status()
  vim.notify(
    "Current time: " .. remaining_time, "alert",
    default_notification_opts
  )
end

return {
  start_timer = start_timer,
  pause_timer = pause_timer,
  resume_timer = start_timer,
  get_status = get_status

}
