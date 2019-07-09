
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
("TRAIT_UNIT_SCOIA_TAEL", "expert_marksman_scoia_tael");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("expert_marksman_scoia_tael", "MODIFIER_ADJUST_N_ATTACK", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("expert_marksman_scoia_tael", "Amount", 1);

-- Custom ModifierType

INSERT INTO Types (Type, Kind) VALUES 
("MODIFIER_ADJUST_N_ATTACK", "KIND_MODIFIER");

INSERT INTO DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
("MODIFIER_ADJUST_N_ATTACK", "COLLECTION_PLAYER_UNITS", "EFFECT_ADJUST_UNIT_NUM_ATTACKS");
