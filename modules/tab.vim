function! MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
    return empty(string) ? '[unnamed]' : string
endfunction

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
    " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#Error#'
        else
            let s .= '%#Comment#'
        endif
        let s .= ' '. (i+1) . ' '
        " the label is made by MyTabLabel()
        let s .= '%#Normal# %{MyTabLabel(' . (i + 1) . ')} '
        if i+1 < tabpagenr('$')
            let s .= ' '
        endif
    endfor
    let s.= '%#CursorLine#'
    return s
endfunction
set tabline=%!MyTabLine()
