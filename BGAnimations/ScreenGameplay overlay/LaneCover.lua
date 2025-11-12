local player = ...
local pn = ToEnumShortString(player)
local mods = SL[pn].ActiveModifiers
local style = GAMESTATE:GetCurrentStyle(player)
local reverseOffset = THEME:GetMetric("Player", "ReceptorArrowsYReverse")
local opts = GAMESTATE:GetPlayerState(player):GetCurrentPlayerOptions()

SM(reverseOffset)
-- don't allow LaneCover to appear in Casual gamemode via profile settings
if SL.Global.GameMode == "Casual" then
    return
end

local laneCoverWidth = style:GetWidth(player)
local y_offset = 80

local laneCoverHeight = (opts:Reverse() == 1)
    and (_screen.h - (_screen.h * (mods.LaneCover / 100)) + y_offset)
    or ((_screen.h * (mods.LaneCover / 100)) + reverseOffset)


local af = Def.ActorFrame{
    Name = "LaneCoverActor",
    InitCommand = function(self)
        --self:draworder(120)
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


