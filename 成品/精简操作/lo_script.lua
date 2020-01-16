

function RestoreMovement(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    UnitManager.RestoreMovement(pUnit)
end

ExposedMembers.LO = ExposedMembers.LO or {}
ExposedMembers.LO.RestoreMovement = RestoreMovement

