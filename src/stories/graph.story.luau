local RunService = game:GetService("RunService")

local vide = require(script.Parent.Parent.Parent.vide)
local bargraph = require(script.Parent.Parent.components.graph.bargraph)
local linegraph = require(script.Parent.Parent.components.graph.linegraph)
local list = require(script.Parent.Parent.components.util.list)

return function(target)

	local graph = vide.source {0, 0}

	return vide.mount(function()

		vide.cleanup(RunService.Heartbeat:Connect(function(dt)
			table.insert(graph(), dt)
			
			if #graph() >= 50 then
				table.remove(graph(), 1)
			end

			graph(graph())
		end))
	
		return list {

			linegraph {
				values = graph,
				max = 0.033,
	
				size = UDim2.new(1, -8, 0, 200),

				vide.create "UIStroke" {}
			},

			bargraph {
				values = graph,
				max = 0.033,
	
				size = UDim2.new(1, -8, 0, 200),

				
				vide.create "UIStroke" {}
			},

		}

	end, target)

end