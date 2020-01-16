

local m_UnrestOperations = {};
local m_UnrestOperationNames = {
    "UNITOPERATION_BUILD_IMPROVEMENT",
    "UNITOPERATION_REPAIR",
    "UNITOPERATION_REMOVE_FEATURE",
    "UNITOPERATION_REMOVE_IMPROVEMENT",
}

for _, op in ipairs(m_UnrestOperationNames) do
    table.insert(m_UnrestOperations, GameInfo.UnitOperations[op].Index)
end


function is_include(tab, value)
    for _, v in ipairs(tab) do
        if value == v then
            return true
        end
    end
    
    return false
end


function OnUnitOperationAdded(playerID, unitID, iUnknown, hOperation)
    if is_include(m_UnrestOperations, hOperation) then
        ExposedMembers.LO.RestoreMovement(playerID, unitID)
    end
end


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
Events.UnitOperationAdded.Add(OnUnitOperationAdded)



