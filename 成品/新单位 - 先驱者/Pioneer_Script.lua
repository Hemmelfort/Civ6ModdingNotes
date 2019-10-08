

function ChooseFromList(itemlist)
    return itemlist and itemlist[math.random(#itemlist)] or nil
end


function RandomUnitType()
    local currentEra = Game.GetEras():GetCurrentEra();
    local eraName = GameInfo.Eras[currentEra].EraType;
    local unitType;
    
    if eraName == "ERA_ANCIENT" then
    	unitType = ChooseFromList({"UNIT_SLINGER", "UNIT_WARRIOR", "UNIT_HEAVY_CHARIOT"})

    elseif eraName == "ERA_CLASSICAL" then
    	unitType = ChooseFromList({"UNIT_SWORDSMAN", "UNIT_SPEARMAN", "UNIT_ARCHER", "UNIT_HORSEMAN"})

    elseif eraName == "ERA_MEDIEVAL" then
    	unitType = ChooseFromList({"UNIT_KNIGHT", "UNIT_CROSSBOWMAN"})

    elseif eraName == "ERA_RENAISSANCE" then
    	unitType = ChooseFromList({"UNIT_MUSKETMAN", "UNIT_PIKEMAN", })

    elseif eraName == "ERA_INDUSTRIAL" then
    	unitType = ChooseFromList({"UNIT_CAVALRY", "UNIT_FIELD_CANNON", "UNIT_RANGER"})

    elseif eraName == "ERA_MODERN" then
    	unitType = ChooseFromList({"UNIT_AT_CREW", "UNIT_INFANTRY"})

    elseif eraName == "ERA_ATOMIC" then
    	unitType = ChooseFromList({"UNIT_TANK", "UNIT_HELICOPTER", "UNIT_MACHINE_GUN"})

    elseif eraName == "ERA_INFORMATION" then
    	unitType = ChooseFromList({"UNIT_MODERN_AT", "UNIT_MODERN_ARMOR", "UNIT_MECHANIZED_INFANTRY"})
    end
    
    return unitType or "UNIT_GIANT_DEATH_ROBOT"

end


function SummonBarbarian(PlotX, PlotY)    
    if (PlotX > -1) and (PlotY > -1) then
        local sUnitType = RandomUnitType()
        UnitManager.InitUnitValidAdjacentHex(63, sUnitType, PlotX, PlotY, 1)
    end

end


ExposedMembers.MNS = ExposedMembers.MNS or {}
ExposedMembers.MNS.SummonBarbarian = SummonBarbarian



