

function ChangePlotOwner(PlotX, PlotY, PlayerID)
    local pPlot = Map.GetPlot(PlotX, PlotY)
    local pPlayer = Players[PlayerID]
    local pCity = pPlayer:GetCities():GetCapitalCity()
    
    WorldBuilder.CityManager():SetPlotOwner(pPlot, pCity)
end


ExposedMembers.MNS = ExposedMembers.MNS or {}
ExposedMembers.MNS.ChangePlotOwner = ChangePlotOwner



