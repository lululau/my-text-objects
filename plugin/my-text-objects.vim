function! s:SelectOnlyAlphanum(type)
  let saved_iskeyword = &l:iskeyword 
  if a:type ==# "o"
    let &l:iskeyword = "48-57,a-z,A-Z,192-255"
  else
    let &l:iskeyword = "@,48-57,_,128-167,224-235,45"
  endif
  normal viw
  let &l:iskeyword = saved_iskeyword
endfunction

vnoremap <silent> io :<C-U>silent! call s:SelectOnlyAlphanum("o")<CR>
vnoremap <silent> ao :<C-U>silent! call s:SelectOnlyAlphanum("o")<CR>
omap io :normal vio<CR>
omap ao :normal vao<CR>

vnoremap <silent> iO :<C-U>silent! call s:SelectOnlyAlphanum("O")<CR>
vnoremap <silent> aO :<C-U>silent! call s:SelectOnlyAlphanum("O")<CR>
omap iO :normal viO<CR>
omap aO :normal vaO<CR>

