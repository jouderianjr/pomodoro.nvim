local M = {}

local function pad_left(num, required_len)
  local num_len = tostring(num):len()

  return ("0"):rep(required_len - num_len) .. num
end

M.pretiffy_ms = function(time)
  local minutes = math.floor((time / 1000) / 60)
  local seconds = math.fmod((time / 1000), 60)

  return pad_left(minutes, 2) .. ":" .. pad_left(seconds, 2)
end

return M
