修改器的ID，建议用采用单词首字母大写，其余小写的形式，避免与游戏自带的修改器名有冲突。
如果是单位能力修改器，单位能力为：XX_ABILITY，则修改器ID不能为XX_ABILITY_MODIFIER，这样会有唯一性错误，游戏在读取你的文件时会自动以你的单位能力名称XX_ABILITY生成一个修改器XX_ABILITY_MODIFIER，然后再用这个修改器关联你的自定义修改器。
如下是游戏自带的单位能力希腊重装步兵的定义：
首先定义了HOPLITE_NEIGHBOR_COMBAT这个修改器。

```
<Row>
        <ModifierId>HOPLITE_NEIGHBOR_COMBAT</ModifierId>
        <ModifierType>MODIFIER_SINGLE_UNIT_ATTACH_MODIFIER</ModifierType>
        <SubjectRequirementSetId>HOPLITE_PLOT_IS_HOPLITE_REQUIREMENTS</SubjectRequirementSetId>
</Row>
<Row>
		<ModifierId>HOPLITE_NEIGHBOR_COMBAT_MODIFIER</ModifierId>
		<ModifierType>MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH</ModifierType>
</Row>
```
然后将这个修改器关联到一个ID为HOPLITE_NEIGHBOR_COMBAT_MODIFIER的修改器。

```
<Row>
		<ModifierId>HOPLITE_NEIGHBOR_COMBAT</ModifierId>
		<Name>ModifierId</Name>
		<Value>HOPLITE_NEIGHBOR_COMBAT_MODIFIER</Value>
</Row>
```

总结：
建议自定义的修改器的ID采用单词首字母大写，其余小写的形式，且一定不能以_MODIFIER结尾。