
INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES 
("DISTRICT_CITY_CENTER", "MY_CULTURE_BOMB"); 

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("MY_CULTURE_BOMB", "MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER", 0, 0, 0, NULL, NULL); 

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("MY_CULTURE_BOMB", "ImprovementType", "IMPROVEMENT_FARM"); 

