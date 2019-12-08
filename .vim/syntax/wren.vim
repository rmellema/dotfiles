" Vim syntax fil
" Language: wren
" Maintainer: René Mellema
" Latest revision: 3 Jan 2015

if exists("b:current_syntax")
  finish
end

" Find identifiers
syn match wrenIdent       "[a-zA-Z_][a-zA-Z0-9_]*"

" Find keywords
syn keyword wrenKeywords  if else while for in break return
syn keyword wrenKeywords  class static is var
syn keyword wrenConstruct new

" Find blocks
syn region wrenBlock      start="{" end="}" fold transparent contains=ALL
syn region wrenList       start="\[" end="\]" transparent contains=ALLBUT,wrenKeywords

" Find comments
syn match wrenComment     "//.*$" contains=wrenTodo
syn region wrenComment    matchgroup=wrenComment start="/\*" end="\*/" fold contains=wrenComment,wrenTodo
syn keyword wrenTodo      contained TODO

" Find strings
syn region wrenString     start='"' end='"'

" Find numbers
syn match wrenNumber      "\<\d\+\>"
syn match wrenNumber      "\<\d\*\.\d+"

" Find constants
syn keyword wrenConstant  true
syn keyword wrenConstant  false
syn keyword wrenConstant  null
syn keyword wrenConstant  this

" Fin builtins
syn match wrenBuiltin     "\<IO\.print\>"
syn match wrenBuiltin     "\<IO\.write\>"
syn match wrenBuiltin     "\<Object\>"
syn match wrenBuiltin     "\<Class\>"
syn match wrenBuiltin     "\<String\>"
syn match wrenBuiltin     "\<Num\>"
syn match wrenBuiltin     "\<Bool\>"
syn match wrenBuiltin     "\<Fn\>"
syn match wrenBuiltin     "\<Fiber\>"
syn match wrenBuiltin     "\<Null\>"
syn match wrenBuiltin     "\<Sequence\>"
syn match wrenBuiltin     "\<List\>"
syn match wrenBuiltin     "\<Range\>"

let b:current_syntax="wren"

"hi def link wrenIdent     Identifier
hi def link wrenBuiltin   Identifier
hi def link wrenKeywords  Statement
hi def link wrenConstruct Statement
hi def link wrenComment   Comment
hi def link wrenTodo      Todo
hi def link wrenString    Constant
hi def link wrenNumber    Constant
hi def link wrenConstant  Constant
