local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local oklch = require(script.Parent.Parent.Parent.util.oklch)
local padding = require(script.Parent.Parent.util.padding)

local create = vide.create
local source = vide.source
local spring = vide.spring
local changed = vide.changed

type can<T> = T | () -> T
type props = {

	position: can<UDim2>?,
	size: can<UDim2>?,
	anchor_point: can<UDim2>?,

	text: can<string>,

	activated: () -> ()?,
	down: () -> ()?,
	up: () -> ()?

}

return function(props: props)

	local gui_state = source(Enum.GuiState.Idle)

	return create "TextButton" {

		Size = props.size or UDim2.fromOffset(100, 32),
		Position = props.position,
		AnchorPoint = props.anchor_point,

		BackgroundColor3 = anim(function()
			return oklch(
				if gui_state() == Enum.GuiState.Press then 0.15 else 0.3,
				0.01,
				0.6
			)
		end),
		BackgroundTransparency = anim(function()
			return if gui_state() == Enum.GuiState.Idle then
				0.8
			else
				0.5
		end),

		Text = props.text,
		TextSize = 18,
		TextColor3 = oklch(0.8, 0.01, 0.6),
		Font = Enum.Font.GothamMedium,

		create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = oklch(0.25, 0.01, 0.6)
		},

		create "UICorner" {
			CornerRadius = UDim.new(0, 8)
		},

		changed("GuiState", gui_state)

	}

end