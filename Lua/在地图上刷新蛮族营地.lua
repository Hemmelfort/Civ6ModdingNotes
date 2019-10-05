
-- 根据资源来选择蛮族营地的位置，并随机刷新

function PlaceTribeOnMap()    
    -- 不一定每个回合都刷新
	if math.random() < 0.5 then
		return
	end
    
	-- 只在陆地上放置
	local tContinents = Map.GetContinentsInUse()
	
	for i, eContinent in ipairs(tContinents) do
		local tContinentPlots = Map.GetContinentPlots(eContinent)   -- 存放的是 PlotIndex
		
		for _, plot in ipairs(tContinentPlots) do
			local pPlot = Map.GetPlotByIndex(plot)
			
			if (pPlot ~= nil) and (pPlot:GetOwner() == -1) and (pPlot:IsWater() == false) and (pPlot:IsMountain() == false) and (pPlot:GetImprovementType() == -1) and (pPlot:GetUnitCount()==0) then
				local iResourceIndex = pPlot:GetResourceType()
				local tResourceType = GameInfo.Resources[iResourceIndex]
				
				-- 选择格位，以有战略资源的格位为例
				if tResourceType ~= nil and tResourceType.ResourceClassType == "RESOURCECLASS_STRATEGIC" then
					if math.random() < 0.01 then
						local pBarbManager = Game.GetBarbarianManager()
						pBarbManager:CreateTribeOfType(1, plot)
					end
				end
			end
			
		end
	end
    
end


Events.TurnBegin.Add(PlaceTribeOnMap)
