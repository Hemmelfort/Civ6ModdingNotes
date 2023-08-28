
-- Script: Excited Ordeal
-- Author: Hemmelfort
-- $Date: 00:23:22 2023年8月29日 $


-- 越大越容易出现新的蛮族营地（0~1，由玩家在开始界面更改）
-- 0  : 蛮寨正常刷新
-- 0.5: 蛮寨每回合有略小于50%的概率新增一个
local m_TribeRate = 0.5

-- 所有可以生成蛮寨的格位
local m_tAvailablePlots = {}

local BBCAMP_INDEX = GameInfo.Improvements['IMPROVEMENT_BARBARIAN_CAMP'].Index

-----------------------------------------
--- 获取所有可以生成蛮寨的格位：陆上非山非水之地
-----------------------------------------
local function UpdateAvailablePlots()
    local tContinents = Map.GetContinentsInUse()
    
    for _, eContinent in ipairs(tContinents) do
        local tContinentPlots = Map.GetContinentPlots(eContinent)
        
        for _, plot in ipairs(tContinentPlots) do
            local pPlot = Map.GetPlotByIndex(plot)
            
            if  (pPlot ~= nil)
            and (pPlot:IsWater() == false)
            and (pPlot:IsMountain() == false)
            then            
                table.insert(m_tAvailablePlots, plot) --存放的是index
            end
        end
    end
end

-----------------------------------------
--- 随机放置蛮族营地
-----------------------------------------
function PlaceRandomTribes()
    local iPlot = m_tAvailablePlots[math.random(# m_tAvailablePlots)]
    local pPlot = Map.GetPlotByIndex(iPlot)
    
    print('[Excited Ordeal]Starting to place tribe at:', iPlot)
    
    if ImprovementBuilder.CanHaveImprovement(pPlot, BBCAMP_INDEX, -1) then
        local pBarbManager = Game.GetBarbarianManager()
        --ImprovementBuilder.SetImprovementType(pPlot, -1, NO_PLAYER)
        pBarbManager:CreateTribeOfType(2, iPlot)
    end
    
end





-- ==================================
-- 蛮族完成击杀会有奖励
-- ==================================
function OnUnitKilledInCombat(killedPlayerID, killedUnitID, PlayerID, UnitID)
    -- killedUnitID 是遇害单位的ID，但根本无法获取
    local pPlayer = Players[PlayerID]
    
    if (pPlayer ~= nil) and pPlayer:IsBarbarian() then
        local pWinnerUnit = UnitManager.GetUnit(PlayerID, UnitID)
        local sUnitType = GameInfo.Units[pWinnerUnit:GetType()].UnitType
        local PlotX = pWinnerUnit:GetX()
        local PlotY = pWinnerUnit:GetY()
        
        -- 如果获胜的单位在同一回合中也被别人弄死，那它的位置将是(-9999,-9999)
        if (PlotX > -1) and (PlotY > -1) then
            UnitManager.InitUnitValidAdjacentHex(PlayerID, sUnitType, PlotX, PlotY, 1)
        end
    end
    
end


-- ==================================
-- 摧毁蛮族营地会有新蛮子出现
-- ==================================
function OnImprovementRemovedFromMap(PlotX, PlotY, PlayerID)
    local pPlayer = Players[PlayerID]
    
    if (pPlayer ~= nil) and pPlayer:IsBarbarian() then
        local pBarbManager = Game.GetBarbarianManager()
        local iPlotIndex = Map.GetPlot(PlotX, PlotY):GetIndex()
        local iTribeNumber = 1  -- 可能是蛮族编号
        local iRange = 3        -- 未知（范围？？）
        
        pBarbManager:CreateTribeUnits(iTribeNumber, "CLASS_MELEE", 1, iPlotIndex, iRange)
        pBarbManager:CreateTribeUnits(iTribeNumber, "CLASS_SIEGE", 1, iPlotIndex, iRange)
        pBarbManager:CreateTribeUnits(iTribeNumber, "CLASS_RANGED", 1, iPlotIndex, iRange)
    end

end




-- ==================================
-- 回合开始时，看看要不要刷新一些蛮子
-- ==================================
function OnTurnBegin()
    if math.random() < m_TribeRate then
        PlaceRandomTribes()
    end
end


function Initialize()
    local confRate = GameConfiguration.GetValue('excited_level')
    if (confRate ~= nil) and (confRate > 0) then
        m_TribeRate = confRate / 10
    end
    
    print('[Excited Ordeal]Tribe Rate: ' .. m_TribeRate)

    UpdateAvailablePlots()
    Events.TurnBegin.Add(OnTurnBegin)
    Events.UnitKilledInCombat.Add(OnUnitKilledInCombat)
    Events.ImprovementRemovedFromMap.Add(OnImprovementRemovedFromMap)
end

Initialize()









