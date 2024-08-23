local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local vide = require(script.Parent.Parent.Parent.vide)
local snapping = require(script.Parent.Parent.components.display.snapping)

local create = vide.create
local source = vide.source
local changed = vide.changed

return function(target)

	return vide.mount(function()
		local snaps = snapping()

		local snapped = source(false)
		local snap_pos = source(UDim2.new())
		local snap_size = source(UDim2.new())

		local m_pos = source(Vector2.zero)
		local drag_pos = source(UDim2.fromOffset(400, 400))
		local abs_pos = source(Vector2.zero)
		local dragging = source(false)
		local offset = Vector2.zero

		local t = source(0)

		vide.cleanup(RunService.Heartbeat:Connect(function()
			t(os.time())
		end))

		vide.cleanup(
			UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
				m_pos(Vector2.new(input.Position.X, input.Position.Y))
			end)
		)

		vide.effect(function()
			if not dragging() then return end
			local t = m_pos() + offset
			drag_pos(UDim2.fromOffset(t.X, t.Y))
		end)

		return create "Frame" {
			Size = UDim2.fromScale(1, 1),

			BackgroundTransparency = 1,

			create "Frame" {
				Size = UDim2.new(0, 200, 1, 0),
				Position = vide.spring(function()
					return if t() % 2 == 0 then UDim2.new() else UDim2.new(1, -200)
				end, 0.5),

				BackgroundTransparency = 0.5,

				snaps.snap_area {
					zindex = 10
				}
			},

			create "ImageButton" {
				Size = function()
					return if snapped() then snap_size() else UDim2.fromOffset(200, 200)
				end,
				Position = function()
					return if snapped() then snap_pos() else drag_pos()
				end,

				MouseButton1Down = function(x, y)
					offset = abs_pos() - Vector2.new(x, y)
					dragging(true)
				end,

				MouseButton1Up = function()
					dragging(false)
				end,

				changed("AbsolutePosition", abs_pos),

				snaps.snappable {
					dragging = dragging,
					snapped = snapped,
					position = snap_pos,
					size = snap_size
				}

			}

		}
	end, target)

end