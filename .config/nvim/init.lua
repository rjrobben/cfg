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

vim.keymap.set({ 'v' }, '<leader>F', ':/%V')
vim.keymap.set({ 't' }, '<Esc>', '<C-\\><C-n>')


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
	-- { src = "https://github.com/julienvincent/nvim-paredit" },
	{ src = "https://github.com/loctvl842/monokai-pro.nvim" },
	{ src = "https://github.com/mrcjkb/rustaceanvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/bakpakin/fennel.vim" },
	{ src = "https://github.com/guns/vim-sexp" },
	{ src = "https://github.com/tpope/vim-sexp-mappings-for-regular-people" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
	{ src = "https://github.com/Olical/nfnl" },

})


-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		-- Helper for mappings
		local opts = { buffer = args.buf, silent = true }

		-- === 1. GOTO MAPPINGS ===
		-- Neovim 0.10+ Defaults:
		-- 'gd' -> vim.lsp.buf.definition()
		-- 'gI' -> vim.lsp.buf.implementation()
		-- 'gy' -> vim.lsp.buf.type_definition()
		-- 'grr' -> vim.lsp.buf.references() (Note the double 'r')

		-- OVERRIDES (If you prefer the classic 'gr' behavior):
		vim.keymap.set('n', 'gy', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf, desc = "Go to Definition" })

		-- TypeScript Specific: "Go to Source Definition"
		-- This prevents jumping to .d.ts files in node_modules
		if client.name == "ts_ls" or client.name == "vtsls" then
			vim.keymap.set('n', 'gs', function()
				vim.lsp.buf.execute_command({
					command = "_typescript.goToSourceDefinition",
					arguments = { vim.api.nvim_buf_get_name(0), vim.api.nvim_win_get_cursor(0) }
				})
			end, opts)
		end
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".

		-- if not client:supports_method('textDocument/willSaveWaitUntil')
		--     and client:supports_method('textDocument/formatting') then
		-- 	vim.api.nvim_create_autocmd('BufWritePre', {
		-- 		group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
		-- 		buffer = args.buf,
		-- 		callback = function()
		-- 			vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
		-- 		end,
		-- 	})
		-- end
	end,
})

-- 1. Set the fold method to use an expression
vim.opt.foldmethod = "expr"

-- 2. Use the built-in Lua fold expression (Better for TypeScript than the old nvim_treesitter#foldexpr)
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- 3. "Default No Fold": Open the file with all folds expanded
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

vim.opt.completeopt = { "menu", "menuone", "noselect" }


vim.lsp.enable({
	"lua_ls",
	"tinymist",
	"clojure_lsp",
	"rust_analyzer",
	"fennel_language_server",
	"postgres_lsp",
	"ts_ls"

})

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

-- rust
require('nvim-treesitter.configs').setup {
	ensure_installed = { "rust", "toml", "sql" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "sql" }, },
	-- rainbow = {
	-- 	enable = true,
	-- 	extended_mode = true,
	-- 	max_file_lines = nil,
	-- },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = false,
			node_incremental = "af",
			node_decremental = "iF",
		},
	},
}

vim.g['conjure#extract#tree_sitter#enabled'] = true


-- paredit
-- local paredit = require("nvim-paredit")
-- paredit.setup({
-- 	-- Change some keys
-- 	keys = {
-- 		["<localleader>w"] = { paredit.api.select_around_form, "Select around form" },
-- 		["<localleader>W"] = { paredit.api.select_around_top_level_form, "Select around top level form" },
-- 		["<localleader>ml"] = { paredit.api.slurp_forwards, "Slurp forward" },
-- 		["<localleader>mh"] = { paredit.api.barf_forwards, "Barf forward" },
-- 		["<localleader>mj"] = { paredit.api.slurp_backwards, "Slurp backward" },
-- 		["<localleader>mk"] = { paredit.api.barf_backwards, "Barf backward" },
-- 	},
-- })


require("nvim-surround").setup()

-- vim-sexp config
vim.g.sexp_filetypes = "clojure,scheme,lisp,fennel"

-- Fennel formatting on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.fnl",
	callback = function()
		vim.cmd("!fnlfmt --fix %")
		vim.cmd("e")
		vim.cmd("NfnlCompileFile")
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'clojure' },
	callback = function() vim.treesitter.start() end,
})

-- Open binary files with Preview
vim.api.nvim_create_autocmd("BufReadCmd", {
	pattern = { "*.pdf", "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
	callback = function()
		local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
		vim.cmd("silent !open " .. filename)
		vim.cmd("bprevious | bdelete! #")
	end
})

-- conjure
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
-- Override default files picker to include hidden
MiniPick.registry.files = function()
	return MiniPick.builtin.cli({ command = { 'rg', '--files', '--hidden' } })
end

require "mini.files".setup()
require "mini.icons".setup({ style = 'ascii' })
require "mini.diff".setup()
require "mini.sessions".setup()
require "mini.comment".setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "ledger",
	callback = function()
		vim.bo.commentstring = "; %s"
	end,
})

vim.keymap.set('n', '<leader>b', ":Oil<CR>")



vim.keymap.set('n', '<leader>f', ":PickFiles<CR>")
vim.keymap.set('n', '<leader><S-f>', ":PickGrepLive<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")

vim.keymap.set('n', '<leader>e', ":lua MiniFiles.open()<CR>")


vim.keymap.set('n', '<leader>R', ":lua MiniSessions.write('Session.vim')<CR>")
vim.keymap.set('n', '<leader>r', ":lua MiniSessions.read()<CR>")


vim.keymap.set('n', '<leader><Tab>', ":bn<CR>")
vim.keymap.set('n', '<leader><S-Tab>', ":bp<CR>")



-- inkscape
--
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typ", "typst" }, -- match your filetype
	callback = function()
		vim.keymap.set('i', '<C-f>', function()
			local line = vim.fn.getline('.')
			local root = vim.fn.expand('%:p:h') -- directory of current .typ file
			vim.cmd('silent exec ".!inkscape-figures create \\"' ..
				line .. '\\" \\"' .. root .. '/figures/\\""')
			vim.cmd('w')
		end, { buffer = true, noremap = true, silent = true })

		vim.keymap.set('n', '<C-f>', function()
			local root = vim.fn.expand('%:p:h')
			vim.cmd('silent exec "!inkscape-figures edit \\"' .. root .. '/figures/\\" > /dev/null 2>&1 &"')
			vim.cmd('redraw!')
		end, { buffer = true, noremap = true, silent = true })
	end
})


vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "md", "pandoc" }, -- match markdown filetypes
	callback = function()
		-- Create new figure in Insert mode
		vim.keymap.set('i', '<C-f>', function()
			local line = vim.fn.getline('.')
			local root = vim.fn.expand('%:p:h') -- directory of current .md file
			-- Added --format markdown
			vim.cmd('silent exec ".!inkscape-figures create --format markdown \\"' ..
				line .. '\\" \\"' .. root .. '/figures/\\""')
			vim.cmd('w')
		end, { buffer = true, noremap = true, silent = true })

		-- Edit existing figures in Normal mode
		vim.keymap.set('n', '<C-f>', function()
			local root = vim.fn.expand('%:p:h')
			-- Added --format markdown (optional for 'edit' but good for consistency depending on how the tool parses args)
			vim.cmd('silent exec "!inkscape-figures edit \\"' .. root .. '/figures/\\" > /dev/null 2>&1 &"')
			vim.cmd('redraw!')
		end, { buffer = true, noremap = true, silent = true })
	end
})

-- LuaSnip
--
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })

local ls = require("luasnip")
local map = vim.keymap.set

map({ "i", "s" }, "<C-K>", function() ls.expand_or_jump(1) end, { silent = true })
map({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
map({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

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


-- clerk
local function clerk_show()
	vim.cmd("w") -- Save the file
	-- Construct the command with the expanded file path
	local file_path = vim.fn.expand("%:p")
	vim.cmd(string.format('ConjureEval (nextjournal.clerk/show! "%s")', file_path))
end
vim.api.nvim_create_user_command("ClerkShow", clerk_show, {})
vim.keymap.set("n", "<localleader>cs", clerk_show, { silent = true, desc = "Show Clerk" })

-- custom plugin
require("hello").setup()
require("history").setup()
