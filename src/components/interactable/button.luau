local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local theme = require(script.Parent.Parent.Parent.util.theme)
local unwrap = require(script.Parent.Parent.Parent.util.unwrap)

local create = vide.create
local source = vide.source
local changed = vide.changed
local spring = vide.spring

type can<T> = (() -> T) | T
type props = {
	size: can<UDim2>?,
	position: can<UDim2>?,
	anchorpoint: can<Vector2>?

}

return function(props: props)

	local elevation = source(0)
	local zindex = source(0)

	local background_color = theme.get_appropriate_color {
		foreground = theme.theme.foreground,
		elevation = elevation,
		min_contrast = 15
	}
	local hover_color = theme.get_appropriate_color {
		foreground = theme.theme.foreground_hover,
		elevation = elevation,
		min_contrast = 15
	}
	local pressed_color = theme.get_appropriate_color {
		foreground = theme.theme.foreground_press,
		elevation = elevation,
		min_contrast = 15
	}
	local border_color = theme.get_appropriate_color {
		foreground = theme.theme.border,
		elevation = elevation,
		min_contrast = 15
	}

	local gui_state = source(Enum.GuiState.Idle)

	return create "TextButton" {

		Name = "Button",

		Size = props.size or UDim2.fromOffset(100, 34),
		Position = props.position,
		AnchorPoint = props.anchorpoint,

		BackgroundColor3 = spring(function()
			return if gui_state() == Enum.GuiState.Press then
				pressed_color()
			elseif gui_state() == Enum.GuiState.Hover then
				hover_color()
			else
				background_color()
		end, 0.1),

		ZIndex = function()
			return unwrap(zindex) * 1000 + 100
		end,

		create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = border_color
		},

		create "UICorner" {
			CornerRadius = theme.theme.corner_interactable
		},
		
		changed("GuiState", gui_state),

		theme.elevation.receive(elevation),
		theme.zindex_increment(zindex),		
	}


end