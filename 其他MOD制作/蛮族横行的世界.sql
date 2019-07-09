
-- 让野蛮人更多、更频繁、更嚣张

-- 蛮族出现概率、数量、间距、随机选择、科技程度
UPDATE GlobalParameters SET Value = 9 WHERE Name="BARBARIAN_CAMP_ODDS_OF_NEW_CAMP_SPAWNING";
UPDATE GlobalParameters SET Value = 5 WHERE Name="BARBARIAN_CAMP_MAX_PER_MAJOR_CIV";
UPDATE GlobalParameters SET Value = 1 WHERE Name="BARBARIAN_CAMP_MINIMUM_DISTANCE_ANOTHER_CAMP";
UPDATE GlobalParameters SET Value = 5 WHERE Name="BARBARIAN_NUM_RANDOM_UNIT_CHOICES";
UPDATE GlobalParameters SET Value = 75 WHERE Name="BARBARIAN_TECH_PERCENT";

-- 蛮族的刷新频率、野心
UPDATE BarbarianTribes SET TurnsToWarriorSpawn = 3, CityAttackBoldness=90, RaidingBoldness=50 WHERE TribeType="TRIBE_NAVAL";
UPDATE BarbarianTribes SET TurnsToWarriorSpawn = 3, CityAttackBoldness=90, RaidingBoldness=50 WHERE TribeType="TRIBE_CAVALRY";
UPDATE BarbarianTribes SET TurnsToWarriorSpawn = 3, CityAttackBoldness=90, RaidingBoldness=50 WHERE TribeType="TRIBE_MELEE";

















