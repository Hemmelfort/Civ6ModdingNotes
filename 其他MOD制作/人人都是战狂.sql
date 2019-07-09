
/*
    作者：Hemmelfort
    说明：以下数值均已经过测试，但不一定是最合适的。
*/


-- 快取胜时不再降好感度
UPDATE ModifierArguments SET Value = -4 WHERE ModifierId="STANDARD_DIPLOMATIC_CLOSE_TO_VICTORY" AND Name="MaxValue";

-- 单边贸易加好感度
UPDATE ModifierArguments SET Value = 12 WHERE ModifierId="STANDARD_DIPLOMATIC_ONE_SIDED_TRADES" AND Name="MaxValue";

-- 你轰我城我也不恨你
UPDATE ModifierArguments SET Value=-5 WHERE ModifierId='STANDARD_DIPLOMATIC_RAZED_MY_CITY' AND Name='InitialValue';
UPDATE ModifierArguments SET Value=5 WHERE ModifierId='STANDARD_DIPLOMATIC_RAZED_MY_CITY' AND Name='ReductionTurns';
UPDATE ModifierArguments SET Value=-1 WHERE ModifierId='STANDARD_DIPLOMATIC_RAZED_MY_CITY' AND Name='ReductionValue';

-- 占领城市不会拉仇恨
UPDATE ModifierArguments SET Value=1 WHERE ModifierId='STANDARD_DIPLOMATIC_WARMONGER' AND Name='ReductionTurns';
UPDATE ModifierArguments SET Value=0 WHERE ModifierId='STANDARD_DIPLOMATIC_OCCUPIED_CITY' AND Name='InitialValue';
UPDATE ModifierArguments SET Value=0 WHERE  ModifierId='STANDARD_DIPLOMATIC_OCCUPIED_FRIENDLY_CITY' AND Name='InitialValue';


--- 大幅减少战狂点数 ---
UPDATE GlobalParameters SET Value = 0 WHERE Name="WARMONGER_CITY_PERCENT_OF_DOW";
UPDATE GlobalParameters SET Value = 1 WHERE Name="WARMONGER_FINAL_MAJOR_CITY_MULTIPLIER";
UPDATE GlobalParameters SET Value = 1 WHERE Name="WARMONGER_FINAL_MINOR_CITY_MULTIPLIER";
UPDATE GlobalParameters SET Value = 0.1 WHERE Name="WARMONGER_RAZE_PENALTY_PERCENT";

UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_ANCIENT';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_CLASSICAL';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_MEDIEVAL';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_RENAISSANCE';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_INDUSTRIAL';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_MODERN';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_ATOMIC';
UPDATE Eras SET WarmongerPoints = 0 WHERE EraType ='ERA_INFORMATION';

UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_FORMAL_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_JOINT_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_SURPRISE_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_HOLY_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_LIBERATION_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_RECONQUEST_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_PROTECTORATE_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_COLONIAL_WAR";
UPDATE DiplomaticActions SET WarmongerPercent = 0 WHERE DiplomaticActionType = "DIPLOACTION_DECLARE_TERRITORIAL_WAR";



/*****************************************************
    以下适用于《风云变幻》
*****************************************************/

-- 大幅减少不满值（Grievances）
update GlobalParameters set Value=2 where Name="GRIEVANCE_MULTIPLIER_FOR_BROKEN_PROMISE";
update GlobalParameters set Value=2 where Name="GRIEVANCES_ALL_PLAYERS_CITY_STATE_CONQUEST";
update GlobalParameters set Value=2 where Name="GRIEVANCES_FOR_DENOUNCEMENT";
update GlobalParameters set Value=2 where Name="GRIEVANCES_HAVE_ENVOYS_CITY_STATE_DOW";
update GlobalParameters set Value=1 where Name="GRIEVANCES_POSSESS_CAPITAL_PER_TURN";
update GlobalParameters set Value=1 where Name="GRIEVANCES_POSSESS_NON_CAPITAL_PER_TURN";
update GlobalParameters set Value=4 where Name="GRIEVANCES_SUZERAIN_CITY_STATE_DOW";

update GlobalParameters set Value=5 where Name="SHARE_WAR_GRIEVANCES_ALLY";
update GlobalParameters set Value=2 where Name="SHARE_WAR_GRIEVANCES_DECLARED_FRIENDS";
update GlobalParameters set Value=2 where Name="SHARE_WAR_GRIEVANCES_DEFENSIVE_PERCENT";







