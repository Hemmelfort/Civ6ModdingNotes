
-- 功能：限制所有玩家所能建造的开拓者的数量


local m_PlayerMaxSettlerAmount = 5  -- 每位玩家最大开拓者数量
local m_MaxSettlerAmount    -- 全部玩家的开拓者最大数量，游戏加载的时候再计算

local m_iSettlerIndex = GameInfo.Units["UNIT_SETTLER"].Index


function SetPlayerDisableSettler(iPlayerID, bDisabled)
    Players[iPlayerID]:GetUnits():SetBuildDisabled(m_iSettlerIndex, bDisabled)
end


-- ===================================
-- 检查现有城市的数量
-- ===================================
function CheckSettlerAmounts()
    local iCityCount = 0
    local pAliveMajors = PlayerManager.GetAliveMajors()
    for _, pPlayer in ipairs(pAliveMajors) do
        iCityCount = iCityCount + pPlayer:GetCities():GetCount()
    end
    
    if (iCityCount >= m_MaxSettlerAmount) then
        local pMajorIDs = PlayerManager.GetAliveMajorIDs()
        for _, iPlayerID in ipairs(pMajorIDs) do
            SetPlayerDisableSettler(iPlayerID, true)
        end
    else
        for _, pPlayer in ipairs(pAliveMajors) do
            local bDisabled = pPlayer:GetCities():GetCount() >= m_PlayerMaxSettlerAmount
            SetPlayerDisableSettler(pPlayer:GetID(), bDisabled)
        end
    end
end


function OnCityAddedToMap(iPlayerID, iCityID, iX, iY)
    CheckSettlerAmounts()
end

function OnCityRemovedFromMap(iPlayerID, iCityID)
    CheckSettlerAmounts()
end


function OnLoadScreenClose()
    local iCount = PlayerManager.GetAliveMajorsCount()
    m_MaxSettlerAmount = iCount * m_PlayerMaxSettlerAmount
    
    CheckSettlerAmounts()
    Events.CityAddedToMap.Add(OnCityAddedToMap)
    Events.CityRemovedFromMap.Add(OnCityRemovedFromMap)
end


Events.LoadScreenClose.Add(OnLoadScreenClose)














