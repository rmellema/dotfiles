" Use same indent as previous line
setlocal expandtab
" With a tabsize of two
setlocal shiftwidth=4
setlocal softtabstop=4

" Enable syntax folding
" setlocal foldmethod=syntax

" set the maximal length of a line to 100 characters, so the lines on the
" screen sort of match the lines in the pdf
setlocal cc=101
setlocal textwidth=101
setlocal formatoptions+=t
setlocal spell

" Set the correct settings for Latex-Box
let g:LatexBox_latexmk_async=0
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=2
let g:LatexBox_viewer="open -a Skim"

let g:todoregex = ['\\\\rewrite', '\\\\fixdate', '\\\\tdwait', '\\\\reconsider', '\\\\mayfix']

" Create a "latex-search" mapping for use with skim
map <silent> <Leader>ls :silent
  \ !/Applications/Skim.app/Contents/SharedSupport/displayline
  \ <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>"
  \ "%:p" <CR>
