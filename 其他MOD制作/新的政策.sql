
-- 1. 创建新政策
INSERT INTO Types (Type, Kind) VALUES
('Policy_Welfare', 'KIND_POLICY');

-- 2. 政策的名称、描述、需要的槽位类型
INSERT INTO Policies (PolicyType, Name, Description, GovernmentSlotType) VALUES
("Policy_Welfare", "Welfare", "+5 identities", "SLOT_MILITARY");

/*
槽位类型：（详见 GovernmentSlots 表中）
    SLOT_MILITARY       军事
    SLOT_ECONOMIC       经济
    SLOT_DIPLOMATIC     外交
    SLOT_WILDCARD       通配符
    SLOT_GREAT_PERSON   伟人
*/



-----------------------------------------

-- 为该政策添加修改器 Modifier 

INSERT INTO PolicyModifiers (PolicyType, ModifierId) VALUES 
("Policy_Welfare", "Modifier_Welfare_Change_Cities_Identity");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("Modifier_Welfare_Change_Cities_Identity", "MODIFIER_PLAYER_CITIES_ADJUST_IDENTITY_PER_TURN", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("Modifier_Welfare_Change_Cities_Identity", "Amount", 10);

