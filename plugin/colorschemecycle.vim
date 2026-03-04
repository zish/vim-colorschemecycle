" Functions to cycle through installed Vim colorschemes.
" ColorSchemeCycle
" Maintainer:           Jeremy Melanson <1080872+zish@users.noreply.github.com>
" Version:              1.01
" Date:                 2026-03-02
"
" Usage: <Ctrl-n> = Cycle colorscheme forward ([n]ext)
"        <Ctrl-p> = Cycle colorscheme backward ([p]revious)
"
" ** The above keystrokes can be customized by defining the variables  **
" ** g:csc_next_key and g:csc_previous_key in your ~/.vimrc .          **
"
" Adapted from code found at https://www.reddit.com/r/vim/comments/w4iv6b/comment/ih3rkhf
" ---------------------------------------------------------------------

" Retrieve a list of available colorschemes. We only need to do this when loading the plugin.
"
let s:csc_colorschemes = getcompletion('', 'color')

func! CycleColors(direction)
  let idx = index(s:csc_colorschemes, g:colors_name)
  if a:direction == "n"
    return (idx + 1 >= len(s:csc_colorschemes) ? s:csc_colorschemes[0] : s:csc_colorschemes[idx + 1])
  elseif a:direction == "p"
    let new_scheme = (idx - 1 < 0 ? s:csc_colorschemes[-1] : s:csc_colorschemes[idx - 1])
    return new_scheme
  endif
endfunc

function! SaveColorSchemeState(quiet)
  call writefile([g:colors_name], g:csc_save_file)
  if a:quiet == 0
    echo "Saved colorscheme."
  endif
endfunction

if !exists('g:csc_next_key')
  let g:csc_next_key = "C-n"
endif

if !exists('g:csc_previous_key')
  let g:csc_previous_key = "C-p"
endif

if !exists('g:csc_save_file')
	if has('nvim')
	  let g:csc_save_file = stdpath('config') . '/csc.save'
	else
	  let g:csc_save_file = $HOME . '/.vim/csc.save'
	endif
endif

" If g:csc_autosave is set to 'true', Vim will automatically call
" SaveColorSchemeState() any time when the ':colorscheme' command is invoked.
"
if !exists('g:csc_autosave')
  let g:csc_autosave = 'false'
endif

if g:csc_autosave == 'true'
  autocmd ColorScheme * call SaveColorSchemeState(1)
endif

" This is the default Vim : command name to save the current colorscheme to
" the save file.
"
if !exists('g:csc_save_command')
  let g:csc_save_command = 'SC'
endif

" Read the saved colorscheme from the file if it exists.
" To stop this plugin setting the colorscheme while loading, you will need to
" remove the file specified by g:csc_save_file
"
" Use ':echo g:csc_save_file' to get the location of the file.
"
if filereadable(g:csc_save_file)
  let file_lines = readfile(g:csc_save_file)
  execute 'colorscheme ' . file_lines[0]
endif

" Initialize our Vim keystrokes.
"
execute "nnoremap \<" . g:csc_next_key . "> :exe \"colo \" .. CycleColors('n')<CR>:color<CR>"
execute "nnoremap \<" . g:csc_previous_key . "> :exe \"colo \" .. CycleColors('p')<CR>:color<CR>"

execute "command " . g:csc_save_command . " call SaveColorSchemeState(0)"
