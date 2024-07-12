
--[[

```lua

create "Frame" {

	--- automatically selects a background layer based on the 
	theme.background,



}


```

]]

local vide = require(script.Parent.Parent.Parent.vide)
local padding = require(script.Parent.Parent.components.util.padding)
local theme = require(script.Parent.Parent.util.theme)

local create = vide.create

return function(target)

	return vide.mount(function()
		return create "Frame" {

			Size = UDim2.fromScale(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			
			theme.background(),

			padding {
				x = UDim.new(0, 16),
				y = UDim.new(0, 64)
			},
			
			create "Frame" {

				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				
				theme.background(),
	
				padding {
					x = UDim.new(0, 16),
					y = UDim.new(0, 64)
				},

				create "TextLabel" {

					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					
					theme.background(),
					theme.text(42),

					Text = "teeest!",
		
					padding {
						x = UDim.new(0, 4),
						y = UDim.new(0, 4)
					},
					
		
				}
				
	
			}
		}

	end, target)

end