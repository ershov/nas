" This script wraps all sequential accessor methods into one fold
" Should put this script to ~/.vim/syntax/java.vim

"syn match AA "\v^\t+(public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\))) {-}\{[a-zA-Z_0-9\n\t \;\.\=\(\)]*\}([ \t\n]+(public)@=)?)+" fold
"syn match AA "\v((public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}([ \t\n]*public (\k|\s)+ )?)+" fold extend contains=NONE
"syn region AA start="\v(public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}@=" end="\v\}" skip="\v}[ \t\n]*public (\k|\s)+ [gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}" fold extend contains=NONE

syn region AA start="\v^\s+public (\k|\s|[<>])+ [gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}@=" end="\v\}" skip="\v}[ \t\n]*public (\k|\s|[<>])+ [gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}" fold extend contains=AAone keepend
"syn region AAone start="\v^\s+public (\k|\s)+ [gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}@=" end="\v\}" fold extend contained keepend
hi AA guifg=gray
"hi AAone guibg=black guifg=gray







""""   --------------------
""""   first attempt
""""   
""""   syn match AA "\v^	+public [a-zA-Z0-9_ ]{-} get[A-Z](\w*)\(\)( *)\{\_.{-}\}" fold
""""   
""""   syn match AA "\v^	+public [a-zA-Z0-9_ ]{-} set[A-Z](\w*)\(([^,\)]{-})\)( *)\{\_.{-}\}" fold
""""   
""""   syn match AA "\v^	+public [a-zA-Z0-9_ ]{-} set[A-Z](\w*)\(([^,\)]{-})\)( *)\{\_.{-}\}(\s{-})" fold
""""   
""""   syn match AA "\v^	+public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w*)\(([^,\)]{-})\))|(get[A-Z](\w*)\(\)))( *)\{\_.{-}\}(\s{-})" fold
""""   
""""   syn match AA "\v^\t+public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\)))( {-})\{\_.{-}\}([ \t\n]{-})" fold
""""   
""""   syn match AA "\v^(\t+public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\)))( {-})\{\_.{-}\}([ \t\n]{-}))+" fold
""""   
""""   syn match AA "\v(\t+public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\)))( {-})\{\_.{-}\}([^\{\}]|\n){-})+" fold
""""   
""""   syn match AA "\v(\t+public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\)))( {-})\{[a-zA-Z_0-9\n\t \;\.\=\(\)]*\}([ \t\n]{-}))+" fold
""""   syn match AA "\v(\t+public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\))) {-}\{[a-zA-Z_0-9\n\t \;\.\=\(\)]*\}([ \t\n]{-}))+" fold
""""   
""""   
""""   syn match AA "\v^\t+(public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\))) {-}\{[a-zA-Z_0-9\n\t \;\.\=\(\)]*\}([ \t\n]*))+" fold
""""   
""""   
""""   syn match AA "\v^\t+(public [a-zA-Z0-9_ ]{-} ((set[A-Z](\w{-})\(([^,\)]{-})\))|(get[A-Z](\w{-})\(\))) {-}\{[a-zA-Z_0-9\n\t \;\.\=\(\)]*\}([ \t\n]+(public)@=)?)+" fold
""""   
""""   
""""   --------------------
""""   pre-post-match
""""   
""""   \vpublic (\k|\s)+ \zs(get|set)(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}\ze
""""   
""""   \vpublic (\k|\s)+ \zs(get|set)(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}\ze[ \t\n]+
""""   
""""   \v(public (\k|\s)+ )@<=(get|set)(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}([ \t\n]+)@=
""""   
""""   syn match AA "\v(public (\k|\s)+ )@<=(get|set)(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}([ \t\n]+)@=" fold extend
""""   
""""   \v((public (\k|\s)+ )@<=(get|set)(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}(([ \t\n]+public)@=)?)
""""   \v((public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}(([ \t\n]+public)@=)?)
""""   \v((public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}(([ \t\n]+public)?)@=)
""""   
""""   \v((public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}([ \t\n]*public (\k|\s)+ )?)+
""""   syn match AA "\v((public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}([ \t\n]*public (\k|\s)+ )?)+" fold extend
""""   syn match AA "\v((public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}([ \t\n]*public (\k|\s)+ )?)+" fold extend contains=NONE
""""   
""""   
""""   ------------------
""""   region, start, skip, stop
""""   
""""   \v(public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}@=
""""   syn region AA start="\v(public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}@=" end="\v\}" fold extend contains=NONE
""""   
""""   syn region AA start="\v(public (\k|\s)+ )@<=[gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}@=" end="\v\}" skip="\v}[ \t\n]*public (\k|\s)+ [gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}" fold extend contains=NONE
""""   
""""   syn region AA start="\v^\s+public (\k|\s)+ [gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}@=" end="\v\}" skip="\v}[ \t\n]*public (\k|\s)+ [gs]et(\k+)\(([^,)]*)\) *\{[\n\t -z|~]{-}\}" fold extend contains=NONE
""""

