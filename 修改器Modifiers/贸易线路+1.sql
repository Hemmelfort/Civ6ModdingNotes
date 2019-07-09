
INSERT INTO DistrictModifiers (DistrictType, ModifierId) VALUES 
("DISTRICT_CITY_CENTER", "CC_More_Trade_Route"); 

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("CC_More_Trade_Route", "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY", 0, 0, 0, NULL, "ReqSet"); 

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("CC_More_Trade_Route", "Amount", 1); 

-- Single Conditions

INSERT INTO Requirements (RequirementId, RequirementType) VALUES 
("Has_Tech", "REQUIREMENT_PLAYER_HAS_TECHNOLOGY"), 
("Is_Human", "REQUIREMENT_PLAYER_IS_HUMAN"); 

INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES 
("Has_Tech", "TechnologyType", "TECH_POTTERY"); 

-- Conditions Group

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
("ReqSet", "REQUIREMENTSET_TEST_ALL"); 

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
("ReqSet", "Has_Tech"), 
("ReqSet", "Is_Human"); 
