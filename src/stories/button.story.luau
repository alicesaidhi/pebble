local vide = require(script.Parent.Parent.Parent.vide)
local button = require(script.Parent.Parent.components.interactable.button)
return function(target)

	return vide.mount(function()
		return button {

			position = UDim2.fromScale(0.5, 0.5),
			anchorpoint = Vector2.new(0.5, 0.5)

		}
	end, target)

end