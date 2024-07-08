local vide = require(script.Parent.Parent.Parent.vide)
local widget = require(script.Parent.Parent.components.containers.widget)
local list = require(script.Parent.Parent.components.util.list)
local row = require(script.Parent.Parent.components.util.row)
local reduced_motion = require(script.Parent.Parent.util.reduced_motion)

return function(target)

	return vide.mount(function()
		local s = vide.source("")

		task.delay(1, s, "149/532 MB")

		return row {

			list {
				layout = {
					Size = UDim2.new(),
					AutomaticSize = Enum.AutomaticSize.XY
				},
				widget {
					title = "pebble",
					subtitle = "some subtitle - idk?? gorp explore"
				},
	
				widget {
					title = "performance",
					subtitle = s
				}
	
			},

			reduced_motion:provide(function()
				return list {
					
					widget {
						title = "gorp"
					},
		
					widget {
						title = "runtime",
						subtitle = s
					}
		
		
				}
			end)(true)

		}
	end, target)

end