function! s:SelectOnlyAlphanum()
  let saved_iskeyword = &l:iskeyword 
  let &l:iskeyword = "48-57,a-z,A-Z,192-255"
  normal viw
  let &l:iskeyword = saved_iskeyword
endfunction

function! s:SelectDash()
  let saved_iskeyword = &l:iskeyword 
  let &l:iskeyword = "@,48-57,_,128-167,224-235,45"
  normal viw
  let &l:iskeyword = saved_iskeyword
endfunction

vnoremap <silent> io :<C-U>silent! call <SID>SelectOnlyAlphanum()<CR>
vnoremap <silent> ao :<C-U>silent! call <SID>SelectOnlyAlphanum()<CR>
omap io :normal vio<CR>
omap ao :normal vao<CR>

vnoremap <silent> iO :<C-U>silent! call <SID>SelectDash()<CR>
vnoremap <silent> aO :<C-U>silent! call <SID>SelectDash()<CR>
omap iO :normal viO<CR>
omap aO :normal vaO<CR>
