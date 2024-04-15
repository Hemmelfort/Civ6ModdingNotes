
function OnTestButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit()
    if (pUnit ~= nil) then
        ExposedMembers.DEMO.SacrificeUnitInCity(Game.GetLocalPlayer(), pUnit:GetID())
    end
end


function OnUnitSelectionChanged(iPlayerID, iUnitID, iPlotX, iPlotY, iPlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
        if (pUnit:GetCombat() > 0) then
            Controls.TestButtonGrid:SetHide(false)
        else
            Controls.TestButtonGrid:SetHide(true)
        end
    end
end



function Setup()
    local path = '/InGame/UnitPanel/StandardActionsStack'
    local ctrl = ContextPtr:LookUpControl(path)
    if ctrl ~= nil then
        Controls.TestButtonGrid:ChangeParent(ctrl)
    end
    Controls.TestButton:RegisterCallback(Mouse.eLClick, OnTestButtonClicked)
end

Events.LoadGameViewStateDone.Add(Setup)
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)




