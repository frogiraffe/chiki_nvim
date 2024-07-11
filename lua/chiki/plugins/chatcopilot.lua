return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		opts = {
			show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
			debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
			-- temperature = 0.1,
		},
		build = function()
			vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
		end,
		-- event = "VeryLazy",
		keys = {
			{ "<leader>ccb", ":CopilotChatBuffer ",         desc = "CopilotChat - Chat with current buffer" },
			{ "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
			{ "<leader>cct", "<cmd>CopilotChatTests<cr>",   desc = "CopilotChat - Generate tests" },
			{
				"<leader>ccT",
				"<cmd>CopilotChatVsplitToggle<cr>",
				desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
			},
			{
				"<leader>ccv",
				":CopilotChatVisual ",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{
				"<leader>ccx",
				":CopilotChatInPlace<cr>",
				mode = "x",
				desc = "CopilotChat - Run in-place code",
			},
			{
				"<leader>ccf",
				"<cmd>CopilotChatFixDiagnostic<cr>", -- Get a fix for the diagnostic message under the cursor.
				desc = "CopilotChat - Fix diagnostic",
			},
			{
				"<leader>ccr",
				"<cmd>CopilotChatReset<cr>", -- Reset chat history and clear buffer.
				desc = "CopilotChat - Reset chat history and clear buffer",
			},
		},
		config = function()
			local chat = require('CopilotChat')
			local select = require('CopilotChat.select')

			chat.setup {
				-- Restore the behaviour for CopilotChat to use unnamed register by default
				selection = select.unnamed,
				-- Restore the format with ## headers as prefixes,
				question_header = '## User ',
				answer_header = '## Copilot ',
				error_header = '## Error ',
			}

			-- Restore CopilotChatVisual
			vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = '*', range = true })

			-- Restore CopilotChatInPlace (sort of)
			vim.api.nvim_create_user_command('CopilotChatInPlace', function(args)
				chat.ask(args.args, { selection = select.visual, window = { layout = 'float' } })
			end, { nargs = '*', range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = '*', range = true })

			-- Restore CopilotChatVsplitToggle
			vim.api.nvim_create_user_command('CopilotChatVsplitToggle', chat.toggle, {})
		end
	},
}
