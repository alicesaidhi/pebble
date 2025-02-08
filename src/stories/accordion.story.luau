local vide = require(script.Parent.Parent.Parent.vide)
local accordion = require(script.Parent.Parent.components.display.accordion)
local background = require(script.Parent.Parent.components.display.background)
local button = require(script.Parent.Parent.components.interactable.button)
local padding = require(script.Parent.Parent.components.util.padding)

local create = vide.create
return function(target)

	return vide.mount(function()
		local expanded = vide.source(true)
		return background {
			vide.create "UIListLayout" {},
			padding {},

			accordion {
				expanded = expanded,
				set_expanded = expanded,
				text = "accordion 1",

				button {}
			},

			accordion {
				expanded = expanded,
				set_expanded = expanded,
				text = "accordion 1",

				button {}
			}
		}
	end, target)

end