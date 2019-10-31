
# 一文搞懂 TraitType (特色)

> Trait: 特性，特色。指的是某个文明专属的东西，包括单位、改良、建筑、区域、能力、议程等等。

以单位为例，弓箭手没有 TraitType，所以谁都可以造；战象有一个属于印度的 TraitType，所以只有印度能造。

## TraitType 的定义 （必需）

以印度战象为例：

### 1. 先定义一个 Trait
```xml
<Types>
    <Row Type="TRAIT_CIVILIZATION_UNIT_INDIAN_VARU" Kind="KIND_TRAIT"/>
</Types>
```

### 2. 再给它取个名字，描述(Description)可以不写

```xml
<Traits>
    <Row TraitType="TRAIT_CIVILIZATION_UNIT_INDIAN_VARU" Name="战象"/>
</Traits>
```

### 3. 将其与文明绑定：

```xml
<CivilizationTraits>
    <Row CivilizationType="CIVILIZATION_INDIA" TraitType="TRAIT_CIVILIZATION_UNIT_INDIAN_VARU"/>
</CivilizationTraits>
```

或者与领袖绑定：
```xml
<LeaderTraits>
    <Row LeaderType="LEADER_GANDHI" TraitType="TRAIT_CIVILIZATION_UNIT_INDIAN_VARU"/>
</LeaderTraits>
```


## TraitType 的使用 （非必需）

在定义单位的 Units 表中可以插入 TraitType:

```xml
<Units>
    <Row
        UnitType="UNIT_INDIAN_VARU"
        ...
        TraitType="TRAIT_CIVILIZATION_UNIT_INDIAN_VARU" />
</Units>
```

同样的道理，改良设施是在 Improvements 表中，建筑在 Buildings 表中，区域在 Districts 表中，等等。


## TraitType 使用修改器 Modifier（非必需）

让它在 TraitModifiers 表中绑定一个 ModifierId。例如秦始皇的“第一帝王” FIRST_EMPEROR_TRAIT 消耗工人加速奇观修建进程：

```xml
<TraitModifiers>
    <Row TraitType="FIRST_EMPEROR_TRAIT" ModifierId="TRAIT_BUILDER_WONDER_PERCENT"/>
</TraitModifiers>
```

或者用sql语言：

```sql
insert into TraitModifiers (TraitType, ModifierId) values
("FIRST_EMPEROR_TRAIT", "TRAIT_BUILDER_WONDER_PERCENT");
```





















