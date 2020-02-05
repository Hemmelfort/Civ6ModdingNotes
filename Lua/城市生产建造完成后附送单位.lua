
function OnCityProdComp(playerID, cityID, iConstructionType, itemID, bCancelled)
    local pPlayer = Players[playerID]
    
    if pPlayer:IsHuman() then        

        if iConstructionType == 0 then
            local unit = GameInfo.Units[itemID]
            if unit ~= nil then
                print("单位建造完成: " .. unit.Name)
            end
        
        elseif iConstructionType == 1 then
            -- 建筑或奇观建造完成
            local building = GameInfo.Buildings[itemID]
            if building ~= nil then
                local pCity = pPlayer:GetCities():FindID(cityID)
                local iCityX = pCity:GetX()
                local iCityY = pCity:GetY()
                UnitManager.InitUnitValidAdjacentHex(playerID, "UNIT_BUILDER", iCityX, iCityY, 1)
            end
        
        elseif iConstructionType == 2 then
            -- 注意：经群友发现，Gameplay 环境下当区域建造完成时会连续触发该事件。
            -- 因此建议在 UI 环境下使用
            local district = GameInfo.Districts[itemID]
            if district ~= nil then
                print("区域建造完成: " .. district.Name)
            end
            
        elseif iConstructionType == 3 then
            local project = GameInfo.Projects[itemID]
            if project ~= nil then
                print("项目完成: " .. project.Name)
            end
        end
        
    end
end

Events.CityProductionCompleted.Add(OnCityProdComp)

