local vide = require(script.Parent.Parent.Parent.vide)
local typography = require(script.Parent.Parent.components.display.typography)
local widget = require(script.Parent.Parent.components.display.widget)

local source = vide.source
local effect = vide.effect
local batch = vide.batch
local untrack = vide.untrack

return function(target)

	return vide.mount(function()
		
		return widget {
			title = "widget testing errrrrrrrrrr",
			subtitle = "hey!",

			typography {
				text = "hello!"
			}

		}

	end, target)
	

end