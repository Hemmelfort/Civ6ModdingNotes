
function myRandom()

	local playerIDS = PlayerManager.GetAliveIDs();
	local result = 0;
	
	for i, playerId in ipairs(playerIDS) do
		local pPlayer = Players[playerId];
		local playerConfig = PlayerConfigurations[playerId];		
		if pPlayer:IsMajor() and pPlayer:IsAlive() then
			for i, pCity in pPlayer:GetCities():Members() do
				result = result + pCity:GetGrowth():GetTurnsUntilGrowth();
				result = result + pCity:GetGrowth():GetHappiness();
				result = result + pCity:GetGrowth():GetFoodSurplus();
				result = result + pCity:GetGrowth():GetHousing();
			end
		end
	end
	print("Abigail:Random Result Seed:"..result);	
	return (result % 7) + 1;

end
