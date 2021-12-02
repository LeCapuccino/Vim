" --------------- Buffer Line ---------------

function ExtractName(path)
	let l:index = 0
	let l:split = 0

	while l:index <= len(a:path)
		if a:path[l:index] == '\'
			let l:split = l:index + 1
		endif

		let l:index = l:index + 1
	endwhile

	return a:path[l:split:]
endfunction

function ExtractIcon(path)
	let l:index = 0
	let l:split = 0

	while l:index <= len(a:path)
		if a:path[l:index] == '.'
			let l:split = l:index + 1
		endif

		let l:index = l:index + 1
	endwhile

	return GetFileIcon(a:path[l:split:])
endfunction

function SetBufferLineColors()
	let l:back = synIDattr(hlID("Normal"), "bg")

	if g:nametheme[0:3] == 'Rose'
		let l:floor = ChangeBrightness(l:back, 25)
	else
		let l:floor = ChangeBrightness(l:back, -20)
	endif

	if g:colors_name == 'gruvbox'
		let l:color = g:terminal_color_15
	elseif g:colors_name == 'sonokai'
		let l:color = g:terminal_color_1
	elseif g:colors_name == 'edge'
		let l:color = g:terminal_color_7
	elseif g:colors_name == 'nord'
		let l:color = g:terminal_color_6
	elseif g:colors_name == 'rose-pine'
		let l:color = g:terminal_color_7
	endif

	let l:numb = ChangeBrightness(l:back, 180)
	let l:ceil = ChangeBrightness(l:back, 100)
	let l:sept = ChangeBrightness(l:back, 10)

	execute 'highlight BufferLineColor guibg=' .. l:color .. ' guifg=' .. l:floor
	execute 'highlight BufferLineBase  guibg=' .. l:floor .. ' guifg=' .. l:ceil
	execute 'highlight BufferLineMain  guibg=' .. l:floor .. ' guifg=' .. l:color
	execute 'highlight BufferLineNumb  guibg=' .. l:floor .. ' guifg=' .. l:numb
	execute 'highlight BufferLineSep   guibg=' .. l:sept  .. ' guifg=' .. l:floor
endfunction

function GetListedBuffers()
	let l:buffers = []
	let l:numbers = []
	let l:icons   = []
	let l:current = 0

	for l:buffer in range(1, bufnr('$'))
		if buflisted(l:buffer)
			let l:numbers = l:numbers + [l:buffer]

			let l:buffers = l:buffers + [ExtractName(bufname(l:buffer))]
			let l:icons   = l:icons   + [ExtractIcon(bufname(l:buffer))]

			if l:buffer == bufnr()
				let l:current = len(l:buffers) - 1
			endif
		endif
	endfor
	
	return [l:numbers, l:buffers, l:icons, l:current]
endfunction

function BufferLine()
	let l:listed = GetListedBuffers()

	let l:numbers = l:listed[0]
	let l:buffers = l:listed[1]
	let l:icons   = l:listed[2]
	let l:current = l:listed[3]

	let l:line = '%#BufferLineColor#'
	let l:line = l:line .. ' Buffers '
	let l:line = l:line .. '%#BufferLineMain#'
	let l:line = l:line .. '%#BufferLineBase#'

	for l:index in range(0, len(l:buffers) - 1)
		let l:line = l:line .. '%#BufferLineBase# ['
		let l:line = l:line .. '%#BufferLineNumb#' .. l:numbers[l:index]
		let l:line = l:line .. '%#BufferLineBase#] '

		if l:index == l:current
			let l:line = l:line .. '%#BufferLineMain#'
			let l:line = l:line .. l:buffers[l:index] .. ' '
			let l:line = l:line .. '%#BufferLineBase#'
		else
			let l:line = l:line .. '%#BufferLineBase#' .. l:buffers[l:index] .. ' '
		endif

		"Icons ----------------------------------------
		let l:line = l:line .. l:icons[l:index] .. ' '

		if l:index + 1 < len(l:buffers)
			let l:line = l:line .. '•'
		endif
	endfor

	let l:line = l:line .. '%#BufferLineSep#'

	return l:line
endfunction

set showtabline=2

set tabline=%!BufferLine()
