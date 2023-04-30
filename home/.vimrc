" Welcome to Vim (http://go/vim).
"
" If you see this file, your homedir was just created on this workstation.
" That means either you are new to Google (in that case, welcome!) or you
" got yourself a faster machine.
" Either way, the main goal of this configuration is to help you be more
" productive; if you have ideas, praise or complaints, direct them to
" vi-users@google.com (http://g/vi-users). We'd especially like to hear from you
" if you can think of ways to make this configuration better for the next
" Noogler.
" If you want to learn more about Vim at Google, see http://go/vimintro.

" Enable modern Vim features not compatible with Vi spec.
set nocompatible
set belloff=all


" REMOVE if something weird is happening
"source ~/.vim/vundlerc.vim

" Use the 'google' package by default (see http://go/vim/packages).
"source /usr/share/vim/google/google.vim
"Glug youcompleteme-google

"source /usr/share/vim/google/gtags.vim
"echo "Use :Gtrestartmixer to use GTags. More help at go/GTagsVIClient"

"set keywordprg=cs-web



" All of your plugins must be added before the following line.

" Enable file type based indent configuration and syntax highlighting.
filetype plugin indent on
syntax on



""""""""""""""""""""""""""""""""""""""==============================


set nocompatible
filetype on
filetype plugin on
filetype indent on


set backspace=indent,eol,start
set history=1000


"colorscheme darkblue
colorscheme desert

set hls
set ai
set si

"set noet
"set ts=4
"set sw=4

set et
set ts=4
set sw=2

set fdm=syntax
" fold diff:
" set foldmethod=expr | set foldexpr=getline(v:lnum)!~'^diff\ '

set cst
set csverb
set cspc=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hls
set is
set ai
set si
set nowrap
syntax enable

" partial command hint
set sc
" command-line completion shows a list of matches
set wmnu
" use cscope when possible
set cst
" when completing tags in Insert mode show more info
set sft
" show cursor position below each window
set ru
"Allow switching buffers without writing to disk
set hidden

"Usually I don't care about case when searching
set ignorecase
"Only ignore case when we type lower case when searching
set smartcase
"Send cscope output to quickfix window
set cscopequickfix=s-,c-,d-,i-,t-,e-

" many jump commands move the cursor to the first non-blank character of a line
set nosol

" :cs add cscope.out

"set listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set listchars=tab:⇒⋅,trail:★,nbsp:⋅


set mis=40

set tags=./tags,./TAGS,tags,TAGS,/usr/include/tags

"nmap <F2> :w<CR>
"imap <F2> <ESC><F2>
"vmap <F2> <ESC><F2>

noremap <F2>		:wa<CR>
vnoremap <F2>		<C-C>:wa<CR>
inoremap <F2>		<C-O>:wa<CR>
noremap <F1>		:update<CR>
vnoremap <F1>		<C-C>:update<CR>
inoremap <F1>		<C-O>:update<CR>

nmap <F3> n
imap <F3> <C-O>n
vmap <F3> n

nmap <S-F3> N
imap <S-F3> <C-O>N
vmap <S-F3> N
" tmux override
map <Esc>[28~ <S-F3>
imap <Esc>[28~ <S-F3>

" CTRL-Tab is Next window
"noremap <C-Tab> <C-W>w
"inoremap <C-Tab> <C-O><C-W>w
"cnoremap <C-Tab> <C-C><C-W>w
noremap <C-Tab> <C-^>
inoremap <C-Tab> <C-O><C-^>
cnoremap <C-Tab> <C-C><C-^>

nmap <F12> g<C-]>

nmap <F4> :cnext<CR>
nmap <S-F4> :cprev<CR>
nmap <M-2> :copen<CR>
imap <M-2> <C-C>:copen<CR>
" tmux override
nmap <Esc>[29~ <S-F4>

" move screen
"nmap <C-Up> 1<C-U>
"nmap <C-Down> 1<C-D>
nmap <C-Up> 1<C-Y>
nmap <C-Down> 1<C-E>

" try :h cw
imap <C-Del> <C-\><C-O>vwhd
nmap <C-Del> vwhd
imap <C-Backspace> <C-C>vgeldi
nmap <C-Backspace> vgeld

imap <C-Del> <C-\><C-O>dw
nmap <C-Del> dw
imap <C-Backspace> <C-\><C-O>db
nmap <C-Backspace> db
imap <M-Backspace> <C-\><C-O>db
nmap <M-Backspace> db

imap <C-F4> <C-C>:q<CR>
nmap <C-F4> :q<CR>

imap <S-Home> ^
vmap <S-Home> ^
imap <S-Home> <C-O>^

vnoremap * "*y/\V<C-R>*<CR>
vnoremap g* "*y/\V<C-R>*<CR>:Bgrep <C-R>*<CR>
command SearchAddWord let @/ = @/."\\|".expand("<cword>")|echo @/
nnoremap g+ :SearchAddWord<CR>

"" Switch windows
nnoremap `<Left> <C-W>h
nnoremap `<Right> <C-W>l
nnoremap `<Up> <C-W>k
nnoremap `<Down> <C-W>j

" Close current window
nnoremap <leader>q :q<CR>

" cursor beyond EOL:
"set virtualedit=all
" no cursor blink
set gcr=n-v-c:block-Cursor/lCursor-blinkon0,ve:ver35-Cursor-blinkon0,o:hor50-Cursor-blinkon0,i-ci:ver25-Cursor/lCursor-blinkon0,r-cr:hor20-Cursor/lCursor-blinkon0,sm:block-Cursor-blinkon0

if exists("&fuopt")
	set fuopt+=maxhorz
	set fuopt+=maxvert
	map <D-F> :set invfu<CR>
endif

if exists("&guifont")
	" for Mac:
	set guifont=Andale_Mono:h12,Courier_New:h12,Menlo:h12

	"set guifont=Droid Sans Mono 10
	"set guifont=Ubuntu Mono 11
	"set guifont=Courier 10 Pitch 11

	" for Linux:
	" set guifont=Monospace

	"if exists("&linespace")
	"	set linespace=-2
	"endif
endif

if exists("&guioptions")
	set guioptions-=T
endif

set ts=4
set sw=4
set ai
set si
set cin
" set fdm=indent
set fdm=syntax
set ww=b,s,<,>,[,]

nmap \w \be
let g:bufExplorerShowDirectories=1
let g:bufExplorerShowRelativePath=1


"flag problematic whitespace (trailing and spaces before tabs)
"Note you get the same by doing let c_space_errors=1 but
"this rule really applys to everything.
highlight RedundantSpaces term=standout ctermbg=red guibg=brown
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

"Make the completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3 guifg=#a0a0a0 guibg=#202020
highlight PmenuSel ctermfg=0 ctermbg=7 guifg=#000000 guibg=#4080c0

" mark 80th column
set cc=80,81
" hi ColorColumn ctermbg=lightgrey guibg=lightgrey
hi ColorColumn ctermbg=black guibg=black


"allow deleting selection without updating the clipboard (yank buffer)
"vnoremap x "_x
"vnoremap X "_X
nnoremap x "_x
nnoremap X "_X

" Open URL under cursor (-g : in background)
"Mac
"map gr :silent! exec "!open -g -a Хром "expand("<cWORD>")<CR>:redraw!<CR>
map gr :silent! exec "!open -g "expand("<cWORD>")<CR>:redraw!<CR>
"Linux
"map gr :silent! exec "!xdg-open "expand("<cWORD>")<CR>:redraw!<CR>
"if exists('g:ConqueTerm_ReadUnfocused')
	let g:ConqueTerm_ReadUnfocused = 1
	let g:ConqueTerm_CloseOnEnd = 1
"endif

if has("terminal")
	nmap \X :botright terminal ++close<CR>
	nmap \x :botright terminal ++close<CR><C-W>L
endif

" Go to diff for files from diff for dirs output
"command -nargs=0 DD exec substitute(join(filter(split(getline(line("."))), 'v:val !~ "^-"')), '\v\C^(diff\s+([^ ]+)\s+([^ ]+))|(.*)$', '\=len(submatch(1)) ? "tabnew ".submatch(2). " | vert diffsplit ".submatch(3) : "echo \"Not a diff command under cursor\""', '')

command -nargs=0 Unundo exec "set ul=-1 | edit | set ul=".&ul
command -nargs=0 Text exec "set nu wrap linebreak"
command -nargs=0 CodeSp exec "set et sw=2 ts=2 nolinebreak | retab"
command -nargs=0 CodeTab exec "set noet sw=4 ts=4 nolinebreak | retab"

augroup sh
    au!
    "smart indent really only for C like languages
    au FileType sh set nosmartindent autoindent
augroup END

"augroup man
"    au!
"    "Ensure vim is not recursively invoked (man-db does this)
"    "when doing ctrl-[ on a man page reference
"    au FileType man let $MANPAGER=""
"augroup END

"set noswapfile

set mouse=a
set autoread
if !has('nvim')
    set ttymouse=sgr
endif

