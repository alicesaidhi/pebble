local vide = require(script.Parent.Parent.Parent.vide)
local pane = require(script.Parent.Parent.components.display.pane)
local typography = require(script.Parent.Parent.components.display.typography)
local virtualscroller = require(script.Parent.Parent.components.util.virtualscroller)
return function(target)

	return vide.mount(function()
	
		return virtualscroller {

			item = function(index)
				return pane {

					name = "",

					size = UDim2.new(1, 0, 0, 25),

					typography {

						size = UDim2.fromScale(1, 1),
	
						text = function()
							return `item {index()}`
						end
	
					}

				}
			end,
			
			item_size = 32,

			max_items = vide.source(300)

		}

	end, target)

end