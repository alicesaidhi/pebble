local vide = require(script.Parent.Parent.Parent.vide)
local basebutton = require(script.Parent.Parent.components.button.basebutton)
local background = require(script.Parent.Parent.components.containers.background)

return function(target)
	return vide.mount(function()
		return background {

			basebutton {

				position = UDim2.fromScale(0.5, 0.5),
				anchor_point = Vector2.new(0.5, 0.5),
				text = "she"

			}

		}
	end, target)

end