
-- 以改良设施“农场”为例，当单位移动到该单元格即可恢复生命值

local m_FarmIndex = GameInfo.Improvements["IMPROVEMENT_FARM"].Index

function HealAtPlot(iPlayerID, iUnitID, PlotX, PlotY)
    local pPlot = Map.GetPlot(PlotX, PlotY)
    local iImpIndex = pPlot:GetImprovementType()
    
    if (iImpIndex == m_FarmIndex) then
        local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
        
        if pUnit ~= nil then
            pUnit:SetDamage(0)
        end
    end

end


Events.UnitMoveComplete.Add(HealAtPlot)


