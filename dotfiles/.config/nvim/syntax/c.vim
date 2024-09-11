" use :syntax list to list current defs
syn match    cCustomParen    "?=(" contains=cParen,cCppParen
syn match    cCustomFunc     "\w\+\s*(\@=" contains=cCustomParen
syn match    cCustomScope    "::"
syn match    cCustomScope    "->"
syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
syn match    cCustomClass    "\w\+\s*->" contains=cCustomScope
syn match    cCustomClass    "\w\+\s*\." contains=cCustomScope
"hi def cCustomFunc  gui=bold guifg=tan
" hi def cCustomClass  gui=standout guifg=lightpink
hi def cCustomFunc  gui=italic
" hi def cCustomClass  gui=bold
hi def link cCustomClass Function
