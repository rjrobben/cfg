vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = ","


vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>w', ':w<CR>')


vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.files" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/Olical/conjure" },
	{ src = "https://github.com/julienvincent/nvim-paredit" },
	{ src = "https://github.com/yorickpeterse/vim-paper" },
	{ src = "https://github.com/thesimonho/kanagawa-paper.nvim" },
})


-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")


vim.lsp.enable({ "lua_ls", "tinymist", "clojure_lsp" })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- paredit
local paredit = require("nvim-paredit")
paredit.setup({
	-- Change some keys
	keys = {
		["<localleader>w"] = { paredit.api.select_around_form, "Select around form" },
		["<localleader>W"] = { paredit.api.select_around_top_level_form, "Select around form" },
	},
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'clojure' },
	callback = function() vim.treesitter.start() end,
})


-- file explorer
require "oil".setup({
	columns = {
		“permissions”,
		“size”,
	},
})

require "mini.pick".setup()
require "mini.files".setup()
require "mini.icons".setup({style = 'ascii'})

vim.keymap.set('n', '<leader>b', ":Oil<CR>")

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader><S-f>', ":Pick grep_live<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

vim.keymap.set('n', '<leader>e', ":lua MiniFiles.open()<CR>")


-- color theme
vim.o.background = "light"
vim.cmd("colorscheme paper")
vim.o.termguicolors = true
