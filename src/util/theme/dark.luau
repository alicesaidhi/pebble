local SOURCE_SANS = "rbxasset://fonts/families/SourceSansPro.json"

return {

	background = {{.24, 0, 0.4, 0.05}},

	foreground = {
		{.33, 0, 0.4},
	},

	readable = {
		{0, 0, 0.6},
		{0.9, 0, 0.6}
	},

	border = {
		{.22, 0, 0.4}
	},

	font = Font.new(
		SOURCE_SANS, Enum.FontWeight.Regular
	),
	font_bold = Font.new(SOURCE_SANS, Enum.FontWeight.Bold),
	
	body_size = 18,
	heading_size = 36,
	subheading_size = 28,

}