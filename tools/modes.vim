" -------------- Highlight Number and Line Cursor

function SetCursorNumberColor()
	let l:color = synIDattr(hlID("StatusLineColor"), "bg")
	
	execute 'highlight CursorLineNr guifg=' .. l:color

	redraw

	return ''
endfunction

function SetCursorLineColor()
	let l:color = synIDattr(hlID("Normal"), "bg")
	let l:color = Opacity(l:color, '#ffffff', 10)

	execute 'highlight CursorLine guibg=' .. l:color

	highlight! link Visual CursorLine

	redraw
endfunction
