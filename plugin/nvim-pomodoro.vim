if exists('g:loaded_nvim_pomodoro') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! NvimPomodoro lua require'nvim-pomodoro'.test()

let &cpo = s:save_cpo
unlet s:save_cpo


let g:loaded_nvim_pomodoro = 1
