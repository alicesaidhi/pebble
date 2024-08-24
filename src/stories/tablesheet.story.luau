local vide = require(script.Parent.Parent.Parent.vide)
local pane = require(script.Parent.Parent.components.display.pane)
local tablesheet = require(script.Parent.Parent.components.display.tablesheet)
local typography = require(script.Parent.Parent.components.display.typography)
local button = require(script.Parent.Parent.components.interactable.button)
local row = require(script.Parent.Parent.components.util.row)

return function(target)

	return vide.mount(function()
		
		return tablesheet {
			column_sizes = vide.source {100, 100, 100},
			columns = vide.source {
				table.create(10, "meow"),
				table.create(10, "meow"),
				table.create(10, "meow")
			},
			max_characters_per_column = 40

		}

	end, target)

end