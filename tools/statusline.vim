" --------------- Status Bar ---------------

let g:base = [0, 0, 0]

let g:colors = [0, 0, 0, 0,
			\	0, 0, 0, 0,
			\	0, 0, 0, 0,
			\	0, 0, 0, 0]


let g:separator = ['', '']
let g:divisor = '•'

let g:active = v:true

function GetFileSize()
	let l:size = getfsize(bufname())

	if l:size < 0
		return '0 [b]'
	endif

	let l:units = ['b', 'kb', 'mb', 'gb', 'tb']

	let l:unit = 0

	while l:size >= 1024
		let l:size = l:size / 1024.0
		
		let l:unit = l:unit + 1
	endwhile

	return float2nr(l:size) .. ' [' .. l:units[l:unit] .. ']'
endfunction

function GetMode()
	let l:mode = mode()

	if l:mode == 'n'
		let l:mode = 'Normal'
	elseif l:mode == 'v'
		let l:mode = 'Visual'
	elseif l:mode == 'V'
		let l:mode = 'Visual'
	elseif l:mode == 'i'
		let l:mode = 'Insert'
	elseif l:mode == 'r'
		let l:mode = 'Replace'
	elseif l:mode == 'R'
		let l:mode = 'Replace'
	elseif l:mode == 'c'
		let l:mode = 'Command'
	elseif l:mode == 't'
		let l:mode = 'Terminal'
	endif

	return l:mode
endfunction

function GetFileChanged()
	let l:changed = ''

	if g:active
		let l:base = "%#StatusLineBase#"
	else
		let l:base = "%#StatusLineInactiveBase#"
	endif

	let l:chan = "%#StatusLineChan#"

	"* •

	if &modified
		let l:changed = l:changed .. l:chan .. "["
		let l:changed = l:changed .. l:base .. " "
		let l:changed = l:changed .. l:chan .. "]"
		let l:changed = l:changed .. l:base
	else
		let l:changed = l:changed .. l:chan .. "["
		let l:changed = l:changed .. l:base .. " "
		let l:changed = l:changed .. l:chan .. "]"
		let l:changed = l:changed .. l:base
	endif

	return l:changed
endfunction

function GetFileName()
	let l:name = expand('%:t:r')

	if l:name == ''
		return 'empty'
	endif

	return l:name
endfunction

function GetFileExtension()
	let l:extension = expand('%:e')

	if l:extension == ''
		return 'null'
	endif

	return l:extension
endfunction

function GetTheme()
	return g:nametheme
endfunction

function GetFileProgress()
	return '%3p%%'
endfunction

function GetCursorPosition()
	return '%l:%c'
endfunction

function GetStatusLineColor(mode)
	let l:color = g:colors[0]

	if g:nametheme[0:3] == 'Rose'
		if a:mode == 'Normal'
			let l:color = g:colors[6]
		elseif a:mode == 'Insert'
			let l:color = g:colors[3]
		elseif a:mode == 'Visual'
			let l:color = g:colors[2]
		elseif a:mode == 'Replace'
			let l:color = g:colors[1]
		elseif a:mode == 'Command'
			let l:color = g:colors[4]
		elseif a:mode == 'Terminal'
			let l:color = g:colors[6]
		elseif a:mode == 'Inactive'
			let l:color = g:colors[7]
		endif
	else
		if a:mode == 'Normal'
			let l:color = g:colors[10]
		elseif a:mode == 'Insert'
			let l:color = g:colors[11]
		elseif a:mode == 'Visual'
			let l:color = g:colors[12]
		elseif a:mode == 'Replace'
			let l:color = g:colors[13]
		elseif a:mode == 'Command'
			let l:color = g:colors[14]
		elseif a:mode == 'Terminal'
			let l:color = g:colors[15]
		elseif a:mode == 'Inactive'
			let l:color = g:colors[0]
		endif
	endif
	
	return l:color
endfunction

function StatusLineHighlight()
	let l:mode = GetMode()
	
	let l:color = GetStatusLineColor(l:mode)
	
	let l:ceil   = g:colors[15]
	let l:floor  = g:base[1]
	let l:ground = g:base[2]

	let l:change = ChangeBrightness(g:base[2], 100)

	execute 'highlight StatusLineColor guibg=' .. l:color  .. ' guifg=' .. l:ground
	execute 'highlight StatusLineChan  guibg=' .. l:ground .. ' guifg=' .. l:change
	execute 'highlight StatusLineBase  guibg=' .. l:ground .. ' guifg=' .. l:color
	execute 'highlight StatusLineRest  guibg=' .. l:floor  .. ' guifg=' .. l:ceil
	execute 'highlight StatusLineSep   guibg=' .. l:floor  .. ' guifg=' .. l:ground

	let l:ceil = Opacity(l:ceil, '#000000', 0)

	execute 'highlight StatusLineInactiveColor  guibg=' .. l:ceil   .. ' guifg=' .. l:ground
	execute 'highlight StatusLineInactiveBase   guibg=' .. l:ground .. ' guifg=' .. l:ceil
	execute 'highlight StatusLineInactiveRest   guibg=' .. l:floor  .. ' guifg=' .. l:ceil
endfunction

function SetStatusLineColors()
	call UpdateColors()
	call StatusLineHighlight()
endfunction

" -------------- Inactive Buffer Status Line

function InactiveStatusLine()
	let l:name = GetFileName()
	let l:changed = GetFileChanged()
	let l:extension = GetFileExtension()
	let l:size = GetFileSize()
	let l:progress = GetFileProgress()
	let l:position = GetCursorPosition()

	let l:icon = GetFileIcon(l:extension)

	call SetStatusLineColors()
	call SetCursorNumberColor()

	let l:left = ''
	let l:right = ''

	let l:left = l:left .. '%#StatusLineInactiveColor# Inactive '
	let l:left = l:left .. '%#StatusLineInactiveBase#' .. g:separator[0]
	let l:left = l:left .. ' ' .. l:changed
	let l:left = l:left .. ' ' .. l:name
	let l:left = l:left .. ' ' .. g:divisor
	let l:left = l:left .. ' ' .. l:size .. ' '
	let l:left = l:left .. '%#StatusLineSep#' .. g:separator[0]
	let l:left = l:left .. '%#StatusLineInactiveRest# ' .. l:extension .. ' ' .. l:icon

	let l:right = l:right .. '%#StatusLineSep#' .. g:separator[1]
	let l:right = l:right .. '%#StatusLineInactiveBase#' .. ' ' .. l:progress .. ' '  .. g:separator[1]
	let l:right = l:right .. '%#StatusLineInactiveColor# ' .. l:position .. ' '

	return l:left .. '%=' .. l:right
endfunction	

" -------------- Active Buffer Status Line

function StatusLine()
	let l:mode = GetMode()
	let l:name = GetFileName()
	let l:changed = GetFileChanged()
	let l:extension = GetFileExtension()
	let l:size = GetFileSize()
	let l:theme = GetTheme()
	let l:progress = GetFileProgress()
	let l:position = GetCursorPosition()

	let l:icon = GetFileIcon(l:extension)

	call SetStatusLineColors()
	call SetCursorNumberColor()

	let l:left = ''
	let l:right = ''

	let l:left = l:left .. '%#StatusLineColor# ' .. l:mode .. ' '
	let l:left = l:left .. '%#StatusLineBase#' .. g:separator[0]
	let l:left = l:left .. ' ' .. l:changed
	let l:left = l:left .. ' ' .. l:name
	let l:left = l:left .. ' ' .. g:divisor
	let l:left = l:left .. ' ' .. l:size .. ' '
	let l:left = l:left .. '%#StatusLineSep#' .. g:separator[0]
	let l:left = l:left .. '%#StatusLineRest# ' .. l:extension .. ' ' .. l:icon

	let l:right = l:right .. '%#StatusLineRest# ' .. l:theme .. ' '
	let l:right = l:right .. '%#StatusLineSep#' .. g:separator[1]
	let l:right = l:right .. '%#StatusLineBase#' .. ' ' .. l:progress .. ' '  .. g:separator[1]
	let l:right = l:right .. '%#StatusLineColor# ' .. l:position .. ' '

	return l:left .. '%=' .. l:right
endfunction

function SetActiveBufferStatusLine()
	let l:ignored = ['Startup', 'NvimTree', 'Terminal']

	let l:default = v:true

	for l:file in l:ignored
		if &filetype == l:file
			let l:default = v:false
			
			break
		endif
	endfor

	if l:default
		let g:active = v:true

		setlocal statusline=%!StatusLine()
	endif
endfunction

function SetInactiveBufferStatusLine()
	let l:ignored = ['Startup', 'NvimTree', 'Terminal']

	let l:default = v:true

	for l:file in l:ignored
		if &filetype == l:file
			let l:default = v:false
			
			break
		endif
	endfor

	if l:default
		let g:active = v:false

		call setbufvar(bufnr(), '&statusline', InactiveStatusLine())
	endif
endfunction

augroup SetStatusLine
	autocmd!
	autocmd WinEnter,BufEnter * call SetActiveBufferStatusLine()
	autocmd WinLeave,BufLeave * call SetInactiveBufferStatusLine()
augroup end
