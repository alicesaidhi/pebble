local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local theme = require(script.Parent.Parent.Parent.util.theme)
local unwrap = require(script.Parent.Parent.Parent.util.unwrap)

local create = vide.create
local source = vide.source
local read = vide.read

type can<T> = (() -> T) | T
type props = {
	size: can<UDim2>?,
	position: can<UDim2>?,
	anchorpoint: can<Vector2>?,

	elevation: can<number>?,
	elevation_increment: can<boolean>?,

	[number]: any
}

return function(props: props)

	local elevation = source(0)
	local zindex = source(0)

	local background_color = theme.get_appropriate_color {
		foreground = theme.theme.background,
		elevation = props.elevation or elevation,
		min_contrast = 15,
	}

	local function increment_if(elevation: vide.Source<can<number>>, v: can<boolean>?)
		if read(v) then
			return function(n: can<number>)
				elevation(function()
					return unwrap(n) + 1
				end)
			end
		else
			return elevation
		end
	end

	return create "Frame" {
		Name = "Background",

		Size = props.size or UDim2.fromScale(1, 1),
		Position = props.position,
		AnchorPoint = props.anchorpoint,

		BackgroundColor3 = anim(background_color),

		theme.elevation.receive(increment_if(elevation, props.elevation_increment)),
		theme.elevation.send(elevation),
		theme.color.send(background_color),
		theme.zindex_increment(zindex),

		ZIndex = function()
			return unwrap(zindex) * 1000
		end,

		unpack(props)

	}

end