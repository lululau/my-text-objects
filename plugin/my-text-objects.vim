" Text object for words contains only alpanum. 
function! s:SelectOnlyAlphanum()
  let saved_iskeyword = &l:iskeyword 
  let &l:iskeyword = "48-57,a-z,A-Z,192-255"
  normal viw
  let &l:iskeyword = saved_iskeyword
endfunction

vnoremap <silent> io :<C-U>silent! call <SID>SelectOnlyAlphanum()<CR>
vnoremap <silent> ao :<C-U>silent! call <SID>SelectOnlyAlphanum()<CR>
omap io :normal vio<CR>
omap ao :normal vao<CR>

" Text Object for words contains dash sign
function! s:SelectDash()
  let saved_iskeyword = &l:iskeyword 
  let &l:iskeyword = "@,48-57,_,128-167,224-235,45"
  normal viw
  let &l:iskeyword = saved_iskeyword
endfunction

vnoremap <silent> iO :<C-U>silent! call <SID>SelectDash()<CR>
vnoremap <silent> aO :<C-U>silent! call <SID>SelectDash()<CR>
omap iO :normal viO<CR>
omap aO :normal vaO<CR>

function! s:SelectSameMatchLines(pattern)
  let curr_line = line(".")
  let first_non_white_char = matchstr(getline("."), a:pattern)
  if first_non_white_char ==# ''
    return
  endif
  let i = 0
  while 1
    let char = matchstr(getline(curr_line + i + 1), a:pattern)
    if char ==# first_non_white_char
      let i += 1
      continue
    else
      break
    endif
  endwhile

  let j = 0
  while 1
    let char = matchstr(getline(curr_line + j - 1), a:pattern)
    if char ==# first_non_white_char
      let j -= 1
      continue
    else
      break
    endif
  endwhile

  if j < 0
    execute "normal " . (-j) . "k"
    normal V
    execute "normal " . (i - j) . "j"
  else
    if i > 0
      execute "normal V". i . "j"
    else
      normal V
    endif
  endif

endfunction

" Text object for lines which have same first non-white character/word
function! s:SelectSameBeginningLines(word)
  if a:word ==# 'a'
    call s:SelectSameMatchLines('^\s*\w\+')
  else
    call s:SelectSameMatchLines('^\s*\w')
  endif
endfunction

vnoremap <silent> i^ :<C-U>silent! call <SID>SelectSameBeginningLines("i")<CR>
vnoremap <silent> a^ :<C-U>silent! call <SID>SelectSameBeginningLines("a")<CR>
vnoremap <silent> i& :<C-U>silent! call <SID>SelectSameMatchLines('^\s*\S')<CR>
vnoremap <silent> a& :<C-U>silent! call <SID>SelectSameMatchLines('^\s*\S\+')<CR>
omap i^ :normal Vi^<CR>
omap a^ :normal Va^<CR>
omap i& :normal Vi&<CR>
omap a& :normal Va&<CR>

" Text object for lines which have same last non-white character/word
function! s:SelectSameEndLines(word)
  if a:word ==# 'a'
    call s:SelectSameMatchLines('\w\+\s*$')
  else
    call s:SelectSameMatchLines('\w\s*$')
  endif
endfunction

vnoremap <silent> i$ :<C-U>silent! call <SID>SelectSameEndLines("i")<CR>
vnoremap <silent> a$ :<C-U>silent! call <SID>SelectSameEndLines("a")<CR>
vnoremap <silent> i% :<C-U>silent! call <SID>SelectSameMatchLines('\S\s*$')<CR>
vnoremap <silent> a% :<C-U>silent! call <SID>SelectSameMatchLines('\S\+\s*$')<CR>
omap i$ :normal Vi$<CR>
omap a$ :normal Va$<CR>
omap i% :normal Vi%<CR>
omap a% :normal Va%<CR>
