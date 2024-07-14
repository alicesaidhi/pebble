local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.containers.background)
local padding = require(script.Parent.Parent.components.util.padding)
local shadow = require(script.Parent.Parent.components.util.shadow)

return function(target)

	return vide.mount(function()
		return background {
			padding {},


			background {
				size = UDim2.fromScale(0.5, 0.5),
				position = UDim2.fromScale(0.5, 0.5),
				anchorpoint = Vector2.new(0.5, 0.5),

				elevation = 10,

				shadow {
					elevation = 8
				}
			}
		}
	end, target)

end