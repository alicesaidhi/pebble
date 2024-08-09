local vide = require(script.Parent.Parent.Parent.Parent.vide)
local theme = require(script.Parent.Parent.Parent.util.theme)
local padding = require(script.Parent.Parent.util.padding)

local create = vide.create
local source = vide.source
local changed = vide.changed
local read = vide.read

type can<T> = T | () -> T
type props = {

    size: can<UDim2>?,
    position: can<UDim2>?,
    anchorpoint: can<Vector2>?,

    text: can<string>?,
    disabled: can<boolean>?,

    activated: () -> (),
    down: () -> (),
    up: () -> (),

    stroke: can<boolean>?,
    accent: can<boolean>?,

}

return function(props: props)

    local guistate = source(Enum.GuiState.Idle)

    local function bg()
        local accent = read(props.accent)
        local guistate = guistate()

        return if accent then
            if guistate == Enum.GuiState.NonInteractable then theme.acc[-3]
            elseif guistate == Enum.GuiState.Idle then theme.acc[0]
            elseif guistate == Enum.GuiState.Hover then theme.acc[3]
            elseif guistate == Enum.GuiState.Press then theme.acc[-5]
            else theme.acc[0]
        else
            if guistate == Enum.GuiState.NonInteractable  then theme.acc[-3]
            elseif guistate == Enum.GuiState.Idle then theme.bg[3]
            elseif guistate == Enum.GuiState.Hover then theme.bg[5]
            elseif guistate == Enum.GuiState.Press then theme.bg[-2]
            else theme.acc[0]
    end

    local function fg()
        local accent = read(props.accent)
        local guistate = guistate()

        return if accent then
            if guistate == Enum.GuiState.NonInteractable then theme.fg_on_acc_low[0]
            else theme.fg_on_acc_high[0]
        else
            if guistate == Enum.GuiState.NonInteractable  then theme.fg_on_bg_low[0]
            else theme.fg_on_bg_low[0]
    end
    
    local function stroke()
        return if read(props.accent) then theme.acc[-3]
            else theme.bg[-3]
    end

    return create "TextButton" {

        Name = props.text,

        Size = props.size or UDim2.fromOffset(200, 30),
        Position = props.position,
        AnchorPoint = props.anchorpoint,

        Interactable = props.disabled,

        BackgroundColor3 = bg,

        Text = props.text,

        TextSize = theme.body,
        FontFace = theme.font,
        TextColor3 = fg,

        Activated = props.activated,
        MouseButton1Down = props.down,
        MouseButton1Up = props.up,

        create "UIStroke" {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            
            Color = stroke,
            Thickness = 1,
        },

        padding {
            x = UDim.new(0, 8),
            y = UDim.new(0, 2)
        },

        changed("GuiState", guistate)

    }
end