
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES 
("BUILDING_MONUMENT", "GainYieldByTradeRoute");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("GainYieldByTradeRoute", "MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("GainYieldByTradeRoute", "Amount", 1), 
("GainYieldByTradeRoute", "Intercontinental", 1), 
("GainYieldByTradeRoute", "YieldType", "YIELD_PRODUCTION");
