

-- 功能：单位在初次升级后能够恢复移动力


-- 注意：
-- pUnit:GetExperience():GetLevel() 只能用在UI环境

-- 以下两个事件只在获得晋升时触发，而不是在晋升之后，所以没用
-- Events.UnitPromoted.Add(OnUnitPromoted)
-- Events.UnitPromotionAvailable.Add(OnUnitPromotionAvailable)


-- UnitCommandTypes.PROMOTE
local HASH_UNITCOMMAND_PROMOTE = -1259482049


function OnUnitCommandStarted(iPlayerID, iUnitID, hCommand, iData1)
    if (hCommand ~= HASH_UNITCOMMAND_PROMOTE) then
		return
    end

    --文明能力用行A，领袖用行B
    local pPlayerConfig = PlayerConfigurations[iPlayerID];
    if (pPlayerConfig == nil)
    or (pPlayerConfig:GetCivilizationTypeName() ~= "CIVILIZATION_CHINA") --行A
    --or pPlayerConfig:GetLeaderTypeName() ~= "LEADER_QIN"               --行B
    then
        return
    end
    
    -- 单位最低升级经验建议从 GlobalParameters 获取 UPGRADE_MINIMUM_COST 的值
    local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID)
    if  (pUnit ~= nil)
    and (pUnit:GetExperience():GetExperiencePoints() < 16) then
        UnitManager.RestoreMovementToFormation(pUnit)
        Game.AddWorldViewText(0, "恢复移动力", pUnit:GetX(), pUnit:GetY())
    end
end


Events.UnitCommandStarted.Add(OnUnitCommandStarted)













