--[[
    此脚本可以将其他玩家的奇观（连同所在的格位）划为己有。
]]--


-------------- 以下三个对象的坐标要自己指定 --------------

local pCity = CityManager.GetCityAt(45, 8)  --目前奇观所在的城市
local pMyCity = CityManager.GetCityAt(4, 7) --要把奇观划到我方的哪一座城
local pPlot = Map.GetPlot(37, 9)            --奇观所在格位



-------------- 以下内容可以不用改 --------------

local eWonderType = pPlot:GetWonderType()
local building = GameInfo.Buildings[eWonderType]

pCity:GetBuildings():RemoveBuilding(building.Index)
WorldBuilder.CityManager():SetPlotOwner(pPlot, pMyCity)
pMyCity:GetBuildQueue():CreateBuilding(building.Index, pPlot:GetIndex())

