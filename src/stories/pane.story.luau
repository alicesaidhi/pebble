local vide = require(script.Parent.Parent.Parent.vide)
local pane = require(script.Parent.Parent.components.display.pane)
local typography = require(script.Parent.Parent.components.display.typography)
local button = require(script.Parent.Parent.components.interactable.button)
local row = require(script.Parent.Parent.components.util.row)

return function(target)

	return vide.mount(function()
		
		return pane {

			size = UDim2.fromOffset(300, 0),
			position = UDim2.fromScale(0.5, 0.5),
			anchorpoint = Vector2.new(0.5, 0.5),

			name = "pane",

			typography {
				text = "mraow :3"
			},

			row {
			
				justifycontent = Enum.UIFlexAlignment.Fill,

				button {

					text = "bark",

				},
				
				button {

					text = "meow back",
					accent = true
					
				}
			}

		}

	end, target)

end