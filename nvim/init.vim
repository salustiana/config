let mapleader = " "

noremap <Leader>y "+y
noremap <Leader>p "+p

set number

set nohlsearch

set t_Co=256
filetype plugin indent on
syntax on

autocmd FileType html* setlocal nowrap tabstop=4 shiftwidth=4
autocmd FileType python map <Leader><CR> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

set complete=.,w,b,u,t,i

call plug#begin()

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'

call plug#end()

" fzf vim
nnoremap <C-p> :Files<CR>
nnoremap <C-l> :Rg<CR>

" colorscheme
set background=dark
colorscheme PaperColor

lua << EOF
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

	local custom_lsp_attach = function(client)
		-- remove diagnostics from left column
		vim.diagnostic.config({signs=false})
		-- See `:help nvim_buf_set_keymap()` for more information
		vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
		-- ... and other keymappings for LSP

		-- Use LSP as the handler for omnifunc.
		--    See `:help omnifunc` and `:help ins-completion` for more information.
		vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

		-- Use LSP as the handler for formatexpr.
		--    See `:help formatexpr` for more information.
		vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap=true, silent=true, buffer=bufnr }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
		vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
		vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)

		-- For plugins with an `on_attach` callback, call them here. For example:
		-- require('completion').on_attach()
	end

	-- Configuring for `clangd`,

	require('lspconfig').clangd.setup({
	-- An example of settings for an LSP server.
	-- For more options, see nvim-lspconfig
		on_attach = custom_lsp_attach
	})

	-- Configuration for `gopls`,
	require('lspconfig').gopls.setup({
		on_attach = custom_lsp_attach
	})

	-- Configuration for `pyright`,
	require('lspconfig').pyright.setup({
		on_attach = custom_lsp_attach
	})
EOF
