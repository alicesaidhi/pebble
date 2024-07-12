local vide = require(script.Parent.Parent.Parent.vide)
local shadow = require(script.Parent.Parent.components.util.shadow)
local apcaw3 = require(script.Parent.Parent.libraries.apcaw3)
local cascade = require(script.Parent.Parent.libraries.cascade)
local anim = require(script.Parent.anim)
local contrast = require(script.Parent.contrast)
local oklch = require(script.Parent.oklch)

local create = vide.create
local derive = vide.derive
local source = vide.source
local read = vide.read

--- themes store multiple different kind of values.
--- they're either dynamic, static or some blend.

--- This cascade is used to store the color of the element to be used for
--- comparing. Whenever a new foreground element is created, this should be
--- used to compare the color. 
local color = cascade(source(Color3.new(0, 0, 0)) :: () -> Color3)

--- This cascade is used to store the elevation of an element. Elements with a
--- higher elevation should visually appear higher up through either a shadow
--- or/and a color.
local elevation_cascade = cascade(source(0) :: () -> number)

--- collapses a state to a single value
type recursive<T> = (() -> recursive<T>) | T
type can<T> = (() -> T) | T
local function unwrap<T>(source: recursive<T>): T

	local value: recursive<T>

	while type(source) == "function" do
		source = source()
	end

	value = source

	return value :: T
end

local ZINDEX_SHADOW = 0
local ZINDEX_BACKGROUND = 500
local ZINDEX_FOREGROUND = 1000

local theme = require(script.dark)
local get_appropriate_color = contrast.get_appropriate_color
local min_contrast = contrast.min_contrast

return {

	background = function()

		local parent_elevation = source(1)
		local color_on = source(Color3.new())
		local elevation = derive(function()
			return unwrap(parent_elevation) + 1
		end)

		local background_color = contrast.get_appropriate_color {
			background = color_on,
			foreground = theme.background,
			elevation = elevation,
			min_contrast = 0
		}
		
		return {

			BackgroundColor3 = background_color,

			ZIndex = function()
				return ZINDEX_BACKGROUND + elevation() * 2
			end,

			create "UICorner" {
				CornerRadius = UDim.new(0, 8)
			},

			shadow {
				elevation = 8,
				zindex = function()
					return ZINDEX_BACKGROUND + elevation() * 2 - 1
				end
			},

			color.receive(color_on),
			color.send(background_color),
			elevation_cascade.receive(parent_elevation),
			elevation_cascade.send(elevation)

		}

	end,

	foreground = function()

		local parent_elevation = source(1)
		local color_on = source()
		local elevation = derive(function()
			return unwrap(parent_elevation) + 1
		end)

		local background_color = get_appropriate_color {
			background = color_on,
			foreground = theme.foreground,
			elevation = elevation,
			min_contrast = 5
		}
		
		return {

			BackgroundColor3 = background_color,

			ZIndex = function()
				return ZINDEX_FOREGROUND + elevation() * 2
			end,

			shadow {
				elevation = 8,
				zindex = function()
					return ZINDEX_FOREGROUND + elevation() * 2 - 1
				end
			},

			color.receive(color_on),
			color.send(background_color),
			elevation_cascade.receive(parent_elevation),
			elevation_cascade.send(elevation)

		}

	end,

	border = function()

		local parent_elevation = source(1)
		local color_on = source()
		local elevation = derive(function()
			return unwrap(parent_elevation) + 1
		end)

		local background_color = get_appropriate_color {
			background = color_on,
			foreground = theme.border,
			elevation = elevation,
			min_contrast = 15
		}
		
		return {

			create "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = background_color
			},

			color.receive(color_on),
			elevation_cascade.receive(parent_elevation),
			elevation_cascade.send(elevation)

		}

	end,

	body = function(size: number)

		local parent_elevation = source(1)
		local background_color = source(Color3.new())
		local elevation = derive(function()
			return unwrap(parent_elevation) + 1
		end)
		
		return {

			FontFace = theme.font,
			TextSize = size,

			TextColor3 = get_appropriate_color {
				background = background_color,
				foreground = theme.readable,
				elevation = elevation,
				min_contrast = min_contrast {
					size = size,
					weight = 400,
					body = true
				}
			},
			
			color.receive(background_color),
			elevation_cascade.receive(parent_elevation),
			elevation_cascade.send(elevation)

		}

	end,

	body_bold = function(size: number)

		local parent_elevation = source(1)
		local background_color = source(Color3.new())
		local elevation = derive(function()
			return unwrap(parent_elevation) + 1
		end)
		
		return {

			FontFace = theme.font_bold,
			TextSize = size,

			TextColor3 = get_appropriate_color {
				background = background_color,
				foreground = theme.readable,
				elevation = elevation,
				min_contrast = min_contrast {
					size = size,
					weight = Font.new(theme.font, Enum.FontWeight.Bold),
					body = true
				}
			},
			
			color.receive(background_color),
			elevation_cascade.receive(parent_elevation),
			elevation_cascade.send(elevation)

		}

	end,

	text = function(size: number)

		local parent_elevation = source(1)
		local background_color = source(Color3.new())
		local elevation = derive(function()
			return unwrap(parent_elevation) + 1
		end)
		
		return {

			FontFace = theme.font,
			TextSize = size,

			TextColor3 = get_appropriate_color {
				background = background_color,
				foreground = theme.readable,
				elevation = elevation,
				min_contrast = min_contrast {
					size = size,
					weight = 400,
					body = false
				}
			},
			
			color.receive(background_color),
			elevation_cascade.receive(parent_elevation),
			elevation_cascade.send(elevation)

		}

	end,

	text_bold = function(size: number)

		local parent_elevation = source(1)
		local background_color = source(Color3.new())
		local elevation = derive(function()
			return unwrap(parent_elevation) + 1
		end)
		
		return {

			FontFace = theme.font_bold,
			TextSize = size,

			TextColor3 = get_appropriate_color {
				background = background_color,
				foreground = theme.readable,
				elevation = elevation,
				min_contrast = min_contrast {
					size = size,
					weight = Font.new(theme.font, Enum.FontWeight.Bold),
					body = false
				}
			},
			
			color.receive(background_color),
			elevation_cascade.receive(parent_elevation),
			elevation_cascade.send(elevation)

		}

	end,
	

}