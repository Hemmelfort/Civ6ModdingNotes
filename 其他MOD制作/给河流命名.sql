
-- 仅支持《风云变幻》，而且河流名称是与文明相绑定的。
-- 一条河可以绑多个文明，一个文明可以绑多条河流。

INSERT INTO NamedRivers(NamedRiverType, Name) VALUES
("River_Test", "一条大河");

INSERT INTO NamedRiverCivilizations(NamedRiverType, CivilizationType) VALUES
("River_Test", "CIVILIZATION_FZL");
