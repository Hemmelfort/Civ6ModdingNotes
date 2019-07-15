
-- 如果要给某个特定的单位添加“+1攻击次数”的特性，一般是先给它赋予一项能力（ability），然后用这个ability绑定一个修改器。

-- 以下是简单粗暴地给自己所有单位都加攻击次数的情况。


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
