
-- 本 mod 给所有主要文明的草原格位都增加一粮食

INSERT INTO TraitModifiers (TraitType, ModifierId)
VALUES
('TRAIT_LEADER_MAJOR_CIV', 'MODIFIER_PLAYERS_FERTILE_GRASSLAND');



INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId)
VALUES
('MODIFIER_PLAYERS_FERTILE_GRASSLAND', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'REQSET_GRASS_PLOT');

INSERT INTO ModifierArguments (ModifierId, Name, Value)
VALUES
('MODIFIER_PLAYERS_FERTILE_GRASSLAND', 'Amount', '1'),
('MODIFIER_PLAYERS_FERTILE_GRASSLAND', 'YieldType', 'YIELD_FOOD');


-- 条件要求：格位必须是草原

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES
('REQSET_GRASS_PLOT', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
('REQSET_GRASS_PLOT', 'REQ_PLOT_IS_GRASS');

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES
('REQ_PLOT_IS_GRASS', 'REQUIREMENT_PLOT_TERRAIN_TYPE_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES
('REQ_PLOT_IS_GRASS', 'TerrainType', 'TERRAIN_GRASS');
