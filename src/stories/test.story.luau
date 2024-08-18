local vide = require(script.Parent.Parent.Parent.vide)

local source = vide.source
local effect = vide.effect
local batch = vide.batch
local untrack = vide.untrack

return function(target)

	local update = source(0)

	local d = vide.mount(function()

		-- effect(function()
		-- 	local u = update()

		-- 	batch(function()
				
		-- 	end)
		-- end)

		untrack(function()
			batch(function()  end)
		end)

	end)

	task.delay(1, d)

	update(1)

	
	

end