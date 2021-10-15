" --------------- Telescope Configuration ---------------
lua << EOF
require('telescope').setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
})

require('telescope').load_extension('fzf')
EOF

" --------------- Map Keys

noremap <Space>ff <cmd>Telescope find_files <CR>
noremap <Space>fg <cmd>Telescope live_grep  <CR>
noremap <Space>fb <cmd>Telescope buffers    <CR>
noremap <Space>fh <cmd>Telescope help_tags  <CR>