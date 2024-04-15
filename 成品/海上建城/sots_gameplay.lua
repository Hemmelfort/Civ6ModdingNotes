

function ChangeTerrain(iX, iY, iTerrain)
    local pPlot = Map.GetPlot(iX, iY)
    TerrainBuilder.SetTerrainType(pPlot, iTerrain)
end


if ExposedMembers.SOTS == nil then
    ExposedMembers.SOTS = {}
end

ExposedMembers.SOTS.ChangeTerrain = ChangeTerrain




