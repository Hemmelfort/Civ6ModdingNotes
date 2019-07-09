
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
("TRAIT_CIVILIZATION_DYNASTIC_CYCLE", "my_modifier");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("my_modifier", "MODIFIER_ADJUST_OPEN_BORDERS_FROM_INFLUENCE", 0, 0, 0, NULL, NULL);
