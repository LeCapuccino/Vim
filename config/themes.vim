let s:memory = stdpath('data') . '\memory.txt'

let s:themes = ["Gruvbox",
			   \"Oceanic",
			   \"Sonokai",
			   \"Palenight",
			   \"Edge",
			   \"Dracula",
			   \"Aquarium",
			   \"Dogrun",
			   \"Rose",
			   \"Nord",
			   \"Iceberg",
			   \"Sobrio"]

let s:namethemes = ["gruvbox",
				   \"OceanicNext",
                   \"sonokai",
                   \"palenight",
                   \"edge",
                   \"dracula",
                   \"aquarium",
                   \"dogrun",
                   \"rose-pine",
                   \"nord",
                   \"iceberg",
                   \"sobrio"]

let s:modes = [['soft', 'medium', 'hard'],
			  \['default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'],
			  \['default', 'aura', 'neon'],
			  \['base', 'moon']]

let s:mode = [0, 0, 0, 0]

let s:content = readfile(s:memory, '', 3)

let s:theme = s:content[0]

let s:position = s:content[1]

let s:mode[s:position] = s:content[2]

let g:nametheme = ''

function MemorizeTheme()
	if !filereadable(s:memory)
		:call writefile([0, 0, 0], s:memory, "a")
	else
		:call delete(s:memory)
		:call writefile([s:theme, s:position, s:mode[s:position]], s:memory, "a")
	endif
endfunction

function ShowTheme()
	let l:out = s:themes[s:theme]
	
	if s:themes[s:theme] == "Gruvbox"  || s:themes[s:theme] == "Sonokai"  || 
	\  s:themes[s:theme] == "Edge"     || s:themes[s:theme] == "Rose"	
		let l:out = l:out . " ["
		let l:out = l:out . toupper(s:modes[s:position][s:mode[s:position]][0]) 
		let l:out = l:out . s:modes[s:position][s:mode[s:position]][1:] 
		let l:out = l:out . "]"
	endif

	let g:nametheme = l:out
endfunction

function UpdateTheme()
	:execute 'colorscheme ' . s:namethemes[s:theme]	

	:call ShowTheme()
	:call StatusLine()
endfunction

function UpdateThemeVariation()
	if s:themes[s:theme] == "Gruvbox"
		let g:gruvbox_contrast_dark = s:modes[0][s:mode[0]]
	elseif s:themes[s:theme] == "Sonokai"
		let g:sonokai_style = s:modes[1][s:mode[1]]
	elseif s:themes[s:theme] == "Edge"
		let g:edge_style = s:modes[2][s:mode[2]]
	elseif s:themes[s:theme] == "Rose"
		let g:rose_pine_variant = s:modes[3][s:mode[3]]
	endif
endfunction

function ChangeTheme(way)
	if exists("g:colors_name")
		if !a:way
			let s:theme = s:theme - 1

			if s:theme == -1
				let s:theme = len(s:themes) - 1
			endif
		else
			let s:theme = s:theme + 1

			if s:theme == len(s:themes)
				let s:theme = 0
			endif
		endif

		if s:themes[s:theme] == "Gruvbox"
			let s:position = 0
		elseif s:themes[s:theme] == "Sonokai"
			let s:position = 1
		elseif s:themes[s:theme] == "Edge"
			let s:position = 2
		elseif s:themes[s:theme] == "Rose"
			let s:position = 3
		endif

		:call UpdateThemeVariation()
		:call UpdateTheme()
	else
		let s:theme = 0

		:execute 'colorscheme ' . s:namethemes[s:theme]	
	endif

	:call MemorizeTheme()
endfunction

function ChangeThemeVariation(way)
	if !a:way
		let s:mode[s:position] = s:mode[s:position] - 1
	
		if s:mode[s:position] == -1
			let s:mode[s:position] = len(s:modes[s:position]) - 1
		endif
	else
		let s:mode[s:position] = s:mode[s:position] + 1
	
		if s:mode[s:position] == len(s:modes[s:position])
			let s:mode[s:position] = 0
		endif
	endif

	:call UpdateThemeVariation()
	:call UpdateTheme()

	:call MemorizeTheme()
endfunction

" --------------- Map Keys

map <silent> <F1> :call ChangeTheme(v:false) <CR>
map <silent> <F2> :call ChangeTheme(v:true) <CR>
map <silent> <F3> :call ChangeThemeVariation(v:false) <CR>
map <silent> <F4> :call ChangeThemeVariation(v:true) <CR>
