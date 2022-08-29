if exists('g:loaded_pomodoro') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! PomodoroStartFocus lua require'pomodoro'.start_focus()
command! PomodoroStartBreak lua require'pomodoro'.start_break()
command! PomodoroStartLongBreak lua require'pomodoro'.start_long_break()
command! PomodoroPause lua require'pomodoro'.pause()
command! PomodoroResume lua require'pomodoro'.resume()
command! PomodoroTogglePopup lua require'pomodoro'.toggle_popup()

let &cpo = s:save_cpo
unlet s:save_cpo


let g:loaded_pomodoro = 1
