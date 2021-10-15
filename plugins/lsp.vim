" --------------- Language Servers Configuration ---------------

let g:pyright_path = 'c:\\users\\priscila\\appdata\\roaming\\npm\\'

lua << EOF
require'lspconfig'.pyright.setup{}
EOF