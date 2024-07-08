local vide = require(script.Parent.Parent.Parent.Parent.vide)
local oklch = require(script.Parent.Parent.Parent.util.oklch)
local container = require(script.Parent.Parent.util.container)

local create = vide.create

return function(props: vide.vFrame)

	return container {

		BackgroundTransparency = 0,

		BackgroundColor3 = oklch(0.2, 0.01, 0.6),

		props

	}

end