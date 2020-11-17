" Inspired by:
" eleline
" spacevim
autocmd! bufwritepost ~/.vim/statusline.vim source %

function! ElelineBufnrWinnr() abort
  let l:bufnr = bufnr('%')
   " transform to circled num: nr2char(9311 + l:bufnr)
   let l:bufnr = l:bufnr > 20 ? l:bufnr : nr2char(9311 + l:bufnr).' '
  return l:bufnr.' ❖ '.winnr()
endfunction

function! ElelineFsize(f) abort
  let l:size = getfsize(expand(a:f))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    let size = l:size.' bytes'
  elseif l:size < 1024*1024
    let size = printf('%.1f', l:size/1024.0).'k'
  elseif l:size < 1024*1024*1024
    let size = printf('%.1f', l:size/1024.0/1024.0) . 'm'
  else
    let size = printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
  endif
  return '  '.size.' '
endfunction

function! StatusLine(current, width)

  let l:s = ''

  if a:current
    let l:bufnr_winnr = '%{ElelineBufnrWinnr()}'
    let l:s .= crystalline#mode() . l:bufnr_winnr . crystalline#right_mode_sep('')
    let l:fsize = '%#ElelineFsize#%{ElelineFsize(@%)}%*'
    let l:s .= l:fsize
  else
    let l:s .= '%#CrystallineInactive#'
  endif

  let l:s .= ' %f%h%w%m%r '

  " git
  if a:current
    let l:gbranch = fugitive#head()
    if l:gbranch == ""
        let l:s .= crystalline#right_sep('', 'Fill')
    else
        let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}' . " \ue0a0 "
    endif
  endif


  " coc status
  let l:s .= "%{coc#status()}%{get(b:,'coc_current_function','')}"

  let l:s .= ' %F '
  let l:s .= '%='

  if a:current && a:width > 85
    let l:s .= &spell ? ' SPELL' : ''
    let l:s .= crystalline#left_sep('', 'Fill')
    let l:s .= ' %{&ft} ' .  crystalline#left_mode_sep('') .WebDevIconsGetFileFormatSymbol() . ' %3l:%-2v %3P '
  endif

  return l:s
endfunction

function! TabLine()
    let l:s = ''
    let t = tabpagenr()
    let tabn = tabpagenr('$')
    let i = 1
    while i <= tabn
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let l:s .= '%' . i . 'T'

        " left sep
        if i == t && i > 1
            if mode() == 'n'
                let l:s .= crystalline#right_sep('Fill', 'NormalMode')
            elseif mode() == 'i'
                let l:s .= crystalline#right_sep('Fill', 'InsertMode')
            elseif mode() == 'v'
                let l:s .= crystalline#right_sep('Fill', 'VisualMode')
            elseif mode() == 'r'
                let l:s .= crystalline#right_sep('Fill', 'ReplaceMode')
            endif
        endif

        " tabpagenr
        let l:s .= (i == t ? crystalline#mode_color() : '%#CrystallineFill#')
        let l:s .= ' ' . i

        " filename
        let bufnr = buflist[winnr - 1]
        let buftype = getbufvar(bufnr, '&ft')
        echo buftype
        let file = bufname(bufnr)

        " icon
        let s .= (i == t ? crystalline#mode_color() : '%#CrystallineFill#')
        let l:s .= ' ' . (i == t ? WebDevIconsGetFileTypeSymbol(file) :'')

        if buftype == 'help'
            let file = 'help:' . fnamemodify(file, ':t:r')
        elseif buftype == 'qf'
            let file = 'quickfix'
        elseif buftype == 'nerdtree'
            let file = 'nerdtree'
        elseif buftype == 'nofile'
            if file =~ '\/.'
                let file = substitute(file, '.*\/\ze.', '', '')
            endif
        else
            let file = pathshorten(fnamemodify(file, ':p:t'))
            if getbufvar(bufnr, '&modified')
                let file = '+' . file
            endif
        endif
        if file == ''
            let file = '[No Name]'
        endif
        let l:s .= ' ' . file

        " " windows
        " let nwins = tabpagewinnr(i, '$')
        " if nwins > 1
        "     let modified = ''
        "     for b in buflist
        "         if getbufvar(b, '&modified') && b != bufnr
        "             let modified = '*'
        "             break
        "         endif
        "     endfor
        "     let s .= modified . '(' . winnr . '/' . nwins . ')'
        " endif


        " right sep
        if i==t
            if i == tabn
                let l:s .= crystalline#right_mode_sep('TabFill')
            else
                let l:s .= crystalline#right_mode_sep('Fill')
            endif
        elseif i == tabn
            let l:s .= crystalline#right_sep('Fill','TabFill')
        endif

        let i = i +1
    endwhile
    " X
    let s .= '%T%#CrystallineTabFill#%='
    let s .= (tabn > 1 ? '%999XX' : 'X')
    return l:s
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'gruvbox'
