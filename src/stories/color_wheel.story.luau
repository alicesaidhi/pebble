local vide = require(script.Parent.Parent.Parent.vide)
local oklab = require(script.Parent.Parent.libraries.oklab)
local oklch = require(script.Parent.Parent.util.oklch)

local create = vide.create
local source = vide.source

type props = {
	color: () -> Vector3

}

local function color(props)

	return create "Frame" {

		BackgroundColor3 = function()
			local lab = oklab.oklch_to_oklab(props.color() * Vector3.new(1, 1, 1/360))
			local srgb = oklab.oklab_to_linear_srgb(lab)
			return oklab.linear_srgb_to_color3(srgb)
		end,

		create "TextLabel" {
			
			Size = UDim2.new(1, 0, 0, 24),
			Position = UDim2.fromScale(0, 1),
			AnchorPoint = Vector2.new(0, 1),

			BackgroundTransparency = 1,

			TextSize = 14,
			Font = Enum.Font.GothamBold,
			TextColor3 = function()
				return oklch(math.round(1 - props.color().X), 0, 0)
			end,
			Text = function()
				return string.format("%.4g, %.4g, %.4g", props.color().X, props.color().Y, props.color().Z)
			end
		},

		create "UICorner" {
			CornerRadius = UDim.new(0, 8)

		},

	}

end

return function(target)

	return vide.mount(function()

		local function sheets(lightness: number, chroma: number)

			local instances = {}

			for i = 0, 325, 45 do
				table.insert(instances, color {
					color = source(Vector3.new(lightness, chroma, i))
				})
			end

			return create "Frame" {
				
				Size = UDim2.new(1, 0, 0, 64),

				BackgroundTransparency = 1,

				create "UIListLayout" {
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					VerticalFlex = Enum.UIFlexAlignment.Fill,
					FillDirection = Enum.FillDirection.Horizontal,
					Padding = UDim.new(0, 8)
				},

				instances

			}

		end
	
		return {

			create "UIListLayout" {
				Padding = UDim.new(0, 8)
			},

			sheets(0.1, 0.05),
			sheets(0.05, 0.05),

		}

	end, target)

end