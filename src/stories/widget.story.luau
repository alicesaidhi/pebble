local vide = require(script.Parent.Parent.Parent.vide)
local widget = require(script.Parent.Parent.components.display.widget)

local source = vide.source
local effect = vide.effect
local batch = vide.batch
local untrack = vide.untrack

return function(target)

	return vide.mount(function()
		
		return widget {
			title = "widget testing errrrrrrrrrr",
			subtitle = "hey!"

		}

	end, target)
	

end