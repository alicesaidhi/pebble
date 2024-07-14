local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local unwrap = require(script.Parent.Parent.Parent.util.unwrap)

local create = vide.create
local source = vide.source
local read = vide.read

local shadow_data = {
	[0] = {
		ambient = {
			opacity = 0,
			blur = 0,
		},

		penumbra = {
			opacity = 0,
			blur = 0,
		},

		umbra = {
			opacity = 0,
			blur = 0,
		},
	},

	[1] = {
		ambient = {
			opacity = 0.2,
			blur = 3,
			offset = UDim2.new(0, 0, 0, 1),
		},

		penumbra = {
			opacity = 0.12,
			blur = 2,
			offset = UDim2.new(0, 0, 0, 2),
		},

		umbra = {
			opacity = 0.14,
			blur = 2,
		},
	},

	[2] = {
		ambient = {
			opacity = 0.2,
			blur = 5,
			offset = UDim2.new(0, 0, 0, 1),
		},

		penumbra = {
			opacity = 0.12,
			blur = 4,
			offset = UDim2.new(0, 0, 0, 3),
		},

		umbra = {
			opacity = 0.14,
			blur = 4,
		},
	},

	[3] = {
		ambient = {
			opacity = 0.2,
			blur = 8,
			offset = UDim2.new(0, 0, 0, 1),
		},

		penumbra = {
			opacity = 0.12,
			blur = 4,
			offset = UDim2.new(0, 0, 0, 3),
		},

		umbra = {
			opacity = 0.14,
			blur = 3,
			offset = UDim2.new(0, 0, 0, 3),
		},
	},

	[4] = {
		ambient = {
			opacity = 0.2,
			blur = 10,
			offset = UDim2.new(0, 0, 0, 1),
		},

		penumbra = {
			opacity = 0.12,
			blur = 5,
			offset = UDim2.new(0, 0, 0, 4),
		},

		umbra = {
			opacity = 0.14,
			blur = 4,
			offset = UDim2.new(0, 0, 0, 2),
		},
	},

	[6] = {
		ambient = {
			opacity = 0.2,
			blur = 5,
			offset = UDim2.new(0, 0, 0, 3),
		},

		penumbra = {
			opacity = 0.12,
			blur = 18,
			offset = UDim2.new(0, 0, 0, 1),
		},

		umbra = {
			opacity = 0.14,
			blur = 10,
			offset = UDim2.new(0, 0, 0, 6),
		},
	},

	[8] = {
		ambient = {
			opacity = 0.2,
			blur = 15,
			offset = UDim2.new(0, 0, 0, 4),
		},

		penumbra = {
			opacity = 0.12,
			blur = 14,
			offset = UDim2.new(0, 0, 0, 3),
		},

		umbra = {
			opacity = 0.14,
			blur = 10,
			offset = UDim2.new(0, 0, 0, 8),
		},
	},

	[9] = {
		ambient = {
			opacity = 0.2,
			blur = 6,
			offset = UDim2.new(0, 0, 0, 5),
		},

		penumbra = {
			opacity = 0.12,
			blur = 16,
			offset = UDim2.new(0, 0, 0, 3),
		},

		umbra = {
			opacity = 0.14,
			blur = 12,
			offset = UDim2.new(0, 0, 0, 9),
		},
	},

	[12] = {
		ambient = {
			opacity = 0.2,
			blur = 8,
			offset = UDim2.new(0, 0, 0, 7),
		},

		penumbra = {
			opacity = 0.12,
			blur = 22,
			offset = UDim2.new(0, 0, 0, 5),
		},

		umbra = {
			opacity = 0.14,
			blur = 17,
			offset = UDim2.new(0, 0, 0, 12),
		},
	},

	[16] = {
		ambient = {
			opacity = 0.2,
			blur = 10,
			offset = UDim2.new(0, 0, 0, 8),
		},

		penumbra = {
			opacity = 0.12,
			blur = 30,
			offset = UDim2.new(0, 0, 0, 6),
		},

		umbra = {
			opacity = 0.14,
			blur = 24,
			offset = UDim2.new(0, 0, 0, 16),
		},
	},
}

type can<T> = T | () -> T
type props = {
	elevation: can<number>,
	color: can<Color3>?,
	zindex: can<number>?,
	layout: vide.vFrame?
}

return function(props: props)

	local shadows = {}
	local zindex = source(0)

	for key, value in {"penumbra", "umbra", "ambient"} do
		local function data()
			return (shadow_data[read(props.elevation)][value] or shadow_data[0][value]) :: {
				opacity: number,
				blur: number,
				offset: UDim2
			}
		end

		shadows[key] = create "ImageLabel" {

			Size = function()
				return UDim2.new(1, data().blur, 1, data().blur)
			end,
			Position = function()
				return UDim2.new(0.5, 0, 0.5, 0) + (data().offset or UDim2.new())
			end,
			AnchorPoint = Vector2.new(0.5, 0.5),

			BackgroundTransparency = 1,
			
			Image = "rbxassetid://1316045217",
			ImageColor3 = props.color or Color3.new(0, 0, 0),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(10, 10, 118, 118),
			ImageTransparency = function()
				return 1 - data().opacity
			end,

			ZIndex = props.zindex or function()
				return unwrap(zindex) * 1000 - 10
			end

		}
	end
	
	return create "Frame" {

		Name = "Shadow",
		
		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,

		shadows,

		props.layout,

		theme.zindex.receive(zindex)
		
	}
end