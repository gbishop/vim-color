"""Interactive color editing for vim"""

import hsluv
import vim
import os
import re

autoexec = True

hexcolor = re.compile(r"[0-9a-f]{6}")


def getColorUnderCursor():
    """Convert hex under cursor to color"""
    cursor = vim.current.window.cursor
    col = cursor[1]
    line = vim.current.line
    if hexcolor.match(line, col):
        w = line[col : col + 6]
        return hsluv.hex_to_hsluv("#" + w)


def replaceColorUnderCursor(r):
    """Replace the hex color"""
    # clip it so functions don't have to
    r[0] = r[0] % 360
    r[1] = max(0, min(100, r[1]))
    r[2] = max(0, min(100, r[2]))
    h = hsluv.hsluv_to_hex(r)
    col = vim.current.window.cursor[1]
    line = vim.current.line
    if hexcolor.match(line, col):
        line = list(line)
        line[col : col + 6] = list(h[1:])
        vim.current.line = "".join(line)
        if autoexec:
            execute()


def withColor(func):
    """Grab a color, modify it, and replace it"""

    def wrapper(**kwargs):
        c = getColorUnderCursor()
        if c:
            r = func(c, **kwargs)
            replaceColorUnderCursor(r)

    return wrapper


@withColor
def complement(c):
    """Complement the color under the cursor"""
    return [c[0] + 180, c[1], c[2]]


@withColor
def lightness(c, amt=5):
    """Change the lightness of the color under the cursor"""
    return [c[0], c[1], c[2] + amt]


@withColor
def saturation(c, amt=5):
    """Change the saturation of the color"""
    return [c[0], c[1] + amt, c[2]]


@withColor
def hue(c, amt=18):
    """Rotate the color"""
    return [c[0] + amt, c[1], c[2]]


@withColor
def channel(c, channel=0, amt=1):
    """Increment a rgb channel"""
    rgb = hsluv.hsluv_to_rgb(c)
    rgb[channel] = max(0, min(1, rgb[channel] + amt / 255))
    return hsluv.rgb_to_hsluv(rgb)


def toggleAutoExecute():
    """Toggle execution of lines on change"""
    global autoexec
    autoexec = not autoexec


def execute():
    """Execute the current line in vim"""
    line = vim.current.line
    ft = vim.eval("&filetype")
    if ft == "vim":
        vim.command(line)
    elif ft == "tmux":
        os.system("tmux " + line)
