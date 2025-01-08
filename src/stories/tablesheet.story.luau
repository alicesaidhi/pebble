local vide = require(script.Parent.Parent.Parent.vide)
local pane = require(script.Parent.Parent.components.display.pane)
local tablesheet = require(script.Parent.Parent.components.display.tablesheet)
local typography = require(script.Parent.Parent.components.display.typography)
local button = require(script.Parent.Parent.components.interactable.button)
local row = require(script.Parent.Parent.components.util.row)

return function(target)

	return vide.mount(function()

		local columns = vide.source {
			{"header", "meow", "mraow", "mrrrp", "purr", "ewewasfasdfasfwafweafweafweerwe", "a", "b", "c", "d"},
			{"header", "meow", "mraow", "mrrrp", "purr", "ewewasfasdfasfwafweafweafweerwe", "a", "b", "c", "d"},
			{"header", "meow", "mraow", "mrrrp", "purr", "ewewasfasdfasfwafweafweafweerwe", "a", "b", "c", "d"}
		}
		
		return tablesheet {
			column_sizes = vide.source {100, 200, 100},
			suggested_column_sizes = { 0.1},
			columns = columns,

			read_value = function(column, row)
				return columns()[column][row]
			end,
			on_click = print,
			on_click2 = print,

			max_characters_per_column = 40

		}

	end, target)

end