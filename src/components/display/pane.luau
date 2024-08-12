local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local list = require(script.Parent.Parent.util.list)
local padding = require(script.Parent.Parent.util.padding)

local create = vide.create

type can<T> = T | () -> T
type props = {

	size: can<UDim2>?,
	position: can<UDim2>?,
	anchorpoint: can<UDim2>?,

	name: can<string>,

	[number]: Instance

}

return function(props: props)

	return create "Frame" {

		Name = props.name,

		Size = props.size,
		Position = props.position,
		AnchorPoint = props.anchorpoint,
		AutomaticSize = Enum.AutomaticSize.XY,

		BackgroundColor3 = theme.bg[-1],

		create "UICorner" {
			CornerRadius = UDim.new(0, 8)
		},

		create "UIStroke" {

			Color = theme.bg[-3]

		},

		padding {},

		list {
			unpack(props)
		}

	}
end