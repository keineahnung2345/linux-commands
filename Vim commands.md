# Set vim editor to full screen
```
reset
export TERM=xterm
stty rows 40 cols 120
```

# Vim commands in Visual Mode

## Show and hide line numbers
```
<:set number>: show line numbers
<:unset number>: hide line numbers
```

## Move cursor 
```
<h>: move left
<j>: move down
<k>: move up
<l>: move right
<0>: go to head of line
<$>: go to end of line
<gg>: go to first line
<:$>: go to last line
<ctrl+f>: page down
<ctrl+d>: half page down
<ctrl+b>: page up
<ctrl+u>: half page up
```

## Search a word
Method 1:
```
/\<.*the-word-you-want-to-find.*\>
<n> to find next
<N> to find previous
```
Method 2:
```
move the cursor to the word you want to find
<SHIFT+*> to find the word the cursor at
<SHIFT+#> to find previous
```

## Paste
```
<p>: paste after
<P>: paste before
```

## Copy, Delete a character
```
<y> and then move left: copy the character the cursor move to
<y> and then move right: copy the character the cursor previously at
<x>: delete the current character under the cursor
```

## Copy, Delete a word
```
<yaw>: copy the current word(not character) under the cursor
<daw>: delete the current word(not character) under the cursor
<caw>: delete the current word and put you into insert mode
```

## Copy, Delete a line
```
<yy> or <Y>: copy a line
<dd>: cut a line
```

## Copy, Delete all the file
```
<:%y>: copy all the file
<:%d>: delete all the file
```

## Delete the characters until the end of this line:
```
<D>
```

## Delete the newline character at the end of this line:
```
<J>
```

## Undo and Redo
```
<u> or <:undo>: undo
<Ctrl+R> or <:redo>: redo
```

## Select multiple lines
```
<Shift+V> and then move up or down to select multiple lines
```

## Indent and Unindent
Method 1:
```
<:left 4> or <:le 4>: indent!!
<:right 4>: unindent!!
```

Method 2:
```
:set tabstop=4
:set shiftwidth=4
:set expandtab
and then >(to indent) or <(to unindent)
```

Method 3: to indent
```
:'<,'>s!^!    !
```

## Quit
```
<:q!>
```

## Save and quit
```
<:wq>
```
