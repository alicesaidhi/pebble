local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local theme = require(script.Parent.Parent.Parent.util.theme)
local typography = require(script.Parent.Parent.display.typography)
local padding = require(script.Parent.Parent.util.padding)

local create = vide.create
local source = vide.source
local changed = vide.changed
local show = vide.show
local read = vide.read

type can<T> = T | () -> T
type props = {

    size: can<UDim2>?,
    position: can<UDim2>?,
    anchorpoint: can<Vector2>?,

    text: can<string>?,
    disabled: can<boolean>?,

    activated: () -> ()?,
    down: () -> ()?,
    up: () -> ()?,

    --- enables the stroke (enabled by default)
    stroke: can<boolean>?,
    --- enables the corner (enabled by default)
    corner: can<boolean>?,
    accent: can<boolean>?,

}

return function(props: props)

    local guistate = source(Enum.GuiState.Idle)

    local function bg()
        local accent = read(props.accent)
        local guistate = guistate()

        return if accent then
            if guistate == Enum.GuiState.NonInteractable then theme.acc[-5]()
            elseif guistate == Enum.GuiState.Idle then theme.acc[0]()
            elseif guistate == Enum.GuiState.Hover then theme.acc[3]()
            elseif guistate == Enum.GuiState.Press then theme.acc[-8]()
            else theme.acc[0]()
        else
            if guistate == Enum.GuiState.NonInteractable  then theme.bg[-2]()
            elseif guistate == Enum.GuiState.Idle then theme.bg[3]()
            elseif guistate == Enum.GuiState.Hover then theme.bg[6]()
            elseif guistate == Enum.GuiState.Press then theme.bg[0]()
            else theme.acc[0]()
    end

    local function stroke()
        local accent = read(props.accent)
        local guistate = guistate()

        return if accent then
                if guistate == Enum.GuiState.NonInteractable then theme.acc[-7]()
                else theme.acc[-7]()
            else
                if guistate == Enum.GuiState.NonInteractable then theme.bg[-3]()
                else theme.bg[-3]()
    end

    return create "TextButton" {

        Name = props.text,

        Size = props.size or UDim2.fromOffset(100, 30),
        Position = props.position,
        AnchorPoint = props.anchorpoint,

        Interactable = function()
            return not props.disabled 
        end,

        BackgroundColor3 = anim(bg),

        Activated = props.activated,
        MouseButton1Down = props.down,
        MouseButton1Up = props.up,

        typography {

            position = UDim2.fromScale(0.5, 0.5),
            anchorpoint = Vector2.new(0.5, 0.5),

            text = props.text,

            accent = props.accent,
            disabled = props.disabled

        },

        show(
            function()
                return read(props.stroke) ~= false
            end,
            source(
                create "UIStroke" {
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    
                    Color = anim(stroke),
                    Thickness = 1,
                    Enabled = props.stroke
                }
            )
        ),

        show(
            function()
                return read(props.corner) ~= false
            end,
            source(
                create "UICorner" {
                    CornerRadius = UDim.new(0,4)
                }
            )
        ),

        padding {
            x = UDim.new(0, 8),
            y = UDim.new(0, 2)
        },

        changed("GuiState", guistate)

    }
end