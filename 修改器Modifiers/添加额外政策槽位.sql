
-- 添加一个额外的政策槽位，一个修改器只能加一个槽


INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
("BUILDING_PALACE", "add_gov_slot");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("add_gov_slot", "MODIFIER_PLAYER_CULTURE_ADJUST_GOVERNMENT_SLOTS_MODIFIER", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("add_gov_slot", "GovernmentSlotType", "SLOT_WILDCARD");



/* 槽位类型

军事  SLOT_MILITARY
经济  SLOT_ECONOMIC
外交  SLOT_DIPLOMATIC
通用  SLOT_WILDCARD

*/