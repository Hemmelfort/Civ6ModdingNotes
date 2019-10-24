
-- 使几个特定项目能够自动无限循环，从而缓解游戏后期因城市太多使得操作过于繁琐的情况

-- 注：
-- 该功能不需要界面，但由于 CityManager.RequestOperation 方法无法用于 Gameplay 环境，
-- 所以只能放在 UI 环境中实现。


function RestartProject(playerID, cityID, iConstructionType, itemID, bCancelled)
    if iConstructionType == 3 then
        local project = GameInfo.Projects[itemID]
        
        if (project ~= nil) and string.find(project.ProjectType, "PROJECT_ENHANCE_DISTRICT") then 
            local pCity = CityManager.GetCity(playerID, cityID)
            local tParameters = {}
            tParameters[CityOperationTypes.PARAM_PROJECT_TYPE] = project.Hash
            CityManager.RequestOperation(pCity, CityOperationTypes.BUILD, tParameters)
        end
    end
end


Events.CityProductionCompleted.Add(RestartProject)

