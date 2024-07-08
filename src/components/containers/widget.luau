local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local oklch = require(script.Parent.Parent.Parent.util.oklch)
local list = require(script.Parent.Parent.util.list)
local padding = require(script.Parent.Parent.util.padding)
local rounded_frame = require(script.Parent.Parent.util.rounded_frame)
local background = require(script.Parent.background)

local create = vide.create
local read = vide.read

type can<T> = T | () -> T
type props = {

	title: can<string>?,
	subtitle: can<string>?

}

return function(props: props)

	local function has_subtitle()
		return not not read(props.subtitle) and read(props.subtitle) ~= ""
	end

	local function has_title()
		return not not read(props.title) and read(props.title) ~= ""
	end

	return rounded_frame {

		name = "Widget",
		size = UDim2.fromOffset(400, 400),

		topleft = UDim.new(0, 8),
		topright = UDim.new(0, 8),
		bottomleft = UDim.new(0, 8),
		bottomright = UDim.new(0, 8),

		color = oklch(0.2, 0.01, 0.6),

		list {
			list = {
				Padding = UDim.new(),
			},

			rounded_frame {

				name = "Header",
				size = anim(function()
					return if has_subtitle() and has_title() then
						UDim2.new(1, 0, 0, 48)
					elseif has_title() then
						UDim2.new(1, 0, 0, 32)
					else
						UDim2.new()
				end),

				topleft = UDim.new(0, 8),
				topright = UDim.new(0, 8),

				color = oklch(0.25, 0.02, 0.6),

				padding {
					left = UDim.new(0, 48)
				},

				list {
					list = {
						Padding = UDim.new(),
						VerticalAlignment = Enum.VerticalAlignment.Center,
						VerticalFlex = Enum.UIFlexAlignment.Fill
					},

					create "TextLabel" {
						Name = "Header",
		
						Size = UDim2.new(1, -48, 0, 20),
		
						BackgroundTransparency = 1,
		
						Text = props.title,
						TextSize = 20,
						TextColor3 = oklch(1, 0.25, 0.7),
						TextXAlignment = Enum.TextXAlignment.Left,
						Font = Enum.Font.GothamBold
		
					},

					create "TextLabel" {
						Name = "Subtitle",
		
						Size = anim(function()
							return if has_subtitle() then
								UDim2.new(1, -48, 0, 20)
							else
								UDim2.new(1, -48, 0, 0)
						end),
		
						BackgroundTransparency = 1,
						TextTransparency = anim(function()
							return if has_subtitle() then 0 else 1
						end),
		
						Text = props.subtitle,
						TextSize = 16,
						TextColor3 = oklch(1, 0.25, 0.7),
						TextXAlignment = Enum.TextXAlignment.Left,
						Font = Enum.Font.Gotham,
					},
				},
				
			},

			create "Frame" {

				Name = "Line",
				Size = UDim2.new(1, 0, 0, 1),
				
				BackgroundColor3 = oklch(1, 1, 0.6),
				BackgroundTransparency = 0.9

			},
		},

	}
	

end