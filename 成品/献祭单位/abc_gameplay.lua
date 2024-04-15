

function SacrificeUnitInCity(iPlayerID, iUnitID)
    local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
    if (pUnit ~= nil) then
        local x = pUnit:GetX()
        local y = pUnit:GetY()
        local pCity = CityManager.GetCityAt(x, y);
        if (pCity ~= nil) then
            pCity:ChangePopulation(1)   --效果举例：城市人口加一
            UnitManager.Kill(pUnit)
            Game.AddWorldViewText(0, '献祭成功！', x, y)
        else
            Game.AddWorldViewText(0, '必须在城里！', x, y)
        end
    end
end


if ExposedMembers.DEMO == nil then
    ExposedMembers.DEMO = {}
end

ExposedMembers.DEMO.SacrificeUnitInCity = SacrificeUnitInCity
