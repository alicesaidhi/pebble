local vide = require(script.Parent.Parent.Parent.vide)
local tabs = require(script.Parent.Parent.components.display.pages)
local typography = require(script.Parent.Parent.components.display.typography)


return function(target)

	return vide.mount(function()
		
		return tabs {

			labels = vide.source {

				{
					title = "Home",
					ui = function()
						return typography {text = "1"}
					end
				},

				{
					title = "Model",
					ui = function()
						return typography {text = "2"}
					end
				},
				{
					title = "Avatar",
					ui = function()
						return typography {text = "3"}
					end
				},
				
			}

		}

	end, target)

end