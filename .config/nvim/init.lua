vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = ","


vim.keymap.set({ 'n', 'v', 'x' }, '<leader>v', ':e $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>w', ':w<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>q', ':q<CR>')

vim.keymap.set({'v'}, '<leader>F', ':/%V')
vim.keymap.set({'t'}, '<Esc>', '<C-\\><C-n>')


vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.files" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/echasnovski/mini.diff" },
	{ src = "https://github.com/echasnovski/mini.sessions" },
	{ src = "https://github.com/echasnovski/mini.comment" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/Olical/conjure" },
	{ src = "https://github.com/julienvincent/nvim-paredit" },
	{ src = "https://github.com/yorickpeterse/vim-paper" },
	{ src = "https://github.com/thesimonho/kanagawa-paper.nvim" },
	{ src = "https://github.com/sainnhe/sonokai" },
	{ src = "https://github.com/loctvl842/monokai-pro.nvim" },
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
		["<localleader>W"] = { paredit.api.select_around_top_level_form, "Select around top level form" },
		["<localleader>ml"] = { paredit.api.slurp_forwards, "Slurp forward" },
		["<localleader>mh"] = { paredit.api.barf_forwards, "Barf forward" },
		["<localleader>mj"] = { paredit.api.slurp_backwards, "Slurp backward" },
		["<localleader>mk"] = { paredit.api.barf_backwards, "Barf backward" },
	},
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'clojure' },
	callback = function() vim.treesitter.start() end,
})

-- conjure
vim.g["conjure#client#sql#stdio#command"] = "psql postgresql://lawben-search:lawben-search@pop-os.tailbbca68.ts.net:5433/lawben-search_dev_v2"
vim.g["conjure#log#wrap"] = true

-- file explorer
require "oil".setup({
	columns = {
		“permissions”,
		“size”,
	},
	keymaps = {
		['yp'] = {
			desc = 'Copy filepath to system clipboard',
			callback = function()
				require('oil.actions').yank_entry.callback()
			end,
		},
	},
})

require "mini.pick".setup()
require "mini.files".setup()
require "mini.icons".setup({ style = 'ascii' })
require "mini.diff".setup()
require "mini.sessions".setup()
require "mini.comment".setup()

vim.keymap.set('n', '<leader>b', ":Oil<CR>")

vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader><S-f>', ":Pick grep_live<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

vim.keymap.set('n', '<leader>e', ":lua MiniFiles.open()<CR>")


vim.keymap.set('n', '<leader>R', ":lua MiniSessions.write('Session.vim')<CR>")
vim.keymap.set('n', '<leader>r', ":lua MiniSessions.read()<CR>")


vim.keymap.set('n', '<leader><Tab>', ":bn<CR>")
vim.keymap.set('n', '<leader><S-Tab>', ":bp<CR>")


-- color theme


require("monokai-pro").setup({
	filter = "light",
	overridePalette = function(filter)
		return {
			dark2 = "#d2c9c4",
			dark1 = "#eee5de",
			background = "#f8efe7",
			text = "#2c232e",
			accent1 = "#ce4770",
			accent2 = "#d4572b",
			accent3 = "#b16803",
			accent4 = "#218871",
			accent5 = "#2473b6",
			accent6 = "#6851a2",
			dimmed1 = "#72696d",
			dimmed2 = "#92898a",
			dimmed3 = "#a59c9c",
			dimmed4 = "#beb5b3",
			dimmed5 = "#d2c9c4",
			panel = "#fdf7f3",
			light = "#fffcfa",
		}
	end,

	override = function(c)
		return {
			CursorLine = { bg = c.base.dimmed3 },  -- This affects MiniPickMatchCurrent
			NormalFloat = { bg = c.base.background, fg = c.base.text }, -- MiniPickNormal links to this
			Visual = { bg = c.base.dimmed4 },      -- For MiniPickMatchMarked
			DiagnosticFloatingHint = { fg = c.base.accent2 }, -- For MiniPickMatchRanges
		}
	end,
})

vim.o.background = "light"
vim.cmd("colorscheme monokai-pro")
vim.o.termguicolors = true
