hi RESET ctermbg=NONE guibg=NONE

function! SetModifiedSymbol(modified)
    if a:modified == 1
        return '* '
    else
        return ''
    endif
endfunction

function! SimpleStatusLine()
    return
        \ "%#StatusLineNC#"
        \ . "%="
        \ . "%.20t\ "
        \ . "%{SetModifiedSymbol(&modified)}"
        \ . "- %l:%c"
        \ . " "
endfunction

"set statusline=%!SimpleStatusLine()
