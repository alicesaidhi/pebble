local vide = require(script.Parent.Parent.Parent.vide)
local button = require(script.Parent.Parent.components.interactable.button)

local create = vide.create
return function(target)

	return vide.mount(function()
		return {
			create "UIListLayout" {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,

				Padding = UDim.new(0, 8)
				
			},

			button {

				position = UDim2.fromScale(0.5, 0.5),
				anchorpoint = Vector2.new(0.5, 0.5),
	
				text = "hello!",
	
				accent = true
	
			},
			button {

				position = UDim2.fromScale(0.5, 0.5),
				anchorpoint = Vector2.new(0.5, 0.5),
	
				text = "hello!",
	
				accent = false
	
			},

			button {

				position = UDim2.fromScale(0.5, 0.5),
				anchorpoint = Vector2.new(0.5, 0.5),
	
				text = "hello!",
	
				accent = true,
				disabled = true
	
			},
			button {

				position = UDim2.fromScale(0.5, 0.5),
				anchorpoint = Vector2.new(0.5, 0.5),
	
				text = "hello!",
	
				accent = false,
				disabled = true
	
			}
		}
	end, target)

end