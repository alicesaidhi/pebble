local vide = require(script.Parent.Parent.Parent.vide)
local apcaw3 = require(script.Parent.Parent.libraries.apcaw3)
local oklab = require(script.Parent.Parent.libraries.oklab)
local oklch = require(script.Parent.Parent.util.oklch)
local theme = require(script.Parent.Parent.util.theme)

local create = vide.create
local source = vide.source
local values = vide.values

type props = {
	name: number,
	bg: () -> Color3,
	fg_low: () -> Color3,
	fg_high: () -> Color3
}

local t = {}

for i = -10, 10 do
	table.insert(t, i)
end

local function color(props: props)

	return create "Frame" {

		Name = props.name,

		Size = UDim2.fromOffset(50, 50),
		LayoutOrder = props.name,

		BackgroundColor3 = props.bg,

		create "TextLabel" {
			
			Size = UDim2.new(1, 0, 0, 24),
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),

			BackgroundTransparency = 1,

			TextSize = 14,
			Font = Enum.Font.GothamBold,
			TextColor3 = props.fg_high,
			Text = props.name,
			
		},

		create "TextLabel" {
			
			Size = UDim2.new(1, 0, 0, 24),
			Position = UDim2.new(0, 0, 1, -24),
			AnchorPoint = Vector2.new(0, 1),

			BackgroundTransparency = 1,

			TextSize = 14,
			Font = Enum.Font.GothamBold,
			TextColor3 = props.fg_low,
			Text = props.name,
			
		},

		create "UICorner" {
			CornerRadius = UDim.new(0, 8)
		},

	}

end

return function(target)

	return vide.mount(function()

		return {

			create "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, -16),
				Wraps = true
			},

			create "Frame" {
				Size = UDim2.new(1, 0, 0, 64),

				BackgroundTransparency = 1,

				create "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, -16)
				},
				
				values(source(t), function(index)
					return color {
						name = index,
						bg = theme.bg[index],
						fg_high = theme.fg_on_bg_high[index],
						fg_low = theme.fg_on_bg_low[index]
					}
				end),

			},

			create "Frame" {
				Size = UDim2.new(1, 0, 0, 64),
				BackgroundTransparency = 1,

				create "UIListLayout" {
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, -16)
				},
				
				values(source(t), function(index)
					return color {
						name = index,
						bg = theme.acc[index],
						fg_high = theme.fg_on_acc_high[index],
						fg_low = theme.fg_on_acc_low[index]
					}
				end)

			},


		}

	end, target)

end