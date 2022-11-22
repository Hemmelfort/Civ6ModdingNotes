
-- 注意：如果不限制该项目，那么电脑AI也能使用


-- 1. 创建新项目，本例中的项目名为 PROJECT_MILE_EYES
insert into Types (Type, Kind) values
('PROJECT_MILE_EYES', 'KIND_PROJECT');

-- 2. 项目的名称、花费、最多可以执行几次等等
insert into Projects (ProjectType, Name, ShortName, Cost, MaxPlayerInstances) values
('PROJECT_MILE_EYES', 'Reveal map', 'rev map', 10, 1);


/*
    项目的效果一般是通过修改器Modifier来实现的，所以往往还要给这个项目绑定一个修改器。
*/

insert into ProjectCompletionModifiers (ProjectType, ModifierId) values
('PROJECT_MILE_EYES', 'Mod_Reveal_All_Map');

insert into Modifiers (ModifierId, ModifierType, RunOnce, SubjectRequirementSetId) values
('Mod_Reveal_All_Map', 'MODIFIER_PLAYER_EXPLORE_ENTIRE_MAP', 1, NULL);

















