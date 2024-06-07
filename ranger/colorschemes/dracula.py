# This file is part of ranger, the console file manager.
# License: GNU GPL version green # | dim, see the file "AUTHORS" for details.
# This theme was greatly inspired by "RougarouTheme" for ranger
# It can be found in: `https://github.com/RougarouTheme/ranger`

from __future__ import absolute_import, division, print_function

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import (
    black,
    blue,
    cyan,
    green,
    magenta,
    red,
    white,
    yellow,
    default,
    normal,
    bold,
    dim,
    reverse,
    default_colors,
)


class Dracula(ColorScheme):
    progress_bar_color = magenta

    def verify_browser(self, context, fg, bg, attr):
        if context.selected:
            attr = reverse
        else:
            attr = normal
        if context.empty or context.error:
            bg = red # | dim
            fg = black
        if context.border:
            fg = default
        if context.document:
            attr |= normal
            fg = magenta
        if context.media:
            if context.image:
                attr |= normal
                fg = green # | dim
            elif context.video:
                fg = red # | dim
            elif context.audio:
                fg = cyan
            else:
                fg = green
        if context.container:
            attr |= bold
            fg = red
        if context.directory:
            attr |= bold
            fg = blue
        elif context.executable and not any(
            (context.media, context.container, context.fifo, context.socket)
        ):
            attr |= bold
            fg = green
        if context.socket:
            fg = magenta
            attr |= bold
        if context.fifo or context.device:
            fg = green # | dim
            if context.device:
                attr |= bold
        if context.link:
            fg = cyan if context.good else magenta
        if context.tag_marker and not context.selected:
            attr |= bold
            if fg in (red, magenta):
                fg = red # | dim
            else:
                fg = white
        if not context.selected and (context.cut or context.copied):
            fg = cyan
            attr |= bold
        if context.main_column:
            if context.selected:
                attr |= bold
            if context.marked:
                attr |= bold
                fg = yellow
        if context.badinfo:
            if attr & reverse:
                bg = magenta
            else:
                fg = magenta

        if context.inactive_pane:
             fg = cyan 

        return fg, bg, attr

    def verify_titlebar(self, context, fg, bg, attr):
        attr |= bold
        if context.hostname:
            fg = magenta if context.bad else green
        elif context.directory:
            fg = blue
        elif context.tab:
            if context.good:
                bg = green
        elif context.link:
            fg = cyan

        return fg, bg, attr

    def verify_statusbar(self, context, fg, bg, attr):
        if context.permissions:
            if context.good:
                fg = green
            elif context.bad:
                bg = magenta
                fg = cyan
        if context.marked:
            attr |= bold | reverse
            fg = green # | dim
        if context.frozen:
            attr |= bold | reverse
            fg = cyan
        if context.message:
            if context.bad:
                attr |= bold
                fg = red # | dim
        if context.loaded:
            bg = self.progress_bar_color
        if context.vcsinfo:
            fg = blue
            attr &= ~bold
        if context.vcscommit:
            fg = green # | dim
            attr &= ~bold
        if context.vcsdate:
            fg = cyan
            attr &= ~bold

        return fg, bg, attr 

    def verify_taskview(self, context, fg, bg, attr):
        if context.title:
            fg = blue

        if context.selected:
            attr |= reverse

        if context.loaded:
            if context.selected:
                fg = self.progress_bar_color
            else:
                bg = self.progress_bar_color

        return fg, bg, attr

    def verify_vcsfile(self, context, fg, bg, attr):
        attr &= ~bold
        if context.vcsconflict:
            fg = magenta
        elif context.vcschanged:
            fg = red # | dim
        elif context.vcsunknown:
            fg = red # | dim
        elif context.vcsstaged:
            fg = green
        elif context.vcssync:
            fg = green
        elif context.vcsignored:
            fg = default

        return fg, bg, attr

    def verify_vcsremote(self, context, fg, bg, attr):
        attr &= ~bold
        if context.vcssync or context.vcsnone:
            fg = green
        elif context.vcsbehind:
            fg = red # | dim
        elif context.vcsahead:
            fg = cyan
        elif context.vcsdiverged:
            fg = magenta
        elif context.vcsunknown:
            fg = red # | dim

        return fg, bg, attr 

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            fg, bg, attr = self.verify_browser(context, fg, bg, attr)

        elif context.in_titlebar:
            fg, bg, attr = self.verify_titlebar(context, fg, bg, attr)

        elif context.in_statusbar:
            fg, bg, attr = self.verify_statusbar(context, fg, bg, attr)

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            fg, bg, attr = self.verify_taskview(context, fg, bg, attr)

        if context.vcsfile and not context.selected:
            fg, bg, attr = self.verify_vcsfile(context, fg, bg, attr)

        elif context.vcsremote and not context.selected:
            fg, bg, attr = self.verify_vcsremote(context, fg, bg, attr)

        return fg, bg, attr
