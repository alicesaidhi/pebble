local vide = require(script.Parent.Parent.Parent.Parent.vide)

local create = vide.create

type can<T> = T | () -> T
type props = {
	zindex: can<number>?,
	transparency: can<number>?
}

return function(props: props)
	
	return create "ImageLabel" {

		Name = "Shadow",
		
		Size = UDim2.new(1, 8, 1, 8),
		Position = UDim2.fromScale(0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0),

		BackgroundTransparency = 1,
		Image = "rbxtemp://0",

		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(4, 0, 104, 100),
		ImageTransparency = props.transparency
		
	}
end