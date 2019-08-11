
-- 根据资源来选择蛮族营地的位置，并随机刷新

function PlaceTribeOnMap()
    local iTurn = Game.GetCurrentGameTurn()
    
    -- 不一定每个回合都刷新
    if iTurn%2 == 1 then
        return
    end
    
    -- 只在陆地上放置
    local tContinents = Map.GetContinentsInUse()
    
    for i, eContinent in ipairs(tContinents) do
        local tContinentPlots = Map.GetContinentPlots(eContinent)   -- 存放的是 PlotIndex
        
        for _, plot in ipairs(tContinentPlots) do
            local pPlot = Map.GetPlotByIndex(plot)
            
            if (pPlot ~= nil) and (pPlot:GetOwner() == -1) and (pPlot:IsWater() == false) and (pPlot:IsMountain() == false) and (pPlot:GetUnitCount()==0) then
                local iResourceIndex = pPlot:GetResourceType()
                local tResourceType = GameInfo.Resources[iResourceIndex]
                
                if tResourceType ~= nil then
                    
                    -- 这里以奢侈资源或战略资源为例
                    if tResourceType.ResourceClassType == "RESOURCECLASS_LUXURY" or tResourceType.ResourceClassType == "RESOURCECLASS_STRATEGIC" then
                    
                        -- 出现的概率
                        if math.random() < 0.01 then
                            local pBarbManager = Game.GetBarbarianManager()
                            
                            -- Clear improvement in case one already here
                            ImprovementBuilder.SetImprovementType(pPlot, -1, NO_PLAYER)
                            
                            pBarbManager:CreateTribeOfType(1, plot)
                        end
                    end
                end
            end
            
        end
    end
    
end


Events.TurnBegin.Add(PlaceTribeOnMap)
