--[[
功能：
    游戏刚开始的时候，获取玩家出生地所在的大陆全部格位的视野能见度。
    （不会驱散战争迷雾）
]]--


function RevealPlotsOnCurrentContinent()
    local iPlayerID = Game.GetLocalPlayer()
    local pPlayer = Players[iPlayerID]
    local pPlayerVisibility = PlayersVisibility[iPlayerID]
    local pStartingPlot = pPlayer:GetStartingPlot()
    local eContinent = pStartingPlot:GetContinentType()
    
    local tPlots = Map.GetContinentPlots(eContinent)
    for _, iPlotIndex in ipairs(tPlots) do
        pPlayerVisibility:ChangeVisibilityCount(iPlotIndex, 0)
    end
    
end


function OnNewGameInitialized()
    if Game.GetCurrentGameTurn() == 1 then
        RevealPlotsOnCurrentContinent()
    end
end

-- 只需触发一次
LuaEvents.NewGameInitialized.Add(OnNewGameInitialized)
