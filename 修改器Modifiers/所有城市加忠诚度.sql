
-- 以政策 Policy_Welfare 为例

INSERT INTO PolicyModifiers (PolicyType, ModifierId) VALUES 
("Policy_Welfare", "Modifier_Welfare_Change_Cities_Identity");

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
("Modifier_Welfare_Change_Cities_Identity", "MODIFIER_PLAYER_CITIES_ADJUST_IDENTITY_PER_TURN", 0, 0, 0, NULL, NULL);

INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES 
("Modifier_Welfare_Change_Cities_Identity", "Amount", 10);

