
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES 
("BUILDING_MONUMENT", "Gain_Science"),
("BUILDING_MONUMENT", "Gain_Culture");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("Gain_Science", "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL", 0, 0, 0, NULL, NULL),
("Gain_Culture", "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("Gain_Science", "Amount", 4), 
("Gain_Science", "Intercontinental", 0), 
("Gain_Science", "YieldType", "YIELD_SCIENCE"),

("Gain_Culture", "Amount", 4), 
("Gain_Culture", "Intercontinental", 0), 
("Gain_Culture", "YieldType", "YIELD_CULTURE");