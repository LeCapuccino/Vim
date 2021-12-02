" --------------- Terminal Configuration
let s:terminal = ''

function TerminalToggle()
	if s:terminal == '' 
		let l:height = winheight(0) / 4

		execute ':belowright split'
		execute ':resize ' .. l:height
		execute ':edit'
		execute ':terminal'
		execute ':start'

		setlocal winfixheight
		setlocal nocursorline
		setlocal nonumber
		setlocal norelativenumber

		setlocal filetype=Terminal
		setlocal statusline=%!TerminalStatusLine()
		"setlocal winhighlight=Normal:TerminalBackground,NormalNC:TerminalBackground

		let s:terminal = bufname()
	else
		execute ':bwipeout! ' .. s:terminal

		let s:terminal = '' 
	endif
endfunction

function SetTerminalColors()
	let l:color = g:colors[14] "g:colors[10]
	
	let l:ceil   = g:colors[15]
	let l:floor  = g:base[1]
	let l:ground = g:base[2]

	let l:back = ChangeBrightness(g:base[0], -5)

	execute 'highlight TerminalStatusLineColor guibg=' .. l:color  .. ' guifg=' .. l:ground
	execute 'highlight TerminalStatusLineBase  guibg=' .. l:ground .. ' guifg=' .. l:color
	execute 'highlight TerminalStatusLineRest  guibg=' .. l:floor  .. ' guifg=' .. l:ceil
	execute 'highlight TerminalStatusLineSep   guibg=' .. l:floor  .. ' guifg=' .. l:ground

	execute 'highlight TerminalBackground  guibg=' .. l:back   .. ' guifg=' .. l:ceil
endfunction

function TerminalStatusLine()
	let l:mode = GetMode()
	
	if l:mode == 'Terminal'
		let l:mode = 'Insert'
	endif

	let l:name = 'Terminal'
	let l:terminal = 'prompt'

	let l:theme = GetTheme()
	let l:progress = GetFileProgress()
	let l:position = GetCursorPosition()

	let l:icon = ''

	call SetTerminalColors()

	let l:left = ''
	let l:right = ''

	let l:left = l:left .. '%#TerminalStatusLineColor# ' .. l:name .. ' '
	let l:left = l:left .. '%#TerminalStatusLineBase#' .. g:separator[0]
	let l:left = l:left .. ' ' .. l:mode ..  ' '
	let l:left = l:left .. '%#TerminalStatusLineSep#' .. g:separator[0]
	let l:left = l:left .. '%#TerminalStatusLineRest# ' .. l:terminal .. ' ' .. l:icon

	let l:right = l:right .. '%#TerminalStatusLineRest# ' .. l:theme .. ' '
	let l:right = l:right .. '%#TerminalStatusLineSep#' .. g:separator[1]
	let l:right = l:right .. '%#TerminalStatusLineBase#' .. ' ' .. l:progress .. ' '  .. g:separator[1]
	let l:right = l:right .. '%#TerminalStatusLineColor# ' .. l:position .. ' '

	return l:left .. '%=' .. l:right
endfunction

" ----- Terminal Maps

tnoremap <Esc> <C-\><C-n>

" ----- Map Keys

nnoremap <silent> <Space>t :call TerminalToggle()  <CR>
