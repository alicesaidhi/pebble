local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local button = require(script.Parent.Parent.interactable.button)
local padding = require(script.Parent.Parent.util.padding)
local rounded_frame = require(script.Parent.Parent.util.rounded_frame)
local shadow = require(script.Parent.Parent.util.shadow)
local virtualscroller = require(script.Parent.Parent.util.virtualscroller)
local scroll_frame = require(script.Parent.scroll_frame)
local typography = require(script.Parent.typography)

local create = vide.create
local indexes = vide.indexes
local untrack = vide.untrack

type can<T> = T | () -> T
type table = {

	size: can<UDim2>?,

	-- the size of each column in pixels
	column_sizes: () -> {number},

	columns: () -> {{any}},
	max_characters_per_column: number?,

	on_click: (column: number, row: number) -> (),
	on_click2: (column: number, row: number) -> (),
	read_value: (column: number, row: number) -> string,

	below: {[number]: any}?,
	
	[number]: any

}

return function(props: table)

	local function combined_size()
		local size = 8
		for _, column in props.column_sizes() do
			size += column + 8
		end
		return size
	end

	return scroll_frame {
		Size = props.size or UDim2.new(1, 0, 0, 8 * 32),
		CanvasSize = function()
			return UDim2.fromOffset(combined_size(), 0)
		end,

		create "UIListLayout" {
			VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
		},
		
		rounded_frame {
			size = function()
				return UDim2.new(1, 0, 0, 32)
			end,

			topleft = UDim.new(0, 8),
			topright = UDim.new(0, 8),

			color = theme.bg[1],

			padding {
				padding = UDim.new(),
				left = UDim.new(0, 8)
			},

			create "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				Padding = UDim.new(0, 0)
			},

			indexes(props.columns, function(column, i)
				return typography {
					size = function()
						local column_sizes = props.column_sizes()
						return UDim2.new(0, column_sizes[i] + 8, 0, 32)
					end,
					automaticsize = Enum.AutomaticSize.None,
					text = function()
						return column()[1] or ""
					end,
					xalignment = Enum.TextXAlignment.Left,
					header = true,
					textsize = 18,
				}
			end)

		},

		create "Folder" {

			function()
				local dividers = {}
				local n = 0
				for i, size in props.column_sizes() do
					n += size + 8
					table.insert(dividers, untrack(function()
						return create "Frame" {
							Size = UDim2.new(0, 1, 1, -32),
							Position = function()
								return UDim2.fromOffset(n, 0)
							end,
		
							BackgroundColor3 = theme.bg[-1],

							ZIndex = 100
						}
					end))
				end

				return dividers
			end
		},

		virtualscroller {
			size = UDim2.fromScale(1, 0),

			create "UIFlexItem" {
				FlexMode = Enum.UIFlexMode.Grow,
			},

			{
				BackgroundColor3 = theme.bg[0],
				BackgroundTransparency = 0,
			},

			item_size = 32,
			item = function(index)
				
				return create "Frame" {

					Size = UDim2.new(1, 0, 0, 32),

					BackgroundColor3 = theme.bg[2],

					create "UIListLayout" {
						FillDirection = Enum.FillDirection.Horizontal,
						Padding = UDim.new(0, 0)
					},

					create "UIStroke" {
						Color = theme.bg[-1],
					},

					indexes(props.columns, function(column, i)
						return button {
							size = function()
								local column_sizes = props.column_sizes()
								if column_sizes[i] == nil then return UDim2.fromOffset(100, 32) end
								return UDim2.fromOffset(column_sizes[i] + 8, 32)
							end,

							text = function()
								return props.read_value(i, index() + 1) or ""
							end,

							create "UIListLayout" {
								FillDirection = Enum.FillDirection.Horizontal,
								VerticalAlignment = Enum.VerticalAlignment.Center
							},

							xalignment = Enum.TextXAlignment.Left,

							corner = false,
							stroke = false,
							code = true,

							activated = function()
								props.on_click(i, index() + 2)
							end,

							mouse2 = function()
								props.on_click2(i, index() + 2)
							end
						} :: Instance
					end)

				}
	
			end,

			max_items = function()
				local value = (props.columns()[1] ~= nil and #props.columns()[1] or 0)
				return value - 1
			end,
			
	
		},

		rounded_frame {
			size = function()
				return UDim2.new(1, 0, 0, 32)
			end,

			color = theme.bg[1],

			props.below,

			bottomleft = UDim.new(0, 8),
			bottomright = UDim.new(0, 8),
		},

		unpack(props)

	}

end