local player = ...
local pn = ToEnumShortString(player)
local mods = SL[pn].ActiveModifiers
local style = GAMESTATE:GetCurrentStyle(player)

-- don't allow LaneCover to appear in Casual gamemode via profile settings
if SL.Global.GameMode == "Casual" then
    return
end

local laneCoverWidth = style:GetWidth(player)
local y_offset = 80
local laneCoverHeight = (_screen.h - (_screen.h * (mods.LaneCover / 100)) + y_offset)
SM("ScreenHeight" .. _screen.h)
SM("LaneCoverHeight:" .. laneCoverHeight)


local af = Def.ActorFrame{
    Name = "LaneCoverActor",
    InitCommand = function(self)
        self:draworder(100)
    end,

    Def.Quad{
        Name="LaneCoverQuad",
        InitCommand=function(self)
            self:xy(GetNotefieldX(player), laneCoverHeight)
            self:halign(0.5):valign(0)
            self:zoomto(laneCoverWidth, _screen.h)
            self:diffuse(0, 0, 0, 1)
            self:draworder(100)
        end,
        OnCommand = function(self) 
        end
    }
}


return af


