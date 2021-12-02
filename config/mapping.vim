" --------------- General Mapping ---------------

" ---------- Functions To Operations

function Out()
	let l:pos = [line('.'), col('.')]

	stopinsert

	call cursor(l:pos)
endfunction

function Copy(mode, operation)
	let l:pos = [line('.'), col('.')]

	if a:mode == "normal"
		if a:operation == "word"
			normal yiw
		elseif a:operation == "expr"
			normal yiW
		elseif a:operation == "fron"
			normal y$
		elseif a:operation == "back"
			normal y0
		elseif a:operation == "line"
			normal Vy
		elseif a:operation == "phag"
			normal yip
		elseif a:operation == "part"
			normal yi(
		elseif a:operation == "brak"
			normal yi[
		elseif a:operation == "brec"
			normal yi{
		elseif a:operation == "tags"
			normal yi<
		elseif a:operation == "quot"
			normal yi"
		elseif a:operation == "quat"
			normal yi'
		endif
	elseif a:mode == "visual"
	endif

	call cursor(l:pos)
endfunction

function Cut(mode, operation)
	if a:mode == "normal"
		if a:operation == "word"
			normal diw
		elseif a:operation == "expr"
			normal diW
		elseif a:operation == "fron"
			normal d$
		elseif a:operation == "back"
			normal d0
		elseif a:operation == "line"
			normal VyVd
		elseif a:operation == "phag"
			normal dip
		elseif a:operation == "part"
			normal di(
		elseif a:operation == "brak"
			normal di[
		elseif a:operation == "brec"
			normal di{
		elseif a:operation == "tags"
			normal di<
		elseif a:operation == "quot"
			normal di"
		elseif a:operation == "quat"
			normal di'
		endif
	elseif a:mode == "visual"
		return
	endif
endfunction

function Delete(mode, operation)
	if a:mode == "normal"
		if a:operation == "word"
			normal "_diw
		elseif a:operation == "expr"
			normal "_diW
		elseif a:operation == "fron"
			normal "_d$
		elseif a:operation == "back"
			normal "_d0
		elseif a:operation == "line"
			normal V"_d
		elseif a:operation == "phag"
			normal "_dip
		elseif a:operation == "part"
			normal "_di(
		elseif a:operation == "brak"
			normal "_di[
		elseif a:operation == "brec"
			normal "_di{
		elseif a:operation == "tags"
			normal "_di<
		elseif a:operation == "quot"
			normal "_di"
		elseif a:operation == "quat"
			normal "_di'
		endif
	elseif a:mode == "visual"
		return
	endif
endfunction

function MapSubstitute()
	let l:pairs = ["()", "[]", "{}", "<>", "\"\"", "\'\'"]

	for l:that in l:pairs
		for l:this in l:pairs
			execute "nnoremap s" .. l:this[0] .. l:that[0] ..
		\	" :call Substitute(" .. l:this[0] .. ", \"" .. l:that .. "\")<CR>"
		endfor
	endfor
endfunction

function Substitute(this, that)
	let l:pos = [line('.'), col('.')]
	
	normal v
	execute "normal i" .. a:this
	normal v

	normal `<
	let l:begin = [line('.'), col('.') - 1]
	
	normal `>
	let l:end = [line('.'), col('.') + 1]

	if l:begin != l:end
		call cursor(l:begin)
		execute "normal r" .. a:that[0]

		call cursor(l:end)
		execute "normal r" .. a:that[1]
	endif

	call cursor(l:pos)
endfunction

function AddBlank(position, type)
	let l:pos = [line('.'), col('.')]

	if a:position == "back"
		if a:type == "char"
			normal i 

			let l:pos[1] = l:pos[1] + 1
		elseif a:type == "line"
			normal O

			let l:pos[0] = l:pos[0] + 1
		endif
	elseif a:position == "fron"
		if a:type == "char"
			normal a 
		elseif a:type == "line"
			normal o
		endif
	endif

	stopinsert

	call cursor(l:pos)
endfunction

function MoveToBuffer(way)
	if a:way == "previous"
		bprevious
	elseif a:way == "next"
		bnext 
	elseif a:way == "first"
		bfirst
	elseif a:way == "last"
		blast	
	endif
endfunction

function ManipulateBuffer(action)
	if a:action == 'delete'
		bdelete
	elseif a:action == 'write'
		write
	elseif a:action == 'rename'
		return
	endif
endfunction

" ---------- Normal Mode Maps 

"nnoremap e :edit ~\appdata\local\nvim\init.vim <CR>
nnoremap <CR> gf <CR>

" Delete, Cut and Yank

nnoremap <silent>dw :call Delete("normal", "word")<CR>
nnoremap <silent>de :call Delete("normal", "expr")<CR>
nnoremap <silent>df :call Delete("normal", "fron")<CR>
nnoremap <silent>db :call Delete("normal", "back")<CR>
nnoremap <silent>dd :call Delete("normal", "line")<CR>
nnoremap <silent>dp :call Delete("normal", "phag")<CR>
nnoremap <silent>d( :call Delete("normal", "part")<CR>
nnoremap <silent>d[ :call Delete("normal", "brak")<CR>
nnoremap <silent>d{ :call Delete("normal", "brec")<CR>
nnoremap <silent>d< :call Delete("normal", "tags")<CR>
nnoremap <silent>d" :call Delete("normal", "quot")<CR>
nnoremap <silent>d' :call Delete("normal", "quat")<CR>

nnoremap <silent>cw :call Cut("normal", "word")<CR>
nnoremap <silent>ce :call Cut("normal", "expr")<CR>
nnoremap <silent>cf :call Cut("normal", "fron")<CR>
nnoremap <silent>cb :call Cut("normal", "back")<CR>
nnoremap <silent>cc :call Cut("normal", "line")<CR>
nnoremap <silent>cp :call Cut("normal", "phag")<CR>
nnoremap <silent>c( :call Cut("normal", "part")<CR>
nnoremap <silent>c[ :call Cut("normal", "brak")<CR>
nnoremap <silent>c{ :call Cut("normal", "brec")<CR>
nnoremap <silent>c< :call Cut("normal", "tags")<CR>
nnoremap <silent>c" :call Cut("normal", "quot")<CR>
nnoremap <silent>c' :call Cut("normal", "quat")<CR>

nnoremap <silent>yw :call Copy("normal", "word")<CR>
nnoremap <silent>ye :call Copy("normal", "expr")<CR>
nnoremap <silent>yf :call Copy("normal", "fron")<CR>
nnoremap <silent>yb :call Copy("normal", "back")<CR>
nnoremap <silent>yy :call Copy("normal", "line")<CR>
nnoremap <silent>yp :call Copy("normal", "phag")<CR>
nnoremap <silent>y( :call Copy("normal", "part")<CR>
nnoremap <silent>y[ :call Copy("normal", "brak")<CR>
nnoremap <silent>y{ :call Copy("normal", "brec")<CR>
nnoremap <silent>y< :call Copy("normal", "tags")<CR>
nnoremap <silent>y" :call Copy("normal", "quot")<CR>
nnoremap <silent>y' :call Copy("normal", "quat")<CR>

" Substitute

" Subs "
nnoremap <silent>s([ :call Substitute("(", "[]")<CR>
nnoremap <silent>s({ :call Substitute("(", "{}")<CR>
nnoremap <silent>s(< :call Substitute("(", "<>")<CR>
nnoremap <silent>s(' :call Substitute("(", "\'\'")<CR>
nnoremap <silent>s(" :call Substitute("(", "\"\"")<CR>

" Subs "
nnoremap <silent>s[( :call Substitute("[", "()")<CR>
nnoremap <silent>s[{ :call Substitute("[", "{}")<CR>
nnoremap <silent>s[< :call Substitute("[", "<>")<CR>
nnoremap <silent>s[' :call Substitute("[", "\'\'")<CR>
nnoremap <silent>s[" :call Substitute("[", "\"\"")<CR>

" Subs "
nnoremap <silent>s{( :call Substitute("{", "()")<CR>
nnoremap <silent>s{[ :call Substitute("{", "[]")<CR>
nnoremap <silent>s{< :call Substitute("{", "<>")<CR>
nnoremap <silent>s{' :call Substitute("{", "\'\'")<CR>
nnoremap <silent>s{" :call Substitute("{", "\"\"")<CR>

" Subs <
nnoremap <silent>s<( :call Substitute("<", "()")<CR>
nnoremap <silent>s<[ :call Substitute("<", "[]")<CR>
nnoremap <silent>s<{ :call Substitute("<", "{}")<CR>
nnoremap <silent>s<' :call Substitute("<", "\'\'")<CR>
nnoremap <silent>s<" :call Substitute("<", "\"\"")<CR>

" Subs '
nnoremap <silent>s'( :call Substitute("\'", "()")<CR>
nnoremap <silent>s'[ :call Substitute("\'", "[]")<CR>
nnoremap <silent>s'{ :call Substitute("\'", "{}")<CR>
nnoremap <silent>s'< :call Substitute("\'", "<>")<CR>

" Subs "
nnoremap <silent>s"( :call Substitute("\"", "()")<CR>
nnoremap <silent>s"[ :call Substitute("\"", "[]")<CR>
nnoremap <silent>s"{ :call Substitute("\"", "{}")<CR>
nnoremap <silent>s"< :call Substitute("\"", "<>")<CR>
nnoremap <silent>s"' :call Substitute("\"", "\'\'")<CR>

" Indent

nnoremap >p >ip
nnoremap <p <ip

" Add Blanks

nnoremap <silent><Space>h :call AddBlank("back", "char")<CR>
nnoremap <silent><Space>j :call AddBlank("fron", "line")<CR>
nnoremap <silent><Space>k :call AddBlank("back", "line")<CR>
nnoremap <silent><Space>l :call AddBlank("fron", "char")<CR>

" Change Window

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Change Buffer

nnoremap <silent><C-b>p :call MoveToBuffer("previous")<CR>
nnoremap <silent><C-b>n :call MoveToBuffer("next")    <CR>
nnoremap <silent><C-b>f :call MoveToBuffer("first")   <CR>
nnoremap <silent><C-b>l :call MoveToBuffer("last")    <CR>

nnoremap <silent><C-b>d :call ManipulateBuffer("delete")<CR>
nnoremap <silent><C-b>w :call ManipulateBuffer("write") <CR>
nnoremap <silent><C-b>r :call ManipulateBuffer("rename")<CR>

" ---------- Insert Mode Maps

inoremap <silent><ESC> <C-O>:call Out()<CR>

inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" ---------- Command Mode Maps

"inoremap <C-h> <Left>
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-l> <Right>

" ---------- Visual Mode Maps

vnoremap d "_d
vnoremap c d

" ---------- Replace Mode Maps

"inoremap <silent><ESC> <C-O>:call ExitInsertion("replace")<CR>
