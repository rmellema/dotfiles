""""""""""
" Plugins "
""""""""""
set nocompatible

" Plugin 'lepture/vim-jinja'
" Plugin 'posva/vim-vue'
" Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Plugin 'lervag/vimtex'
" Plugin 'keith/swift.vim'
" Plugin 'elixir-editors/vim-elixir'

""""""""""""""""""""""""
" General ViM settings "
""""""""""""""""""""""""
set t_Co=256
if has("gui_running")
  colorscheme jellybeans
else
  colorscheme pt_black
endif

" Search using ddg instead of man
set keywordprg=ddg

" Make the command line completion more Bash like
set wildmode=longest,list,full
set wildmenu

" Ignore certain files for tab completion
" Images
set wildignore=*.pdf,*.png,*.jpg
" Binary files
set wildignore+=*.pyc,*.out
" TeX auxcilliary files
set wildignore+=*.aux,*.bbl,*.bcf,*.blg,*.fdb_latexmk,*.fls
set wildignore+=*.idx,*.ilg,*.ind
set wildignore+=*.latexmain,*.run.xml,*.synctex.gz,*.synctex(busy),*.toc,*.tdo
" Log files (have to be ignored for LaTeX)
set wildignore+=*.log

set background=dark
filetype plugin indent on
syntax on
set number
set relativenumber
" I never use Modula, so using .md for markdown makes more sense.
au BufRead,BufNewFile *.md set filetype=markdown
" Make vim recognize .tikz files as tex files
au BufNewFile,BufRead *.tikz set filetype=tex
" I always use LaTeX, so lets make that the default
let g:tex_flavor = "latex"
" Load hy module only if inside a hy file
au BufNewFile,BufRead *.hy packadd vim-hy

" My default writing language is English, so lets make that the language for
" spellchecking
set spelllang=en_gb

" Automatically remove trailing whitespace
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Color the 90th column red
set cc=91
set textwidth=90
hi ColorColumn guibg=red

" Setup a tags file for use
set tags=./tags;

" Turn on omni completion
set omnifunc=syntaxcomplete#Complete

" Replace tabs by four spaces
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

" Lets disable the arrow keys
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

""""""""
" ToDo "
""""""""
let g:todoregex = ['TODO', 'Todo']
function! ToDoFinder(files)
  execute 'silent lgrep! -e ' . join(g:todoregex, ' -e ') . ' ' . a:files
  call setloclist(0, [], 'a', {'title' : 'To Dos'})
  lwindow
  redraw!
endfunction
command ToDo call ToDoFinder('%')
" Set up mappings for the loc list
nnoremap ]l :try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>

""""""""""
" vimtex "
""""""""""
let g:vimtex_view_method = 'skim'

"""""""""""""""
" Neocomplete "
"""""""""""""""
let g:neocomplete#enable_at_startup = 1
" Ignore case except when letter is capital
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#enable_auto_close_preview = 1
" Neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"""""""""""""""
" ALE linting "
"""""""""""""""
let g:ale_linters = {
      \ 'lua': ['luac', 'luacheck'],
      \ 'tex': ['chktex', 'proselint'],
      \}
let g:ale_lu_luacheck_options = "--no-unused-args --module"

" Only lint while we are not typing
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" Don't refresh the loclist so we can keep our ToDos there
let g:ale_set_loclist = 0

" Add commands to move to errors/warnings
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)

""""""""""""""
" Statusline "
""""""""""""""

" Functions
" For displaying the number of errors in the statusline
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf(
    \   ' %dW %dE ',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" For displaying the name of the current Git branch
function! GitBranch() abort
    let l:branch = fugitive#head()
    if l:branch == ''
        return ''
    else
        return '[' . l:branch . ']'
    endif
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''
        if !&modifiable
            return b:statusline_tab_warning
        endif
        let tabs = search('^\t', 'nw') != 0
        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

" Colors
hi User1 ctermfg=15 ctermbg=8 guifg=LightGray guibg=#444444
hi User8 ctermfg=0 ctermbg=12 guifg=black guibg=SlateBlue
hi User9 ctermfg=0 ctermbg=10 guifg=black guibg=Green
hi StatuslineNC term=reverse ctermbg=235 gui=italic guifg=black guibg=#403c41

set laststatus=2
"Buffername and filename
set statusline=%1*               " Set colour
set statusline+=\[%n]            " Buffer number in brackets
set statusline+=\ %<%f\ "        " The actual file name

set statusline+=%m               " Modified
set statusline+=%r               " Readonly
set statusline+=%h               " Help

" Warnings
" display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}

" display a warning if file encoding isnt utf-8
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}

" Display a warning if the indenting is wrong
set statusline+=%{StatuslineTabWarning()}
set statusline+=%1*

set statusline+=%=                   " Break in the middle

" Linter
set statusline+=%#warningmsg#
set statusline+=%{LinterStatus()}   " The number of errors in the current buffer

set statusline+=%8*%{GitBranch()}      " current git branch

" Column number
set statusline+=%9*                    " Set the colour
set statusline+=\ col:%3v\             " The current column number

" Time
if has("gui_running")
  set statusline+=%8*
  set statusline+=\ %{strftime(\"%H:%M\")}\ "
endif
