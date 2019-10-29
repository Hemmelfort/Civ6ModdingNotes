
-- 功能：每个奇观都能获得一个外交胜利点数

INSERT INTO BuildingModifiers (BuildingType, ModifierId) 
SELECT BuildingType, "AddDiploVicPoints" 
FROM Buildings WHERE IsWonder=1;

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("AddDiploVicPoints", "MODIFIER_PLAYER_ADJUST_DIPLOMATIC_VICTORY_POINTS", 1, 1, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("AddDiploVicPoints", "Amount", 1), 
("AddDiploVicPoints", "Tooltip", "AddDiploVicPoints");

