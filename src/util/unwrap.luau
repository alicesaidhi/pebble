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

return unwrap