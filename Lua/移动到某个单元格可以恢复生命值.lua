
-- 以改良设施“农场”为例，当单位移动到该单元格即可恢复生命值

function HealAtPlot(PlayerID, UnitID, PlotX, PlotY)
    local pPlot = Map.GetPlot(PlotX, PlotY)
    local iImpIndex = pPlot:GetImprovementType()
    local sImpType = GameInfo.Improvements[iImpIndex]
    
    if sImpType ~= nil then
        if sImpType.ImprovementType == "IMPROVEMENT_FARM" then
            local unit = UnitManager.GetUnit(PlayerID, UnitID)            
            
            if unit ~= nil then
                unit:SetDamage(0)
            end
        end
    end

end


Events.UnitMoveComplete.Add(HealAtPlot)


