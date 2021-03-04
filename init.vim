if has("win64") || has("win32") || has("win16")
    let g:os = "windows"
    let g:python3_host_prog='C:\\Python39\\python.EXE'
else
    let g:os = "unix"
endif

function! Dot(path)
    if g:os == "windows"
        return '~/AppData/Local/nvim/' . a:path
    return '~/.config/nvim/' . a:path
endfunction

function! LoadDotFileIfExist(file)
    if !empty(glob(Dot(a:file)))
        execute 'source ' . Dot(a:file)
    endif
endfunction

command! SourceVimrc execute 'source ' . g:init_file
command! OpenVimrc execute 'e ' . g:init_file

call LoadDotFileIfExist('modules/general.vim')
call LoadDotFileIfExist('modules/mapping.vim')
call LoadDotFileIfExist('modules/tab.vim')
call LoadDotFileIfExist('modules/statusline.vim')
call LoadDotFileIfExist('modules/ui.vim')
call LoadDotFileIfExist('modules/local.vim')
call LoadDotFileIfExist('modules/plugins.vim')
call LoadDotFileIfExist('modules/colors.vim')
