
-- 当野蛮人将另一个单位击杀，则刷新出一个野蛮人。
-- 尚无法根据被害单位的类型来决定新生单位的类型。

function KilledByBarbarian(killedPlayerID, killedUnitID, PlayerID, UnitID)
    local pPlayer = Players[PlayerID]
    
    if (pPlayer ~= nil) and pPlayer:IsBarbarian() then
        local heroUnit = UnitManager.GetUnit(PlayerID, UnitID)
        local sUnitType = GameInfo.Units[heroUnit:GetType()].UnitType
        local PlotX = heroUnit:GetX()
        local PlotY = heroUnit:GetY()
        
        -- 有时候坐标会返回 -9999 导致游戏强退，所以要验证
        if (PlotX > -1) and (PlotY > -1) then
            UnitManager.InitUnitValidAdjacentHex(PlayerID, sUnitType, PlotX, PlotY, 1)
        end
    end
    
end

Events.UnitKilledInCombat.Add(KilledByBarbarian)

