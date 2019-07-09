
INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES 
("DISTRICT_CITY_CENTER", "CC_TEST"); 

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("CC_TEST", "MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT", 0, 1, 0, NULL, "ReqSet"); 

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("CC_TEST", "Amount", 1); 

-- Single Conditions

INSERT INTO Requirements (RequirementId, RequirementType) VALUES 
("SubjectReq_4", "REQUIREMENT_PLAYER_HAS_RESOURCE_OWNED"); 

INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES 
("SubjectReq_4", "ResourceType", "RESOURCE_WHEAT"); 

-- Conditions Group

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
("ReqSet", "REQUIREMENTSET_TEST_ALL"); 

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
("ReqSet", "SubjectReq_4"); 
