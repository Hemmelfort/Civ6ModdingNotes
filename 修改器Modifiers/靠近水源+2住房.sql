
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
("BUILDING_MONUMENT", "HM_MOD_GIVE_ME_HOUSE"); 

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("HM_MOD_GIVE_ME_HOUSE", "MODIFIER_ADD_HOUSE", 0, 0, 0, NULL, "JUST_ME"); 

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("HM_MOD_GIVE_ME_HOUSE", "Amount", 2); 

-- Custom ModifierType

INSERT INTO Types (Type, Kind) VALUES 
("MODIFIER_ADD_HOUSE", "KIND_MODIFIER"); 

INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
("MODIFIER_ADD_HOUSE", "COLLECTION_OWNER", "EFFECT_ADJUST_WATER_HOUSING"); 

-- Single Conditions

INSERT INTO Requirements (RequirementId, RequirementType) VALUES 
("IS_ME", "REQUIREMENT_PLAYER_IS_HUMAN"); 

-- Conditions Group

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES 
("JUST_ME", "REQUIREMENTSET_TEST_ALL"); 

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
("JUST_ME", "IS_ME"); 
