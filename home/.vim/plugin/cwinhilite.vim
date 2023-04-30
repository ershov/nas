
" Similar plugins:
"	errormarker.vim		http://www.vim.org/scripts/script.php?script_id=1861
"	hier				http://www.vim.org/scripts/script.php?script_id=3564
"	quickhigh			http://www.vim.org/scripts/script.php?script_id=124

if exists("loaded_CWinHilite")
  finish
endif
let loaded_CWinHilite = 1
if !has("signs")
" echoerr "***sorry*** [".expand("%")."] your vim doesn't support signs"
 finish
endif

hi CWinColColors NONE
if &bg == "dark"
 "highlight CWinColors ctermfg=white ctermbg=red guifg=white guibg=darkred
 highlight CWinColors ctermbg=red guibg=darkred
 hi CWinColColors ctermbg=black guibg=black
else
 highlight CWinColors ctermfg=red guifg=red
endif
sign define CWin linehl=CWinColors texthl=CWinColors
let s:nCWinMarks = 0
let s:texts = {}

"command PutMarks call <plug>PutMarks()
"command RemoveMarks call <plug>RemoveMarks()
"command ToggleMarks call <plug>ToggleMarks()


command PutMarks call g:PutMarks()
command CmarkPut call g:PutMarks()

command RemoveMarks call g:RemoveMarks()
command CmarkClr call g:RemoveMarks()

command ToggleMarks call g:ToggleMarks()
command CmarkToggle call g:ToggleMarks()

command ShowMarkedText call g:ShowMarkedText()
command CmarkShow call g:ShowMarkedText()

nmap <leader>cm :ToggleMarks<CR>
nmap <leader>cv :ShowMarkedText<CR>

fun! g:ToggleMarks()
	if s:nCWinMarks > 0
		echo "Remove " . s:nCWinMarks . " marks"
		call g:RemoveMarks()
	else
		call g:PutMarks()
		echo s:nCWinMarks . " marks"
	endif
endfun

fun! g:PutMarks()
	call g:RemoveMarks()

	let l:idx = 0
	for l:msg in getqflist()
		let l:idx = l:idx + 1
		if (l:msg.bufnr == 0 || l:msg.lnum == 0)
			continue
		endif
		let l:key = msg.bufnr . ":" . msg.lnum
		if !has_key(s:texts, l:key)
			let s:texts[l:key] = [l:idx, msg.text]
		endif
		exec "silent sign place 9999 line=" . msg.lnum . " name=CWin buffer=" . msg.bufnr
		let s:nCWinMarks = s:nCWinMarks + 1
	endfor
endfun

fun! g:RemoveMarks()
"	while s:nCWinMarks > 0
"		sign unplace 9999
"		let s:nCWinMarks = s:nCWinMarks - 1
"	endwhile

	sign unplace *
	let s:nCWinMarks = 0
	let s:texts = {}
endfun

fun! g:ShowMarkedText()
	let l:key = winbufnr(0) . ":" . line(".")
	if has_key(s:texts, l:key)
		exec "silent cc " . s:texts[l:key][0]
		echohl CWinColors | echo s:texts[l:key][1] | echohl None
	else
		echo ""
	endif
endfun

