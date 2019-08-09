
function KilledByBarbarian(killedPlayerID, killedUnitID, PlayerID, UnitID)
    local pPlayer = Players[PlayerID]
    
    if (pPlayer ~= nil) and pPlayer:IsBarbarian() then
        local heroUnit = UnitManager.GetUnit(PlayerID, UnitID)
        local sUnitType = GameInfo.Units[heroUnit:GetType()].UnitType
        local PlotX = heroUnit:GetX()
        local PlotY = heroUnit:GetY()
                    
        --pPlayer:GetUnits():Create(GameInfo.Units[heroUnit:GetType()].Index, PlotX, PlotY)
        UnitManager.InitUnitValidAdjacentHex(PlayerID, sUnitType, PlotX, PlotY, 1)
    end
    
end

Events.UnitKilledInCombat.Add(KilledByBarbarian)

