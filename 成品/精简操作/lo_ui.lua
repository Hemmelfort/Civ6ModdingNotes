
-- ====================================
-- 创建日期：2020.01.18
-- 作者：Hemmelfort
-- 说明：该脚本是“精简操作” mod 的一部分，用于实现一键驻扎、
--      商路可中断、建造不消耗移动力、城市项目自动重复等功能。
-- ====================================
-- 
-- ====================================

local m_LocalPlayer = Game.GetLocalPlayer()
local m_iTrader = GameInfo.Units["UNIT_TRADER"].Index;

local m_UnrestOperations = {};
local m_UnrestOperationNames = {
    -- 以下操作不消耗移动力
    "UNITOPERATION_BUILD_IMPROVEMENT",
    "UNITOPERATION_REPAIR",
    "UNITOPERATION_REMOVE_FEATURE",
    "UNITOPERATION_REMOVE_IMPROVEMENT",
    "UNITOPERATION_HARVEST_RESOURCE",
}

-- 用 m_UnrestOperations 代替 m_UnrestOperationNames
for _, op in ipairs(m_UnrestOperationNames) do
    table.insert(m_UnrestOperations, GameInfo.UnitOperations[op].Index)
end


-- ====================================
-- 判断 table 中是否包含某一项
-- ====================================
function IsIncluded(tab, value)
    for _, v in ipairs(tab) do
        if value == v then
            return true
        end
    end
    
    return false
end




-- ====================================
-- 实行 Unit Operation 的时候
-- ====================================
function OnUnitOperationAdded(playerID, unitID, iUnknown, hOperation)
    if (playerID == m_LocalPlayer) and IsIncluded(m_UnrestOperations, hOperation) then
        -- 恢复建造者的移动力
        ExposedMembers.LO.RestoreMovement(playerID, unitID)
    end
end


-- ====================================
-- 城市建造完成后的操作：如果是区域增强项目就重复进行
-- ====================================
function OnCityProductionCompleted(playerID, cityID, iConstructionType, itemID, bCancelled)
    if (playerID == m_LocalPlayer) and (iConstructionType == 3) then        
        local project = GameInfo.Projects[itemID]
        
        if (project ~= nil) and string.find(project.ProjectType, "PROJECT_ENHANCE_DISTRICT") then 
            local pCity = CityManager.GetCity(playerID, cityID)
            local tParameters = {}
            tParameters[CityOperationTypes.PARAM_PROJECT_TYPE] = project.Hash
            CityManager.RequestOperation(pCity, CityOperationTypes.BUILD, tParameters)
        end
    end
end


-- ====================================
-- 单位被选中时：显示商人的特殊按钮
-- ====================================
function OnUnitSelectionChanged(PlayerID, UnitID, PlotX, PlotY, PlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(PlayerID, UnitID)
        Controls.StopTradeRouteGrid:SetHide(pUnit:GetType() ~= m_iTrader)
    end
end


-- ====================================
-- 中断商路。原理是鲨了他，然后再造一个。
-- ====================================
function StopTradeRoute()
    local pSelectedUnit = UI.GetHeadSelectedUnit();
    if pSelectedUnit ~= nil then
        local iOwner = pSelectedUnit:GetOwner()
        local iUnitID = pSelectedUnit:GetID()
        local pCities = Players[iOwner]:GetCities()
        
        for _, city in pCities:Members() do
            local pRoutes = city:GetTrade():GetOutgoingRoutes()
            
            for i, route in ipairs(pRoutes) do
                if (iUnitID == route.TraderUnitID) then
                    local pOriginCity = pCities:FindID(route.OriginCityID)
                    if not pOriginCity then
                        return
                    end

                    local iX = pOriginCity:GetX()
                    local iY = pOriginCity:GetY()
                    ExposedMembers.LO.KillUnit(iOwner, iUnitID)
                    ExposedMembers.LO.CreateUnit(iOwner, m_iTrader, iX, iY)
                end
            end
        end
    end
end


-- ====================================
-- 让商人把商路重新走一遍
-- ====================================
function TraderRewalk(pUnit)
    if (pUnit:GetType() == m_iTrader) then
        local pTrade = pUnit:GetTrade()
        local tDestComponentID = pTrade:GetLastDestinationTradeCityComponentID()
        local pDestCity = CityManager.GetCity(playerID, tDestComponentID.id)
        if (not pDestCity) then
            return
        end

        local tParameters = {}
        tParameters[UnitOperationTypes.PARAM_X0] = pDestCity:GetX()
        tParameters[UnitOperationTypes.PARAM_Y0] = pDestCity:GetY()
        tParameters[UnitOperationTypes.PARAM_X1] = pUnit:GetX()
        tParameters[UnitOperationTypes.PARAM_Y1] = pUnit:GetY()
        
        if (UnitManager.CanStartOperation(pUnit, UnitOperationTypes.MAKE_TRADE_ROUTE, nil, tParameters)) then
            UnitManager.RequestOperation(pUnit, UnitOperationTypes.MAKE_TRADE_ROUTE, tParameters)
        else
            print("Cannot set trade route.")
        end
    end
end


-- ///////////////////////////////////////////////////
-- 怎样判断商人完成了一条商路？以下的几个方法似乎都不够完美。
function OnUnitActivityChanged(playerID, unitID, eActivityType)
    --lo_ui: OnUnitActivityChanged	0	262147	1225574625 开始
    --lo_ui: OnUnitActivityChanged	0	262147	1797587246 结束
    if (playerID == m_LocalPlayer) then
        --local eActivityType:number = UnitManager.GetActivityType(selectedUnit)
        
        local pUnit = UnitManager.GetUnit(playerID, unitID)
        if pUnit then 
            TraderRewalk(pUnit)
        end
    end
end

function OnUnitOperationsCleared(playerID, unitID, hCommand, iData1)
    if playerID == m_LocalPlayer then
        local pUnit = UnitManager.GetUnit(playerID, unitID)
        if pUnit then 
            TraderRewalk(pUnit)
        end
    end
end

function OnLocalPlayerTurnBegin()
    local pPlayer = Players[m_LocalPlayer]
    for _, pUnit in pPlayer:GetUnits():Members() do
        TraderRewalk(pUnit)
    end
end

-- TraderRewalk() 本身没问题，问题在于来自 Events 的调用无法使其生效，
-- 只有让他绑定一按钮，然后玩家点击才会起作用。
-- ///////////////////////////////////////////////////



-- ====================================
-- 单位自动驻扎
-- ====================================
function AutoFortify()
    local pPlayer = Players[m_LocalPlayer]
    if pPlayer == nil then
        return
    end
    
    local playerUnits = pPlayer:GetUnits()
    for i, pUnit in playerUnits:Members() do
        -- 为什么 UnitOperationTypes.WAIT_FOR 不行呢？
        -- TODO: 未警戒才能自动驻扎 pUnit:GetOperationType()
        if UnitManager.CanStartOperation(pUnit, UnitOperationTypes.FORTIFY) then
            UnitManager.RequestOperation(pUnit, UnitOperationTypes.FORTIFY)
        end
    end
    UI.PlaySound("Confirm_Civic")
end


-- ====================================
-- 用户触发某按键
-- ====================================
function OnInputActionTriggered(iActionID)
    if (iActionID == Input.GetActionId('AutoFortify')) then
        AutoFortify()
    end
end


-- ====================================
-- 游戏加载完成后装载界面
-- ====================================
function Setup()
    local ActionStack = ContextPtr:LookUpControl("/InGame/UnitPanel/StandardActionsStack")
    
    if ActionStack ~= nil then
        Controls.StopTradeRouteGrid:ChangeParent(ActionStack)
    else
        print("StandardActionsStack not found.")
    end
    
    Controls.StopTradeRouteButton:RegisterCallback(Mouse.eLClick, StopTradeRoute)
end



-- ====================================
-- 初始化
-- ====================================
function Initialize()
    Events.LoadScreenClose.Add(Setup)
    Events.CityProductionCompleted.Add(OnCityProductionCompleted)
    Events.UnitOperationAdded.Add(OnUnitOperationAdded)         -- 建造者移动力
    Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)     -- 商人按钮
    --Events.UnitActivityChanged.Add(OnUnitActivityChanged)
    Events.UnitOperationsCleared.Add(OnUnitOperationsCleared)   -- 商路自动重复
    --Events.LocalPlayerTurnBegin.Add(OnLocalPlayerTurnBegin)
    Events.InputActionTriggered.Add(OnInputActionTriggered)     -- 一键驻扎
end

Initialize()

