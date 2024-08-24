local vide = require(script.Parent.Parent.Parent.vide)
local select = require(script.Parent.Parent.components.interactable.select)

return function(target)


	return vide.mount(function()
		local selected = vide.source(1)	
		return select {
			selected = selected,
			update_selected = selected,
			options = {
				"bwa",
				"mrow"
			},
		}

	end, target)

end