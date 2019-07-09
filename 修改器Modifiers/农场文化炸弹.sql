
INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES 
("DISTRICT_CITY_CENTER", "MY_CULTURE_BOMB"); 

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("MY_CULTURE_BOMB", "MODIFIER_PLAYER_ADD_CULTURE_BOMB_TRIGGER", 0, 0, 0, NULL, "REQSET_MCB"); 

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("MY_CULTURE_BOMB", "ImprovementType", "IMPROVEMENT_FARM"); 

-- Single Conditions

INSERT INTO Requirements (RequirementId, RequirementType) VALUES 
("REQ_MCB_IS_HUMAN", "REQUIREMENT_PLAYER_IS_HUMAN"); 

-- Conditions Group

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
("REQSET_MCB", "REQUIREMENTSET_TEST_ALL"); 

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
("REQSET_MCB", "REQ_MCB_IS_HUMAN"); 
