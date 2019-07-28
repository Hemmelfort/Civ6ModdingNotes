
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
("BUILDING_MONUMENT", "test_temp");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("test_temp", "MODIFIER_PLAYER_ADJUST_PROGRESS_DIFF_TRADE_BONUS", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("test_temp", "TechCivicsPerYield", 2);
