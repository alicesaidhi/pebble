local vide = require(script.Parent.Parent.Parent.vide)
local textfield = require(script.Parent.Parent.components.interactable.textfield)


return function(target)

	return vide.mount(function()
	
		return textfield {

			position = UDim2.fromScale(0.5, 0.5),
			anchorpoint = Vector2.new(0.5, 0.5),

			placeholder = "asasd",

			focuslost = print,
			oninput = print,
			enter = print
		}
		
	end, target)

end