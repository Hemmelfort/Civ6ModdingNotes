

-- 以中国为例，单位攻击时可以随机产生双倍伤害。

-- 暴击概率
local m_CriticalRate = 0.5;

function onCombat(pCombatResult)
    -- 施暴者信息
    local attacker = pCombatResult[CombatResultParameters.ATTACKER];
    local attInfo = attacker[CombatResultParameters.ID]
    local pPlayerConfig = PlayerConfigurations[attInfo.player]
    
    if (pPlayerConfig == nil)
    or (pPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_CHINA") then
        return
    end
    
    -- 受害者信息
    local defender = pCombatResult[CombatResultParameters.DEFENDER]
    local defInfo = defender[CombatResultParameters.ID]
    
    if  (attInfo.type == ComponentType.UNIT)
    and (defInfo.type == ComponentType.UNIT)
    and (math.random() < m_CriticalRate) then
        local location = pCombatResult[CombatResultParameters.LOCATION];
        local damage = defender[CombatResultParameters.FINAL_DAMAGE_TO]        
        --local pAttUnit = UnitManager.GetUnit(attInfo.player, attInfo.id)
        local pDefUnit = UnitManager.GetUnit(defInfo.player, defInfo.id)
        
        pDefUnit:ChangeDamage(damage)
        Game.AddWorldViewText(0, "Double Kill!", location.x, location.y)
    end
    
end

Events.Combat.Add(onCombat)

