
-- 提升外交能见度水平，以项目为例（一个项目只能提升一次，但可以一次加到最高级别）

insert into Types (Type, Kind) values
('prj_test', 'KIND_PROJECT');

insert into Projects (ProjectType, Name, ShortName, Cost, MaxPlayerInstances) values
('prj_test', 'prj_test', 'prj_test', 2, 1);


-- 此处的 PrereqTech 一定要填，否则无效。至于到底是什么科技倒无影响
insert into DiplomaticVisibilitySources (VisibilitySourceType, Description, ActionDescription, GossipString, PrereqTech) values
("SOURCE_CUSTOM", "情报专家", "随便填啦", "八卦消息", "TECH_POTTERY");


-- 
INSERT INTO ProjectCompletionModifiers (ProjectType, ModifierId) VALUES 
("prj_test", "asdffghxzvc");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("asdffghxzvc", "MODIFIER_PLAYER_ADD_DIPLO_VISIBILITY", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("asdffghxzvc", "Amount", 1), 
("asdffghxzvc", "Source", "SOURCE_CUSTOM"), 
("asdffghxzvc", "SourceType", "DIPLO_SOURCE_ALL_NAMES");


