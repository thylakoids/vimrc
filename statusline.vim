function! g:GroupSuffix()
  if mode() ==# 'i' && &paste
    return '2'
  endif
  if &modified
    return '1'
  endif
  return ''
endfunction

function! g:CrystallineStatuslineFn(winnr)
  let g:crystalline_group_suffix = g:GroupSuffix()
  let l:curr = a:winnr == winnr()
  let l:s = ''

  if l:curr
    let l:s .= crystalline#ModeSection(0, 'A', 'B')
  else
    let l:s .= crystalline#HiItem('Fill')
  endif
  let l:s .= ' %f%h%w%m%r '
  if l:curr
    let l:s .= crystalline#Sep(0, 'B', 'Fill') . ' %{fugitive#Head()}'
  endif

  let l:s .= '%='
  if l:curr
    let l:s .= crystalline#Sep(1, 'Fill', 'B') . '%{&paste ? " PASTE " : " "}'
    let l:s .= crystalline#Sep(1, 'B', 'A')
  endif
  if winwidth(a:winnr) > 80
    let l:s .= ' %{&ft} %l/%L %2v '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! g:CrystallineTablineFn()
  let l:max_width = &columns
  let l:right = '%='

  let l:right .= crystalline#Sep(1, 'TabFill', 'TabType')
  let l:max_width -= 1

  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  let l:right .= l:vimlabel
  let l:max_width -= strchars(l:vimlabel)

  let l:max_tabs = 23

  return crystalline#DefaultTabline({
        \ 'enable_sep': 1,
        \ 'max_tabs': l:max_tabs,
        \ 'max_width': l:max_width
        \ }) . l:right
endfunction

set showtabline=2
set guioptions-=e
set laststatus=2
let g:crystalline_auto_prefix_groups = 1
