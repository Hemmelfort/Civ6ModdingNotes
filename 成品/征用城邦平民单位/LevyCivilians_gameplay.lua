
----------------------------------------------------------------
-- 对某个单位的主人进行变更
----------------------------------------------------------------
local function SetUnitOwner(iOriginalOwnerID, iUnitID, iNewOwnerID)
    local pPlayer = Players[iNewOwnerID]
    local pUnit = UnitManager.GetUnit(iOriginalOwnerID, iUnitID)
    --local iUnitIndex = pUnit:GetType()
    local sUnitTypeName = GameInfo.Units[pUnit:GetType()].UnitType
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    
    UnitManager.Kill(pUnit)
    --pPlayer:GetUnits():Create(iUnitIndex, iX, iY) --如果在城邦市中心就创建不了！！
    
    if sUnitTypeName == "UNIT_TRADER" then
        --TODO: 如果是商人，就送到NewOwner的城市中
    else
        UnitManager.InitUnitValidAdjacentHex(iNewOwnerID, sUnitTypeName, iX, iY, 1)
    end
end


ExposedMembers.LC = ExposedMembers.LC or {}
ExposedMembers.LC.SetUnitOwner = SetUnitOwner
