" Use same indent as previous line
setlocal expandtab
" With a tabsize of two
setlocal shiftwidth=3
setlocal softtabstop=3

let g:pandoc_command = "pandoc -f markdown -o "

" Make the text wrap automagically
setlocal textwidth=90
setlocal formatoptions+=t
setlocal spell

" Lets build a Pandoc command!
function! PandocFunc(ext)
	let resFile = expand("%:p:r") . "." . a:ext
	"silent !pandoc -f markdown -o %:t:r.a:ext %:t
	execute "silent !".g:pandoc_command.resFile." ".bufname("%")
	redraw!
endfunction
command! -nargs=1 Pandoc call PandocFunc(<args>)
