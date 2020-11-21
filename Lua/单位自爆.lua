
-- 以勇士为例，当勇士遇害时会自爆（对周边格位的单位造成伤害）

function OnCombat(pCombatResult)
    --先获取受害者的相关信息
    local location = pCombatResult[CombatResultParameters.LOCATION];
    local defender = pCombatResult[CombatResultParameters.DEFENDER]
    local defInfo = defender[CombatResultParameters.ID]
    local pUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)
    
    if pUnit ~= nil
    and GameInfo.Units[pUnit:GetType()].UnitType == 'UNIT_WARRIOR'
    and pUnit:IsDelayedDeath()  --要死了
    then
        local tNeighborPlots = Map.GetAdjacentPlots(location.x, location.y);
        for _, plot in ipairs(tNeighborPlots) do
            for loop, unit in ipairs(Units.GetUnitsInPlot(plot)) do
                if(unit ~= nil) then
                    unit:ChangeDamage(20)   --造成20点伤害
                    Game.AddWorldViewText(0, '被爆到', plot:GetX(), plot:GetY())
                end
            end
        end
    end
end

Events.Combat.Add(OnCombat)
