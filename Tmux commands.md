# Tmux commands

## Create a session
```sh
tmux new -s <session-name>
```

## Rename a session
```sh
tmux rename-session -t <old-session-name> <new-session-name>
```

## List all sessions
```sh
tmux ls
```

## Delete a session
```sh
tmux kill-session -t <session-name>
```

## Attach(Enter) a session
```sh
tmux a -t <session-name>
```

## small window
[Is there any way to redraw tmux window when switching smaller monitor to bigger one?](https://stackoverflow.com/questions/7814612/is-there-any-way-to-redraw-tmux-window-when-switching-smaller-monitor-to-bigger)

Detach any other clients from the sessions when you attach:

```sh
tmux attach -d
```

This could be helpful when your tmux gives you a small window.

# Inside tmux
Press <kbd>Ctrl</kbd> + <kbd>b</kbd> and then do one of the followings.

## Detach(Leave) a session
<kbd>d</kbd>

## Choose which client you want to detach from the session
[Is there any way to redraw tmux window when switching smaller monitor to bigger one?](https://stackoverflow.com/questions/7814612/is-there-any-way-to-redraw-tmux-window-when-switching-smaller-monitor-to-bigger)

<kbd>Shift</kbd> + <kbd>d</kbd>

This could be helpful when your tmux gives you a small window.

## Leave and detach a session
`:kill-session`

## Scroll the screen(page up, page down)
`[` and then <kbd>Page Up</kbd> or <kbd>Page Down</kbd> 

Note that in Mac, <kbd>Page Up</kbd> and <kbd>Page Down</kbd> are <kbd>fn</kbd> + <kbd>↑</kbd> and 
<kbd>fn</kbd> + <kbd>↓</kbd> respectively.

In Windows, using <kbd>Alt</kbd> + <kbd>↑</kbd> and <kbd>Alt</kbd> + <kbd>↓</kbd>.

To leave scroll mode, press <kbd>q</kbd>.

To search(find) through history, press <kbd>Ctrl</kbd> + <kbd>s</kbd>. And then use <kbd>n</kbd> to go next, use <kbd>N</kbd> to go previous.

## Window
### kill window
`&`

### swap window
[How do I reorder tmux windows?](https://superuser.com/questions/343572/how-do-i-reorder-tmux-windows)

`:swap-window -t <target-window-id>`

`:swap-window -s <source-window-id> -t <target-window-id>`

## Panes
split panes horizontally: `"`

split panes vertically: `%`

kill pane: `x`

## Useful link

[tmux Cheat Sheet](https://gist.github.com/michaellihs/b6d46fa460fa5e429ea7ee5ff8794b96)

[tmux cheatsheet](https://gist.github.com/henrik/1967800)

[tmux shortcuts & cheatsheet](https://gist.github.com/MohamedAlaa/2961058)

[Tmux 快捷键 & 速查表](https://gist.github.com/ryerh/14b7c24dfd623ef8edc7)
