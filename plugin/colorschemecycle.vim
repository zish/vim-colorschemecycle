"--- Functions to cycle through installed Vim colorschemes.
" ColorSchemeCycle
" Maintainer:           Jeremy Melanson <1080872+zish@users.noreply.github.com>
" Version:              1.0
" Date:                 2026-02-26
"
" Usage: <Ctrl-n> = Cycle colorscheme forward ([n]ext)
"        <Ctrl-p> = Cycle colorscheme backward ([p]revious)
"
" ** The above keystrokes can be customized by defining the variables  **
" ** g:csc_next_key and g:csc_previous_key in your ~/.vimrc .          **
"
" Adapted from code found at https://www.reddit.com/r/vim/comments/w4iv6b/comment/ih3rkhf
" ---------------------------------------------------------------------
"
if !exists('g:csc_next_key')
  let g:csc_next_key = "C-n"
endif

if !exists('g:csc_previous_key')
  let g:csc_previous_key = "C-p"
endif

"--- Initialize our Vim keystrokes.
execute "nnoremap \<" . g:csc_next_key . "> :exe \"colo \" .. CycleColors('next')<CR>:color<CR>"
execute "nnoremap \<" . g:csc_previous_key . "> :exe \"colo \" .. CycleColors('prev')<CR>:color<CR>"

"--- Retrieve a list of available colorschemes. We only need to do this when loading the plugin.
let g:csc_colorschemes = getcompletion('', 'color')

func! CycleColors(direction)
  let idx = index(g:csc_colorschemes, g:colors_name)
  if a:direction == "next"
    return (idx + 1 >= len(g:csc_colorschemes) ? g:csc_colorschemes[0] : g:csc_colorschemes[idx + 1])
  elseif a:direction == "prev"
    return (idx - 1 < 0 ? g:csc_colorschemes[-1] : g:csc_colorschemes[idx - 1])
  endif
endfunc
