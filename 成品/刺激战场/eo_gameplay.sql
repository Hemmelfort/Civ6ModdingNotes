

UPDATE GlobalParameters SET Value = 1 WHERE Name="CITY_MIN_DISTANCE_FOR_INCURSION";
UPDATE GlobalParameters SET Value = 1 WHERE Name="COMBAT_RAZE_ANY_CITY";

/*
UPDATE GlobalParameters SET Value = 9 WHERE Name="BARBARIAN_CAMP_ODDS_OF_NEW_CAMP_SPAWNING";
UPDATE GlobalParameters SET Value = 5 WHERE Name="BARBARIAN_CAMP_MAX_PER_MAJOR_CIV";
UPDATE GlobalParameters SET Value = 1 WHERE Name="BARBARIAN_CAMP_MINIMUM_DISTANCE_ANOTHER_CAMP";
UPDATE GlobalParameters SET Value = 5 WHERE Name="BARBARIAN_NUM_RANDOM_UNIT_CHOICES";
UPDATE GlobalParameters SET Value = 85 WHERE Name="BARBARIAN_TECH_PERCENT";

UPDATE BarbarianTribes SET TurnsToWarriorSpawn = 3, CityAttackBoldness=80, RaidingBoldness=50 WHERE TribeType="TRIBE_NAVAL";
UPDATE BarbarianTribes SET TurnsToWarriorSpawn = 3, CityAttackBoldness=80, RaidingBoldness=50 WHERE TribeType="TRIBE_CAVALRY";
UPDATE BarbarianTribes SET TurnsToWarriorSpawn = 3, CityAttackBoldness=80, RaidingBoldness=50 WHERE TribeType="TRIBE_MELEE";
*/
UPDATE BarbarianTribes SET CityAttackBoldness=99;


--- WarmongerPoints ---
UPDATE GlobalParameters SET Value = 0 WHERE Name="WARMONGER_CITY_PERCENT_OF_DOW";
UPDATE GlobalParameters SET Value = 1 WHERE Name="WARMONGER_FINAL_MAJOR_CITY_MULTIPLIER";
UPDATE GlobalParameters SET Value = 1 WHERE Name="WARMONGER_FINAL_MINOR_CITY_MULTIPLIER";
UPDATE GlobalParameters SET Value = 0.1 WHERE Name="WARMONGER_RAZE_PENALTY_PERCENT";

/*
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_ANCIENT';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_CLASSICAL';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_MEDIEVAL';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_RENAISSANCE';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_INDUSTRIAL';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_MODERN';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_ATOMIC';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_INFORMATION';
*/
UPDATE Eras SET WarmongerPoints = 0;

/*
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_FORMAL_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_JOINT_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_SURPRISE_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_HOLY_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_LIBERATION_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_RECONQUEST_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_PROTECTORATE_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_COLONIAL_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_TERRITORIAL_WAR";
*/
UPDATE DiplomaticActions SET WarmongerPercent = 0;









