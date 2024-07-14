local vide = require(script.Parent.Parent.Parent.vide)
local unwrap = require(script.Parent.unwrap)

local read = vide.read

type can<T> = (() -> T) | T
local function increment_if(elevation: vide.Source<can<number>>, v: can<boolean>?)
	if read(v) then
		return function(n: can<number>)
			elevation(function()
				return unwrap(n) + 1
			end)
		end
	else
		return elevation
	end
end

return increment_if