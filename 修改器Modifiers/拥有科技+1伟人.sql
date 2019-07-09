
insert into BuildingModifiers (BuildingType, ModifierId) values
('BUILDING_TIANLONG_TEMPLE', 'Tianlong_Grant_GP');

insert into Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) values
('Tianlong_Grant_GP', 'HM_Modifier_Grant_GP', null, 'HM_ReqSet_Get_Tech');

insert into ModifierArguments (ModifierId, Name, Value) values
('Tianlong_Grant_GP', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_GENERAL'),
('Tianlong_Grant_GP', 'Amount', 1);



-- ModifierType
insert into Types (Type, Kind) values
('HM_Modifier_Grant_GP', 'KIND_MODIFIER');

insert into DynamicModifiers (ModifierType, CollectionType, EffectType) values
('HM_Modifier_Grant_GP', 'COLLECTION_OWNER', 'EFFECT_GRANT_GREAT_PERSON_CLASS_IN_CITY');



-- Requirement
insert into Requirements (RequirementId, RequirementType) values
('HM_Req_Get_Tech', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'),
('HM_Req_Get_Tech2', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');

insert into RequirementArguments (RequirementId, Name, Value) values
('HM_Req_Get_Tech', 'TechnologyType', 'TECH_MINING'),
('HM_Req_Get_Tech2', 'TechnologyType', 'TECH_ANIMAL_HUSBANDRY');

-- RequirementSet
insert into RequirementSets (RequirementSetId, RequirementSetType) values
('HM_ReqSet_Get_Tech', 'REQUIREMENTSET_TEST_ANY');

insert into RequirementSetRequirements (RequirementSetId, RequirementId) values
('HM_ReqSet_Get_Tech', 'HM_Req_Get_Tech'),
('HM_ReqSet_Get_Tech', 'HM_Req_Get_Tech2');


















