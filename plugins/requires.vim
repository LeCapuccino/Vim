" --------------- Require Plugins ---------------

"lua require('shade').setup()
lua require('colorizer').setup()

lua << EOF
--[[
local icons = require('nvim-web-devicons').get_icons()

for name, icon in pairs(icons) do
	print(name, icon)
end
--]]
EOF