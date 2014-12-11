" --------------------------
" Python
" --------------------------
setlocal tabstop=4                " number of spaces per <tab>
setlocal shiftwidth=4             " number of spaces per indent
setlocal softtabstop=4            " <BS> over indent deletes all spaces
setlocal autoindent               " Indent when starting a new line
setlocal textwidth=79             " PEP-8
setlocal colorcolumn=80
nmap <leader>b oimport pdb; pdb.set_trace()  # BREAKPOINT<ESC>
