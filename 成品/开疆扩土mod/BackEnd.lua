
-- 计算距离最近的城市

function GetNearestCity(PlotX, PlotY, PlayerID)
    local dist = 9999
    local city = nil
    local pPlayerCities = Players[PlayerID]:GetCities()
    
    for i, pCity in pPlayerCities:Members() do
        local iDistance = Map.GetPlotDistance(PlotX, PlotY, pCity:GetX(), pCity:GetY())
        
        if (iDistance < dist) then
            dist = iDistance
            city = pCity
        end
    end
    
    return city or pPlayerCities:GetCapitalCity()
end


function ChangePlotOwner(PlotX, PlotY, PlayerID)
    local pPlot = Map.GetPlot(PlotX, PlotY)
    local pCity = GetNearestCity(PlotX, PlotY, PlayerID)
    
    WorldBuilder.CityManager():SetPlotOwner(pPlot, pCity)
end


ExposedMembers.MNS = ExposedMembers.MNS or {}
ExposedMembers.MNS.ChangePlotOwner = ChangePlotOwner



