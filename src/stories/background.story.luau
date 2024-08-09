local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.display.background)
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
				depth = 1,

				zindex = 10,

				shadow {
					elevation = 4
				},

				background {
					size = UDim2.new(0, 100, 0, 32),
					position = UDim2.fromScale(0.5, 0.5),
					anchorpoint = Vector2.new(0.5, 0.5),
	
					accent = true,

					zindex = 10,

					vide.create "UICorner" {
						CornerRadius = UDim.new(0, 4)
					},

					shadow {
						transparency = 0
					},
	
				},

			},

		}
	end, target)

end