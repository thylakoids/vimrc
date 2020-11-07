" Inspired by:
" eleline
" spacevim
autocmd! bufwritepost ~/.vim/statusline.vim source $MYVIMRC

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

  let l:s .= '%='

  if a:current && a:width > 80
    let l:s .= &spell ? ' SPELL' : ''
    let l:s .= crystalline#left_sep('', 'Fill')
    let l:s .= ' %{&ft} ' . crystalline#left_mode_sep('') . ' %3l:%-2v %3P '
  endif

  return l:s
endfunction

function! TabLine()
  return crystalline#bufferline(0, 0, 1)
endfunction

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'gruvbox'

set showtabline=2
