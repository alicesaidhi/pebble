local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.display.background)
local container = require(script.Parent.Parent.components.util.container)
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
					
					container {
						Size = UDim2.new(1, -2, 1, 25),
						Position = UDim2.new(0.5, 0, 1, -2),
						AnchorPoint = Vector2.new(0.5, 1),

						vide.create "UIStroke" {
							vide.create "UIGradient" {
								Transparency = NumberSequence.new({
									NumberSequenceKeypoint.new(0, 1),
									NumberSequenceKeypoint.new(0.875, 1),
									NumberSequenceKeypoint.new(1, 0.8)
								}),
								Rotation = 90
							},
							Thickness = 2
						},

						vide.create "UICorner" {
							CornerRadius = UDim.new(0, 4)
						},
					},

					container {
						Size = UDim2.new(1, -2, 1, 25),
						Position = UDim2.new(0.5, 0, 0, 2),
						AnchorPoint = Vector2.new(0.5, 0),

						vide.create "UIStroke" {
							Color = Color3.new(1, 1, 1),
							vide.create "UIGradient" {
								Transparency = NumberSequence.new({
									NumberSequenceKeypoint.new(0, 1),
									NumberSequenceKeypoint.new(0.875, 1),
									NumberSequenceKeypoint.new(1, 0.8)
								}),
								Rotation = -90
							},
							Thickness = 2
						},

						vide.create "UICorner" {
							CornerRadius = UDim.new(0, 4)
						},
					}
	
				},

			},

		}
	end, target)

end