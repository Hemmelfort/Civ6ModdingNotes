
-- 以项目 PRJ_TEST 为例，完成项目后获得100金币

insert into ProjectCompletionModifiers (ProjectType, ModifierId) values
("PRJ_TEST", "ModGrantGold");

insert into Modifiers (ModifierId, ModifierType) values
("ModGrantGold", "MODIFIER_PLAYER_GRANT_YIELD");

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("ModGrantGold", "Amount", 100),
("ModGrantGold", "YieldType", "YIELD_GOLD");

