
-- 是否受够了 AI 无休止、不明就里、毫无逻辑的谴责？
-- 本解决方案可以完美处理这种情况！只要任一玩家谴责另一玩家，战争立刻触发！
-- 这样发动谴责的那一方就会承担战狂的罪名。

-- 由于判断能否发动战争的函数只能用在 UI 环境，而宣战的函数又在 Gameplay 环境，
-- 所以要分成两个文件来写。


------------------------------------------------
-- Gameplay 环境，用于宣战的功能（这个文件要用 AddGameplayScripts 操作）
------------------------------------------------
function PerformFighting(player1, player2)
    Players[player1]:GetDiplomacy():DeclareWarOn(player2, WarTypes.FORMAL_WAR, true)
end

ExposedMembers.TEST = ExposedMembers.TEST or {}
ExposedMembers.TEST.PerformFighting = PerformFighting


------------------------------------------------
-- UI 环境，处理玩家被谴责时的应对事件（这个要用 AddUserInterfaces 操作）
------------------------------------------------
function OnDiplomacyRelationshipChanged(p1, p2)
    
    -- 如果两人已经打起来了，那就算了
    if Players[p1]:GetDiplomacy():IsAtWarWith(p2) then
        return
    end
    
    -- 获取双方目前的关系
    local iState = Players[p1]:GetDiplomaticAI():GetDiplomaticStateIndex(p2)
    local sStateType = GameInfo.DiplomaticStates[iState].StateType
    
    -- 如果是谴责状态，且可以一战，那就打起来
    if (sStateType == 'DIPLO_STATE_DENOUNCED')
    and Players[p1]:GetDiplomacy():CanDeclareWarOn(p2) then
        ExposedMembers.TEST.PerformFighting(p1, p2)
    end
end

Events.DiplomacyRelationshipChanged.Add(OnDiplomacyRelationshipChanged)



-- 后记：
--     关系是双向的，当p1对p2的关系改变时，p2也对p1有相同的变化，
--     所以 Events.DiplomacyRelationshipChanged 会连续触发两次。

