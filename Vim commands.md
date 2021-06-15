# Set vim editor to full screen
```
reset
export TERM=xterm
stty rows 40 cols 120
```

# Convert tab to 4 spaces
[vim 把 Tab 轉換為 4 Space](https://www.opencli.com/linux/vim-tab-auto-to-4-space)
```sh
syntax enable
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab 
```

# Merge a .swp file to the original file
[How to merge a swap (.swp) file to the original file?](https://askubuntu.com/questions/1021766/how-to-merge-a-swap-swp-file-to-the-original-file)

```sh
vim .xxx.swp
# in the editor, :recover
rm .xxx.swp
```

# Vim commands in Visual Mode

## Get help message(manual) of a vim command
```
:h <vim-command>
```

## Turn on and off syntax highlight
[How to Turn On or Off Color Syntax Highlighting In vi or vim Editor](https://u.osu.edu/cstutorials/2016/10/28/turn-on-syntax/)
```
:syntax on
:syntax off
```

## Show and hide line numbers
[How To Show or Hide Line Numbers In vi / vim Text Editor](https://www.cyberciti.biz/faq/vi-show-line-numbers/)
```
<:set number> or <:set nu>: show line numbers
<:set nonumber> or <:set nu!>: hide line numbers
```

## Show opened's file's name
[How to find out which file is currently opened in vim?](https://unix.stackexchange.com/questions/104901/how-to-find-out-which-file-is-currently-opened-in-vim)
```
<ctrl+g>: show opened' file's name and its total line number
<1> and then <ctrl+g>: additionally show full path
<2> and then <ctrl+g>: additionally show buffer number
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
<%>: move to matching braces
```

## Find and go to that char in current line
```
<f?>: find the character <?> and move the cursor onto it
<F?>: same as <f?>, but find backward
<t?>: same as <f?>, but stop at the character before <?>
<T?>: same as <t?>, but find backward
```
They can be preceded with a number `<n>`, so the command will be repeated n times.
```
<;>: repeat the previous command
<,>: repeat the previous command in reverse direction
```


## Switch search mode between case-sensitive or case-insensitive
```
<:set ic> or <:set ignorecase>: case-insensitive mode search
<:set noic>: case-sensitive search
```

## Switch to smartcase search mode
[How to do case insensitive search in Vim](https://stackoverflow.com/questions/2287440/how-to-do-case-insensitive-search-in-vim)
```
<:set ic> and then <:set smartcase>
```
If you search for something containing uppercase characters, it will do a case-sensitive search; if you search for something purely lowercase, it will do a case-insensitive search.

## Change the display of long line
[How to stop line breaking in vim](https://stackoverflow.com/questions/2280030/how-to-stop-line-breaking-in-vim/2280059)
Display long line as multiple lines:
```
<:set wrap>
```
Display long line as one line:
```
<:set nowrap>
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


## paste, disable autoindent
[Turning off auto indent when pasting text into vim](https://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim/38258720#38258720)

Before pasting:
```
:set paste
```

After pasting:
```
:set nopaste
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

## Delete all lines after this line
[How to delete line(s) below current line in vim?](https://stackoverflow.com/questions/3624345/how-to-delete-lines-below-current-line-in-vim)
```
:+,$d
```

## Copy selected range to clipboard(so one can paste it outside vim)
First install `vim-gtk`:
```sh
sudo apt-get install vim-gtk
```
Make sure `clipboard` and `xterm_clipboard` are `+` now.
```sh
vim --version | grep clipboard
```
And then:
```sh
"+y
```

## Insert a newline and go to that line
```
<o>
```

## Delete the characters until the end of this line:
```
<D>
```

## Delete the newline character at the end of this line:
```
<J>
```

## Delete character, word, or lines with <d?>
[vim deleting backward tricks](https://stackoverflow.com/questions/1373841/vim-deleting-backward-tricks)
```
<dh>: delete the previous character
<dl>: delete current character
<db>: delete all previous characters in this word
<dw>: delete all later characters in this word, also the following space
<cw>: change(i.e. delete and go to insert mode) all later characters in this word
<diw>: delete current word
<ciw>: change current word
<daw>: delete the current word(word here is the characters between these specific characters: .,-+()[]/\)
<daW>: delete the current token(token here is the characters between spaces, they may contain .,-+()[]/\)
<d0>: delete all previous characters
<d$>: delete from current character to the end of line
```

## Delete characters after a specific character in all lines
[Delete All Characters After “.” In Each Line](https://stackoverflow.com/questions/24111723/delete-all-characters-after-in-each-line)
```
:%norm f<?>lD #<?> is that specific character
```
or 
```
:%s/\<?>.*/<?>/
```

## Delete all lines containing specific word
[Efficient way to delete line containing certain text in vim with prompt](https://stackoverflow.com/questions/46781951/efficient-way-to-delete-line-containing-certain-text-in-vim-with-prompt)
```
:%s/.*<text>.*\n//g
```

## Remove all trailing spaces
[How to automatically strip trailing spaces on save in Vi and Vim?](https://unix.stackexchange.com/questions/75430/how-to-automatically-strip-trailing-spaces-on-save-in-vi-and-vim)
```
:%s/\s\+$//e
```

## Find and Replace
[Vim - Search and replace](https://vim.fandom.com/wiki/Search_and_replace)

Find all 'foo's in the file and replace them with 'bar's.
```
:%s/foo/bar/g
```

[Interactive search/replace regex in Vim?](https://stackoverflow.com/questions/505848/interactive-search-replace-regex-in-vim)

To find and replace one by one with confirmation, use:
```
:%s/foo/bar/gc
```
And then use `y` to confirm, `n` to skip, `Esc` to quit.

To escape / and \\, add \ before them, they becomes: \\/ and \\\\.

To replace trailing spaces:

[Remove unwanted spaces](https://vim.fandom.com/wiki/Remove_unwanted_spaces)
```
:%s/\s\+$//c
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

To indent the whole file:

[How do I fix the indentation of an entire file in Vi?](https://stackoverflow.com/questions/506075/how-do-i-fix-the-indentation-of-an-entire-file-in-vi)
```
gg=G''
```

## Comment multiple lines
[What's a quick way to comment/uncomment lines in Vim?](https://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim)

<kbd>Ctrl</kbd> + <kbd>v</kbd> to go into visual mode, select multiple lines, and then:
```
:'<,'>s/^/#/
```

Note that `'<,'>` appears automatically after `:` is entered.

## Dispose of "\ No newline at end of file"
[VIM Disable Automatic Newline At End Of File](https://stackoverflow.com/questions/1050640/vim-disable-automatic-newline-at-end-of-file)

```sh
vim -b file.txt
:set noeol
:wq
```

## Quit
```
<:q!>
```

## Save and quit
```
<:wq>
```
