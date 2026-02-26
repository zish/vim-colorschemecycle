# Vim ColorSchemeCycle

Provides a mechanism in which the user can cycle through locally-installed
Vim ColorSchemes.

![Example Demonstration](https://github.com/zish/vim-colorschemecycle/blob/c40324150092e5c9de7c317f25057bc8bd5b2249/doc/example.gif "Example Demonstration of ColorSchemeCycle in action")

Adapted from some code I found at https://www.reddit.com/r/vim/comments/w4iv6b/comment/ih3rkhf

## Keystrokes

The default keystrokes defined are:
- <CTRL-n> Load the 'next' available ColorScheme.
- <CTRL-p> Load the 'previous' available ColorScheme.

These keystrokes can be customized by defining g:csc\_next\_key and
g:csc\_previous\_key variables in your .vimrc file.

### Custom Keystroke Examples:

```
" Use <CTRL-SHIFT-k> and <CTRL-k>
let g:csc_next_key = "C-S-k"
let g:csc_previous_key = "C-k"
```

```
" Defaults:
let g:csc_next_key = "C-n"
let g:csc_previous_key = "C-p"
```
