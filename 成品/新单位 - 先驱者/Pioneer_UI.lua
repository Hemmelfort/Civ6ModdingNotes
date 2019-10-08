
local CurPlayer = -1
local CurUnit = nil


function SummonBarbarian()
    local unit = UnitManager.GetUnit(CurPlayer, CurUnit)
    
    if (unit ~= nil) then
        local PlotX = unit:GetX()
        local PlotY = unit:GetY()
        
        ExposedMembers.MNS.SummonBarbarian(PlotX, PlotY)
        WorldView.PlayEffectAtXY("BUILDING_CREATED", PlotX, PlotY)  -- 光环效果
        UI.PlaySound("Confirm_Civic")   -- 声音效果
		UI.AddWorldViewText(0, "召唤：野蛮人", PlotX, PlotY)
    end
end


function Setup()
    local ActionStack = ContextPtr:LookUpControl("/InGame/UnitPanel/StandardActionsStack")
    
    if ActionStack ~= nil then
        Controls.SummonBarbarianGrid:ChangeParent(ActionStack)
    else
        print("StandardActionsStack not found.")
    end
    
    Controls.SummonBarbarianButton:RegisterCallback(Mouse.eLClick, SummonBarbarian)
    
end


function OnUnitSelectionChanged(PlayerID, UnitID, PlotX, PlotY, PlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(PlayerID, UnitID)
        local sUnitType = GameInfo.Units[pUnit:GetType()].UnitType
        CurPlayer = PlayerID
        CurUnit = UnitID
        
        Controls.SummonBarbarianGrid:SetHide(sUnitType ~= "UNIT_PIONEER")
    end
end

Events.LoadScreenClose.Add(Setup)
Events.UnitSelectionChanged.Add( OnUnitSelectionChanged )

