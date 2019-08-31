

local function AddGreatMerchant(iPlayer, szGeneralName)
	local individual = GameInfo.GreatPersonIndividuals[szGeneralName].Hash;
	local class = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_MERCHANT"].Hash;
	local era = GameInfo.Eras["ERA_CLASSICAL"].Hash;
	local cost = 0;
	
	Game.GetGreatPeople():GrantPerson(individual, class, era, cost, iPlayer, false);
end


function OnCityBuilt(playerID, cityID, iX, iY)
	local pCity = CityManager.GetCity(playerID, cityID)
    local sName = pCity:GetName()
    
    if sName == "LOC_CITY_NAME_HONG_KONG" then
        AddGreatMerchant(playerID, "GREAT_PERSON_INDIVIDUAL_ZHANG_QIAN")
        pCity:AttachModifierByID("HONGKONG_GOLDEN_BAY");
    end

end


function ConfirmHKInGame()
	for _, iPlayerID in ipairs(PlayerManager.GetAliveMajorIDs()) do
        local pPlayerConfig = PlayerConfigurations[iPlayerID]
        
        if (pPlayerConfig ~= nil) and (pPlayerConfig:GetCivilizationTypeName() == "CIVILIZATION_CHINA") then
            GameEvents.CityBuilt.Add(OnCityBuilt)
            return
        end
	end
end


LuaEvents.NewGameInitialized.Add(ConfirmHKInGame)

