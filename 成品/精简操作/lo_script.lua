

-- ====================================
-- 恢复单位的移动力
-- ====================================
function RestoreMovement(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    UnitManager.RestoreMovement(pUnit)
end


-- ====================================
-- 创建单位
-- ====================================
function CreateUnit(playerID, iUnitIndex, iX, iY)
    Players[playerID]:GetUnits():Create(iUnitIndex, iX, iY)
end


-- ====================================
-- 销毁单位
-- ====================================
function KillUnit(playerID, unitID)
    local pUnit = UnitManager.GetUnit(playerID, unitID)
    UnitManager.Kill(pUnit)
end


ExposedMembers.LO = ExposedMembers.LO or {}
ExposedMembers.LO.RestoreMovement = RestoreMovement
ExposedMembers.LO.CreateUnit = CreateUnit
ExposedMembers.LO.KillUnit = KillUnit

