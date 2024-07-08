local oklab = require(script.Parent.Parent.libraries.oklab)


--[=[

Converts OkLCh into a Color3.

lightness is a value between 0-1, determining how "light" a color is.

chroma is a value between 0 to infinity, determining how colorful something is.
current displays can only display a chroma up to around 0.34, and srgb can only
go up to 0.245.

hue is just the hue circle.



]=]
local function oklch(lightness: number, chroma: number, hue: number)
	return oklab.linear_srgb_to_color3(
		oklab.oklab_to_linear_srgb(oklab.oklch_to_oklab(Vector3.new(lightness, chroma, hue / 360))),
		true
	)
end

return oklch