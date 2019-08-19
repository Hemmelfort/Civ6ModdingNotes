
-- 在单位面板上添加一个按钮，只有特定单位能触发，从而实现单位的专属功能


function Setup()
    local ActionStack = ContextPtr:LookUpControl("/InGame/UnitPanel/StandardActionsStack")
    
    if ActionStack ~= nil then
        Controls.CustomActionGrid:ChangeParent(ActionStack)
        --ActionStack:CalculateSize()
    else
        print("StandardActionsStack not found.")
    end
    
end


function OnUnitSelectionChanged(PlayerID, UnitID, PlotX, PlotY, PlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(PlayerID, UnitID)
        local sUnitType = GameInfo.Units[pUnit:GetType()].UnitType
        
        -- 以建造者为例
        Controls.CustomActionGrid:SetHide(sUnitType ~= "UNIT_BUILDER")
    end
end

Events.LoadScreenClose.Add(Setup)
Events.UnitSelectionChanged.Add( OnUnitSelectionChanged )

