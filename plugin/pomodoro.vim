if exists('g:loaded_pomodoro') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! Pomodoro lua require'pomodoro'.test()

let &cpo = s:save_cpo
unlet s:save_cpo


let g:loaded_pomodoro = 1
