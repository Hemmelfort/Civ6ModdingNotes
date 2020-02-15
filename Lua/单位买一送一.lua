
-- 当玩家购买一个单位，都能额外获赠一个（仅限人类玩家）。

function OnCityMadePurchase(iPlayerID, iCityID, iX, iY, iPurchaseType, iObjectType)
    if (iPlayerID == 0) and (iPurchaseType == EventSubTypes.UNIT) then
        local sUnitType = GameInfo.Units[iObjectType].UnitType
        UnitManager.InitUnitValidAdjacentHex(iPlayerID, sUnitType, iX, iY, 1)
    end
end

Events.CityMadePurchase.Add(OnCityMadePurchase)

