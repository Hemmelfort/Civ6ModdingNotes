
-- 功能：完成项目后随机奖励某个时代的市政


-- 把 PROJECT_XXX 换成自己的项目
local m_iTargetProject = GameInfo.Projects['PROJECT_XXX'].Index


function GrantRandomCivic(playerID, era:string)
    local pPlayer = Players[playerID]
    if pPlayer == nil then
        return
    end
    
    local civlist = {}
    local playerCulture = pPlayer:GetCulture()
    
	for row in GameInfo.Civics() do
		if (row.EraType == era) 
		and (not playerCulture:HasCivic(row.Index)) then
            table.insert(civlist, row.Index)
        end
	end
    
    if #civlist ~= 0 then
        local iCivic = civlist[math.random(#civlist)]
        playerCulture:SetCivic(iCivic, true)
    end
end


function OnCityProjectCompleted(playerID, cityID, projectID, buildingIndex, iX, iY, bCancelled)
    if (projectID == m_iTargetProject) then
        GrantRandomCivic(playerID, 'ERA_FUTURE')    --时代在这里设置
    end
end


Events.CityProjectCompleted.Add(OnCityProjectCompleted)




