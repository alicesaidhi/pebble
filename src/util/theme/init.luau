local vide = require(script.Parent.Parent.Parent.vide)
local cascade = require(script.Parent.Parent.libraries.cascade)
local store = require(script.Parent.Parent.libraries.store)
local contrast = require(script.Parent.contrast)
local unwrap = require(script.Parent.unwrap)

local source = vide.source

--- themes store multiple different kind of values.
--- they're either dynamic, static or some blend.

--- This cascade is used to store the color of the element to be used for
--- comparing. Whenever a new foreground element is created, this should be
--- used to compare the color. 
local color_cascade = cascade(source(Color3.new(0, 0, 0)) :: () -> Color3)

--- This cascade is used to store the elevation of an element. Elements with a
--- higher elevation should visually appear higher up through either a shadow
--- or/and a color.
local elevation_cascade = cascade(source(0) :: () -> number)

--- This cascade increments the ZIndex
local zindex_cascade = cascade(source(0) :: () -> number)

local theme = require(script.dark)
local get_appropriate_color = contrast.get_appropriate_color
local min_contrast = contrast.min_contrast

for key, value in theme do
	if typeof(value) == "table" then
		table.freeze(value)
	end
end

return {

	get_appropriate_color = get_appropriate_color,
	min_contrast = min_contrast,

	theme = store.new(theme, source {}),

	elevation = elevation_cascade,
	color = color_cascade,

	zindex = zindex_cascade,
	zindex_increment = function(output_to: vide.Source<() -> number>?)
		local zindex = output_to or source(0)
		return {

			zindex_cascade.receive(function(n)
				zindex(function()
					return unwrap(n) + 1
				end)
			end),
			zindex_cascade.send(zindex)

		}
	end,

}