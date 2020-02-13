
function PunishForDistroyTribe(PlotX, PlotY, PlayerID)
    local pPlayer = Players[PlayerID]
    
    if (pPlayer ~= nil) and pPlayer:IsBarbarian() then
        local pBarbManager = Game.GetBarbarianManager()
        local iPlotIndex = Map.GetPlot(PlotX, PlotY):GetIndex()
        local iTribeNumber = 1
        local iRange = 3
        
        pBarbManager:CreateTribeUnits(iTribeNumber, "CLASS_MELEE", 1, iPlotIndex, iRange)
    end

end

Events.ImprovementRemovedFromMap.Add(PunishForDistroyTribe)
