
local CurPlayer = -1
local CurUnit = nil


function Enclosure()
    local unit = UnitManager.GetUnit(CurPlayer, CurUnit)
    
    if (unit ~= nil) then
        local PlotX = unit:GetX()
        local PlotY = unit:GetY()
        
        ExposedMembers.MNS.ChangePlotOwner(PlotX, PlotY, CurPlayer)
        WorldView.PlayEffectAtXY("BUILDING_CREATED", PlotX, PlotY)  -- 光环效果
        UI.PlaySound("Confirm_Civic")   -- 声音效果
    end
end


function Setup()
    local ActionStack = ContextPtr:LookUpControl("/InGame/UnitPanel/StandardActionsStack")
    
    if ActionStack ~= nil then
        Controls.CustomActionGrid:ChangeParent(ActionStack)
        --ActionStack:CalculateSize()
    else
        print("StandardActionsStack not found.")
    end
    
    Controls.CustomActionButton:RegisterCallback(Mouse.eLClick, Enclosure)
    
end


function OnUnitSelectionChanged(PlayerID, UnitID, PlotX, PlotY, PlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(PlayerID, UnitID)
        local sUnitType = GameInfo.Units[pUnit:GetType()].UnitType
        CurPlayer = PlayerID
        CurUnit = UnitID
        
        Controls.CustomActionGrid:SetHide(sUnitType ~= "UNIT_WARRIOR")
    end
end

Events.LoadScreenClose.Add(Setup)
Events.UnitSelectionChanged.Add( OnUnitSelectionChanged )

