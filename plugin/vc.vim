" Live editing of colors for Vim and Tmux
"
" Put your cursor on the 6-digit hex color formated like f0ab23 and
" enter the submode with gc. Then you can change the color with
" these keys
"
" c - complement the color (rotate hue 180 degrees)
" l - lighten the color
" L - darken the color
" s - increase the saturation
" S - decrease the saturation
" h - increase the hue angle (wraps at 360)
" H - decrease the hue angle
" r - increase the red channel of the rgb
" R - decrease the red channel
" g - increase the green channel
" G - decrease the green channel
" b - increase blue channel
" B - decrease blue channel
" a - toggle auto execute of the line in vim or tmux files
" e - execute the line in vim or tmux
" n - move to the next such color
" p - move to previous
"
" load the python code
let s:pyscript = resolve(expand('<sfile>:p:h')) . '/vc.py'
execute 'py3file ' . s:pyscript

" dont time out
let g:submode_timeout = 0
" don't eat the last key
let g:submode_keep_leaving_key = 1
" enter the mode with gc
call submode#enter_with('color', 'n', 's', 'gc')
call submode#map('color', 'n', 's', 'c', ':py3 complement()<CR>')
call submode#map('color', 'n', 's', 'l', ':py3 lightness(amt=2)<CR>')
call submode#map('color', 'n', 's', 'L', ':py3 lightness(amt=-2)<CR>')
call submode#map('color', 'n', 's', 's', ':py3 saturation(amt=2)<CR>')
call submode#map('color', 'n', 's', 'S', ':py3 saturation(amt=-2)<CR>')
call submode#map('color', 'n', 's', 'h', ':py3 hue(amt=6)<CR>')
call submode#map('color', 'n', 's', 'H', ':py3 hue(amt=-6)<CR>')
call submode#map('color', 'n', 's', 'r', ':py3 channel(channel=0, amt=1)<CR>')
call submode#map('color', 'n', 's', 'R', ':py3 channel(channel=0, amt=-1)<CR>')
call submode#map('color', 'n', 's', 'g', ':py3 channel(channel=1, amt=1)<CR>')
call submode#map('color', 'n', 's', 'G', ':py3 channel(channel=1, amt=-1)<CR>')
call submode#map('color', 'n', 's', 'b', ':py3 channel(channel=2, amt=1)<CR>')
call submode#map('color', 'n', 's', 'B', ':py3 channel(channel=2, amt=-1)<CR>')
call submode#map('color', 'n', 's', 'a', ':py3 toggleAutoExecute()<CR>')
call submode#map('color', 'n', 's', 'e', ':py3 execute()<CR>')
call submode#map('color', 'n', 's', 'n', '/[0-9a-f]\{6}<CR>')
call submode#map('color', 'n', 's', 'p', '?[0-9a-f]\{6}<CR>')

