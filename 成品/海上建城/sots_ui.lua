

local m_SettlerIndex = GameInfo.Units['UNIT_SETTLER'].Index
local m_CityMinRange = GameInfo.GlobalParameters['CITY_MIN_RANGE'].Value
local m_TerrainPlains = GameInfo.Terrains['TERRAIN_PLAINS'].Index
local m_TerrainCoast = GameInfo.Terrains['TERRAIN_COAST'].Index
local m_TerrainOcean = GameInfo.Terrains['TERRAIN_OCEAN'].Index


-- 点(iX,iY)处是否位于合适的建城范围内
function IsValidCityDistance(iX, iY)
    local plots = Map.GetNeighborPlots(iX, iY, m_CityMinRange)
    for i, adjPlot in ipairs(plots) do
        if adjPlot:IsCity() then
            return false
        end
    end
    return true
end





function OnUnitSelectionChanged(iPlayerID, iUnitID, iPlotX, iPlotY, iPlotZ, bSelected, bEditable)
    if bSelected then
        local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
        if pUnit:GetType() ~= m_SettlerIndex then
            Controls.SettleButtonGrid:SetHide(true)
            return
        end
        
        local pPlot = Map.GetPlot(iPlotX, iPlotY)
        Controls.SettleButtonGrid:SetHide(not pPlot:IsWater())
    end
end


-- 按钮被点击之后
function OnSettleButtonClicked()
    local pUnit = UI.GetHeadSelectedUnit()
    local iX = pUnit:GetX()
    local iY = pUnit:GetY()
    
    if IsValidCityDistance(iX, iY) then
        ExposedMembers.SOTS.ChangeTerrain(iX, iY, m_TerrainPlains)
        UnitManager.RequestOperation(pUnit, UnitOperationTypes.FOUND_CITY)
        for _, pNeighborPlot in ipairs(Map.GetAdjacentPlots(iX, iY)) do
            if pNeighborPlot:GetTerrainType() == m_TerrainOcean then
                ExposedMembers.SOTS.ChangeTerrain(pNeighborPlot:GetX(), pNeighborPlot:GetY(), m_TerrainCoast)
            end
        end
    else
        local msg = Locale.Lookup('LOC_CITY_TOO_CLOSE', m_CityMinRange)
        UI.AddWorldViewText(0, msg, iX, iY)
    end
end


function Setup()
    local path = '/InGame/UnitPanel/StandardActionsStack'
    local ctrl = ContextPtr:LookUpControl(path)
    if ctrl ~= nil then
        Controls.SettleButtonGrid:ChangeParent(ctrl)
    end
    Controls.SettleButton:RegisterCallback(Mouse.eLClick, OnSettleButtonClicked)
end

Events.LoadGameViewStateDone.Add(Setup)
Events.UnitSelectionChanged.Add(OnUnitSelectionChanged)


