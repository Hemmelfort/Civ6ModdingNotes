
----------------------------------------------------------------
-- 功能：向城邦征兵时，连同平民也一起征了
----------------------------------------------------------------


Events.LevyCounterChanged.Add(function (originalOwnerID : number)    
	local pOriginalOwner = Players[originalOwnerID];
	if pOriginalOwner == nil then
        return
    end
    
    local influence = pOriginalOwner:GetInfluence()
    local suzerainID = influence:GetSuzerain()
	local iLevyTurn = influence:GetLevyTurnCounter()
	if iLevyTurn ~= 0 then
        -- 注意：征兵后，Events.LevyCounterChanged 事件每回合都会触发，
        -- 所以如果是城邦后面新造出来的单位就不要去征用了。
        return
    end
    
    -- 遍历originalOwner的所有单位，找出平民
    for i,unit in pOriginalOwner:GetUnits():Members() do
        local unitInfo = GameInfo.Units[unit:GetType()]
        
        if unitInfo.Combat == 0 then        
            ExposedMembers.LC.SetUnitOwner(originalOwnerID, unit:GetID(), suzerainID)
        end
    end

end)

