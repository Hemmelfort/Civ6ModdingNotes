
-- 有 bug！ 所有依赖区域的项目（比如“工业区物流”）都会移除区域
-- 等有时间再改

-- 通过项目移除城市区域
-- 需要：
--      先创建一个项目，项目中的 PrereqDistrict 为要移除的区域。

function OnCityPrjComp(playerID, cityID, projectID, buildingIndex, iX, iY, bCancelled)
    local sDistrictType = GameInfo.Projects[projectID].PrereqDistrict
    
    if sDistrictType ~= nil then
        local pPlayer = Players[playerID]
        local pCity = pPlayer:GetCities():FindID(cityID)
        local tDistricts = pCity:GetDistricts()
        local iDistrictID = GameInfo.Districts[sDistrictType].Index
        
        tDistricts:RemoveDistrict(iDistrictID)        
    end    
end

Events.CityProjectCompleted.Add(OnCityPrjComp)

