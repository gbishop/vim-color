# Interactive color editing for vim and tmux

I hate fiddling with 6 hex digits trying to find a color I like. I wrote this
hack to allow me to interactively adjust a color and immediately see it. It uses
the [hsluv](http://www.hsluv.org/) color space using the
[python module](https://github.com/hsluv/hsluv-python).

The vim interface builds on the great
[vim-submode](https://github.com/kana/vim-submode) to allow adjusting the color
and immediately see the effect.

Enter the mode with **gc** and then you can adjust:

- hue with the **h** key
- saturation with **s**
- lightness with **l**
- red with **r**
- green with **g**
- blue with **b**

For each of those the upper case letter decreases and lower case increases.

In addition:

- complement, rotate hue 180 degrees with **c**
- toggle auto execute with **a**
- execute the current line with **e**
- find next color with **n**
- find previous color with **p**

Any other key or Escape will exit the submode.

**Tip**: If you start with a grey color don't expect shifting the hue to do
anything because the saturation is 0. First increase the saturation, then adjust
the hue.

To adjust vim colors position your cursor at the beginning of a color
specification on a highlight command. For example:

```
highlight StatusLine guibg=#b5d4f8 guifg=#000000
```

Position your cursor on the `b` in `#b5d4f8` and type `gc`. You'll enter the
_color_ submode as indicated in the command line. Now you can use the keys above
to adjust the color. Each time you change the color it will grab the line and
execute it so the color will immediately change.

It also works for tmux. In a tmux statement like:

```
set -g window-status-style "fg=#848484 bg=#d9eafb"
```

You can position your cursor on the first `8` after the `#` and activate the
mode. Each time the color changes it executes the line with `tmux` inserted in
front. Again the color changes immediately.
