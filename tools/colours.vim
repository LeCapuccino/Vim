" --------------- Color Functions ---------------

function UpdateColors()
	for l:color in range(0, 15)
		execute 'let g:colors[' .. l:color .. '] = g:terminal_color_' .. l:color
	endfor

	let g:base[0] = synIDattr(hlID("Normal"), "bg")

	if g:nametheme[0:3] == 'Rose'
		let g:base[1] = ChangeBrightness(g:base[0], 10)
		let g:base[2] = ChangeBrightness(g:base[0], 25)
	else
		let g:base[1] = ChangeBrightness(g:base[0],  10)
		let g:base[2] = ChangeBrightness(g:base[0], -10)
	endif
endfunction

function LimitValue(value, inferior, superior)
	if a:value < a:inferior
		return a:inferior
	endif

	if a:value > a:superior
		return a:superior
	endif

	return a:value
endfunction

function DecToHex(decimal)
	return printf('%x', a:decimal .. '')
endfunction

function HexToDec(hexadecimal)
	return str2nr(a:hexadecimal, 16) + 0
endfunction

function LinearMapping(origin, destination, point)
	let l:point = LimitValue(a:point, 0, 100)

	let l:value = a:origin + l:point * (a:destination - a:origin) / 100.0

	return float2nr(l:value)
endfunction

function ColorHexToDec(color)
	let l:red   = HexToDec(a:color[1:2])
	let l:green = HexToDec(a:color[3:4])
	let l:blue  = HexToDec(a:color[5:6])

	return [l:red, l:green, l:blue]
endfunction

function ColorDecToHex(color)
	let l:red   = DecToHex(a:color[0])
	let l:green = DecToHex(a:color[1])
	let l:blue  = DecToHex(a:color[2])

	if len(l:red) == 1
		let l:red = '0' .. l:red
	endif

	if len(l:green) == 1
		let l:green ='0' .. l:green
	endif

	if len(l:blue) == 1
		let l:blue = '0' .. l:blue
	endif
		
	return '#' .. l:red .. l:green .. l:blue
endfunction

function ChangeBrightness(color, increase)
	let l:red   = HexToDec(a:color[1:2]) + a:increase
	let l:green = HexToDec(a:color[3:4]) + a:increase
	let l:blue  = HexToDec(a:color[5:6]) + a:increase
		
	let l:red   = DecToHex(LimitValue(l:red,   0, 255))
	let l:green = DecToHex(LimitValue(l:green, 0, 255))
	let l:blue  = DecToHex(LimitValue(l:blue,  0, 255))
	
	if len(l:red) == 1
		let l:red = '0' .. l:red
	endif

	if len(l:green) == 1
		let l:green ='0' .. l:green
	endif

	if len(l:blue) == 1
		let l:blue = '0' .. l:blue
	endif
		
	return '#' .. l:red .. l:green .. l:blue
endfunction

function Opacity(base, other, opacity)
	let l:base = ColorHexToDec(a:base)
	let l:other = ColorHexToDec(a:other)

	let l:color = [0, 0, 0]

	for l:comp in range(0, 2)
		let l:color[l:comp] = LinearMapping(l:base[l:comp], l:other[l:comp], a:opacity)
	endfor

	return ColorDecToHex(l:color)
endfunction
