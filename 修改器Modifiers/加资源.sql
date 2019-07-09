
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
("BUILDING_MONUMENT", "x_x");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("x_x", "MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("x_x", "Amount", 2), 
("x_x", "ResourceType", "RESOURCE_COAL");

