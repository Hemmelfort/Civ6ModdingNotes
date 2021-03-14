
# 文明6 Lua 手册

[toc]

## 前言


本文内容不时会更新，获取最新版本请访问项目地址：

- [Gitee](https://gitee.com/Hemmelfort/Civ6ModdingNotes)
- [Github](https://github.com/Hemmelfort/Civ6ModdingNotes)

> 如果没有特别说明能用于 UI 环境，那本文大部分功能主要用在 Gameplay 环境。



## 玩家 Player

获取本地玩家

```lua
local playerID = Game.GetLocalPlayer()
local pPlayer = Players[playerID]
```

### 常用功能

|       功能       |                            代码                            |  说明  |
| ---------------- | ---------------------------------------------------------- | ------ |
| 设置金币          | `pPlayer:GetTreasury():SetGoldBalance(100)`                |        |
| 加减金币          | `pPlayer:GetTreasury():ChangeGoldBalance(-5)`              |        |
| 根据百分比加减金币 | `pPlayer:GetTreasury():ChangeGoldBalanceByPercentage(10)`  |        |
| 加总督点数        | `pPlayer:GetGovernors():ChangeGovernorPoints(1)`           |        |
| 加外交决议        | `pPlayer:GetDiplomacy():ChangeFavor(10)`                   |        |
| 加外交胜利点数     | `pPlayer:GetStats():ChangeDiplomaticVictoryPoints(1)`      | ❌无效 |
| 加影响力点数      | `pPlayer:GetInfluence():ChangeTokensToGive(1)`             |        |
| 加文化            | `pPlayer:GetCulture():ChangeCurrentCulturalProgress(1000)` | 一次性 |
| 加信仰            | `pPlayer:GetReligion():ChangeFaithBalance(50)`             |        |
| 判断是否是AI      | `pPlayer:IsAI()`                                           |        |
| 判断是否健在      | `pPlayer:IsAlive()`                                        |        |
| 判断是否是人类玩家 | `pPlayer:IsHuman()`                                        |        |
| 判断是否是野蛮人   | `pPlayer:IsBarbarian()`                                    |        |
| 判断是否是主流文明 | `pPlayer:IsMajor()`                                        |        |

TODO:

- CanUnreadyTurn
- ChangeDiplomaticFavor
- ChangeScoringScenario1
- ChangeScoringScenario2
- ChangeScoringScenario3
- GetAgendaTypes
- GetAi_Diplomacy
- GetAi_Military
- GetAi_Religion
- GetCategoryScore
- GetCities
- GetCulture
- GetDiplomacy
- GetDiplomaticAI
- GetDiplomaticFavor
- GetDistricts
- GetEra
- GetEras
- GetFavor
- GetGovernors
- GetGrandStrategicAI
- GetGreatPeoplePoints
- GetID
- GetImprovements
- GetInfluence
- GetInfluenceMap
- GetProperty
- GetReligion
- GetResources
- GetScore
- GetScoringScenario1
- GetScoringScenario2
- GetScoringScenario3
- GetStartingPlot
- GetStats
- GetTeam
- GetTechs
- GetTrade
- GetTreasury
- GetUnits
- GetWMDs
- GrantYield


### 加资源           

```lua
local resourceInfo = GameInfo.Resources["RESOURCE_IRON"];
pPlayer:GetResources():ChangeResourceAmount(resourceInfo.Index, 10);
```

### 加核武器

```lua
local wmd = GameInfo.WMDs['WMD_THERMONUCLEAR_DEVICE']    -- WMD_NUCLEAR_DEVICE
pPlayer:GetWMDs():ChangeWeaponCount(wmd.Index, 1)
```

### 加伟人点数

```lua
local admiral = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ADMIRAL']
player:GetGreatPeoplePoints():ChangePointsTotal(admiral.Index, 5)
```

### 根据名称完成科技

```lua
local playerTechs = pPlayer:GetTechs();
local tech = GameInfo.Technologies["TECH_FLIGHT"];
if (tech ~= nil) then
    -- 方法1，UI进度会实时更新
	-- playerTechs:SetResearchProgress(tech.Index,
	-- playerTechs:GetResearchCost(tech.Index));

    -- 方法2，简单，但UI不会立马显示已获得该技术
	playerTechs:SetTech(tech.Index, true)
end
```


### 完成当前科技

```lua
local playerTechs = pPlayer:GetTechs();

if (playerTechs:GetResearchingTech() ~= -1) then
	playerTechs:ChangeCurrentResearchProgress(playerTechs:GetResearchCost(playerTechs:GetResearchingTech()) - playerTechs:GetResearchProgress());
end
```

### 完成所有科技

```lua
local playerTechs = pPlayer:GetTechs();

for tech in GameInfo.Technologies() do
	playerTechs:SetResearchProgress(tech.Index, playerTechs:GetResearchCost(tech.Index));
end
```

### 完成所有文化

```lua
local playerCulture = player:GetCulture();

if playerCulture ~= nil then
	local ID = 0;
	for civic in GameInfo.Civics() do
		playerCulture:SetCivic(ID, true);
		ID = ID + 1;
	end
end
```


### 判断有没有政策

以“纪律”（POLICY_DISCIPLINE）为例：

```lua
local i = GameInfo.Policies['POLICY_DISCIPLINE'].Index
local a = Players[0]:GetCulture():IsPolicyActive(i)
```


### 根据名字送伟人

```lua
function AddGreatMerchant(iPlayer, szGeneralName)
	local individual = GameInfo.GreatPersonIndividuals[szGeneralName].Hash;
	local class = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_MERCHANT"].Hash;
	local era = GameInfo.Eras["ERA_CLASSICAL"].Hash;
	local cost = 0;
	
	Game.GetGreatPeople():GrantPerson(individual, class, era, cost, iPlayer, false);
end

AddGreatMerchant(playerID, "GREAT_PERSON_INDIVIDUAL_ZHANG_QIAN")
```

### 宣战

判断能否宣战（只能用在 UI 环境）：

```lua
if Players[player1]:GetDiplomacy():CanDeclareWarOn(player2) then
    ExposedMembers.MNS.PerformFighting(player1, player2)
```

正式宣战（只能用于 Gameplay 环境）:

```lua
Players[player1]:GetDiplomacy():DeclareWarOn(player2, WarTypes.FORMAL_WAR, true)
```

### 观察者视角

```lua
-- 该方法用于 **切换** 观察者视角
function GodSight(PlayerID)
    local ObserverID = Game.GetLocalObserver()
    
    if ObserverID == PlayerTypes.OBSERVER then
        PlayerManager.SetLocalObserverTo(PlayerID)    -- 关闭观众视角，将视角设为玩家
    else
        PlayerManager.SetLocalObserverTo(PlayerTypes.OBSERVER)    -- 开启观众视角
    end
end
```

---

## 单位 Unit

### 常用功能

|       功能       |                                  代码                                   |              说明               |
| ---------------- | ----------------------------------------------------------------------- | ------------------------------ |
| 获取单位（方法1）  | `local pUnit = UnitManager.GetUnit(iPlayerID, iUnitID);`                |                                |
| 获取单位（方法2）  | `local pUnit = pPlayer:GetUnits():FindID(iUnitID);`                     |                                |
| 获取剩余移动力     | `pUnit:GetMovesRemaining()`                                             |                                |
| 加移动力          | `pUnit:ChangeExtraMoves(-1)`                                            | 永久，但升级后无效               |
| 加移动力          | `UnitManager.ChangeMovesRemaining(pUnit, 4)`                            | 本回合有效                      |
| 恢复移动力        | `UnitManager.RestoreMovement(pUnit)`                                    | 进入zoc之后无法移动              |
| 恢复移动力        | `UnitManager.RestoreMovementToFormation(pUnit)`                         | 进入zoc之后可以逃离              |
| 恢复攻击次数      | `UnitManager.RestoreUnitAttacks(pUnit)`                                 | 通常也需要同时恢复移动力          |
| 施加伤害          | `pUnit:ChangeDamage(50)`                                                | 相对值，负数反而治疗~            |
| 设置伤害          | `pUnit:SetDamage(50)`                                                   | 非致命                          |
| 受伤值            | `pUnit:GetDamage()`                                                     |                                |
| 剩余攻击次数      | `pUnit:GetAttacksRemaining()`                                           |                                |
| 剩余建造次数      | `pUnit:GetBuildCharges()`                                               |                                |
| 加经验值          | `pUnit:GetExperience():ChangeExperience(10)`                            |                                |
| 组建军团军队      | `pUnit:SetMilitaryFormation(MilitaryFormationTypes.CORPS_FORMATION)`    | 军队：ARMY_FORMATION            |
| 获取位置          | `pUnit:GetLocation()`                                                   | location.x, location.y         |
| 是否在船上        | `pUnit:IsEmbarked()`                                                    |                                |
| 获取单位显示名称   | `pUnit:GetName()`                                                       | 返回 "LOC_UNIT_SCOUT_NAME" 这种 |
| 获取所属玩家      | `pUnit:GetOwner()`                                                      | 返回 playerID                   |
| 获取单位ID        | `pUnit:GetID()`                                                         |                                |
| 获取所在位置      | `pUnit:GetX()` 和 `pUnit:GetY()`                                        |                                |
| 获取升级所需花费   | `pUnit:GetUpgradeCost()`                                                | 无升级则为0                     |
| 是否能忽略zoc     | `pUnit:IgnoresZOC()`                                                    |                                |
|                  | `UnitManager.GetOwnerName`                                              | ❌无效                         |
| 弄死单位          | `UnitManager.Kill(pUnit)`                                               | 第二个参数见注释【1】            |
| 移动单位          | `UnitManager.MoveUnit(pUnit, iX, iY)`                                   | 需要有剩余移动力、判断能否上船    |
| 放置（移动）单位   | `UnitManager.PlaceUnit(pUnit, iX, iY)`                                  | 无需移动力，要判断能否上船        |
| 放置（创造）新单位 | `UnitManager.InitUnitValidAdjacentHex(playerID, "UNIT_XX", x, y, iNum)` |                                |
| 放置（创造）新单位 | `pPlayer:GetUnits():Create(GameInfo.Units['UNIT_XX'].Index, x, y)`      |                                |

【1】true：单位被标记为死亡状态，并被暂时移到了 (-9999, -9999)，用 `pUnit:IsDelayedDeath()` 方法判断为 true，本回合过去后则永久删除。默认为 false，立即删除。

### 获取单位类型需要注意的事情

|                    方法                    |              效果               |
| ------------------------------------------ | ------------------------------ |
| `pUnit:GetType()`                          | 返回一个数字（即Index）          |
| `pUnit.TypeName()`                         | 返回的是 "Unit"                 |
| `pUnit.GetUnitType()`                      | ❗ 只用于 UI 环境，返回 Index      |
| `UnitManager.GetTypeName()`                | 返回 "LOC_UNIT_SCOUT_NAME" 这种 |
| `GameInfo.Units[pUnit:GetType()].UnitType` | ✔ 返回"UNIT_BUILDER"这种        |


### 单位的遍历

```lua
function FindPossibleUnits( playerId )
	local pPlayer = Players[playerId];
	local playerUnits = pPlayer:GetUnits();
	for i, unit in playerUnits:Members() do
		local unitInfo = GameInfo.Units[unit:GetType()];
		if (unitInfo) then
			local unitTypeName = unitInfo.UnitType;

			if unitTypeName == "UNIT_TRADER" then
                print("Do your things here.")
			end
		end
	end
end
```

### 设置升级项

```lua
local promotion = GameInfo.UnitPromotions["PROMOTION_ALPINE"];
pUnit:GetExperience():SetPromotion(promotion)
```

### 加经验值直到升级

```lua
local exps = pUnit:GetExperience():GetExperienceForNextLevel()
pUnit:GetExperience():ChangeExperience(exps);
```

### 添加能力(待测试)

```lua
pUnit:GetAbility():ChangeAbilityCount("ABILITY_XXX", 1)
pUnit:GetAbility():ChangeAbilityCount("ABILITY_XXX", -1)
```

### 禁止造某单位
```lua
local m_ePlagueDoctorUnit : number = GameInfo.Units["UNIT_PLAGUE_DOCTOR"].Index;
pPlayer:GetUnits():SetBuildDisabled(m_ePlagueDoctorUnit, true)
```

### 允许用信仰购买单位

```lua
pCity:SetUnitFaithPurchaseEnabled(iUnitIndex, true)
```

### 适用于 UI 环境的功能

#### 单位操作（Operation）

位于 `UnitOperationTypes` 表中的内容：

```lua
['AIR_ATTACK', 'BUILD_IMPROVEMENT', 'BUILD_IMPROVEMENT_ADJACENT','COASTAL_RAID',
'DEPLOY', 'FORTIFY', 'FOUND_CITY', 'MAKE_TRADE_ROUTE', 'MOVE_TO',
'PARAM_FLAGS', 'PARAM_IMPROVEMENT_TYPE', 'PARAM_MODIFIERS', 'PARAM_OPERATION_TYPE', 'PARAM_WMD_TYPE', 'PARAM_X', 'PARAM_X0', 'PARAM_X1', 'PARAM_Y', 'PARAM_Y0', 'PARAM_Y1',
'RANGE_ATTACK', 'REBASE',
'SPY_COUNTERSPY', 'SPY_GAIN_SOURCES', 'SPY_GREAT_WORK_HEIST', 'SPY_LISTENING_POST', 'SPY_SIPHON_FUNDS', 'SPY_STEAL_TECH_BOOST', 'SPY_TRAVEL_NEW_CITY',
'SWAP_UNITS', 'TYPE', 'WMD_STRIKE']
```

注：数据库 UnitOperations 表中的操作似乎与这些指令并不相同。

##### 判断指令

```
UnitManager.CanStartOperation(pUnit, UnitOperationTypes.MOVE_TO)
```

##### 驻扎

```
UnitManager.RequestOperation(pUnit, UnitOperationTypes.FORTIFY)
```

##### 发核弹

```lua
function WMDStrike( plot, unit, eWMD )
	local tParameters = {};
	tParameters[UnitOperationTypes.PARAM_X] = plot:GetX();
	tParameters[UnitOperationTypes.PARAM_Y] = plot:GetY();
	tParameters[UnitOperationTypes.PARAM_WMD_TYPE] = eWMD;
	if (UnitManager.CanStartOperation( unit, UnitOperationTypes.WMD_STRIKE, nil, tParameters)) then
		UnitManager.RequestOperation( unit, UnitOperationTypes.WMD_STRIKE, tParameters);
	end
end
```

#### 单位命令（Command）

`UnitCommandTypes` 表中的内容：

```lua
['AIRLIFT', 'CANCEL', 'CONDEMN_HERETIC', 'DELETE',
'ENTER_FORMATION', 'EXECUTE_SCRIPT', 'FORM_ARMY', 'FORM_CORPS',
'MOVE_JUMP', 'NAME_UNIT', 'PARADROP',
'PARAM_NAME', 'PARAM_PROMOTION_TYPE', 'PARAM_UNIT_ID', 'PARAM_UNIT_PLAYER', 'PARAM_X', 'PARAM_Y',
'PRIORITY_TARGET', 'PROMOTE', 'TYPE', 'UPGRADE']
```

##### 组建军团/军队

```lua
local tParameters :table = {};
tParameters[UnitCommandTypes.PARAM_UNIT_PLAYER] = pUnit:GetOwner();
tParameters[UnitCommandTypes.PARAM_UNIT_ID] = pUnit:GetID();
if (UnitManager.CanStartCommand( pSelectedUnit, UnitCommandTypes.FORM_CORPS, tParameters)) then
	UnitManager.RequestCommand( pSelectedUnit, UnitCommandTypes.FORM_CORPS, tParameters);
end
```

##### 单位晋升

```lua
local tParameters = {};
tParameters[UnitCommandTypes.PARAM_PROMOTION_TYPE] = ePromotion;
UnitManager.RequestCommand( pUnit, UnitCommandTypes.PROMOTE, tParameters );
```







---

## 城市 City

### 常用功能



|           功能            |                              代码                              |              说明               |
| ------------------------- | ------------------------------------------------------------- | ------------------------------- |
| 获取城市（根据ID）          | `local pCity = CityManager.GetCity(playerID, cityId)`         |                                 |
| 获取城市（根据坐标）        | `local pCity = CityManager.GetCityAt(iX, iY)`                 | 必须是市中心坐标                 |
| 获取城市（根据格位）        | `local pCity = Cities.GetCityInPlot(iPlotIndex)`              | Cities和下面的GetCities不一样    |
| 创建城市                   | `pPlayer:GetCities():Create(iX, iY)`                          | 有最小城市距离限制                |
| 改变忠诚度                 | `pCity:ChangeLoyalty(100)`                                    |                                 |
| 改变人口                   | `pCity:ChangePopulation(1)`                                   |                                 |
| 获取城市位置               | ` pCity:GetX()` 和 `pCity:GetY()`                              |                                 |
| 获取人口                   | `pCity:GetPopulation()`                                       |                                 |
| 获取拥有者                 | `pCity:GetOwner()`                                            | 返回 iPlayerID                  |
| 获取原始拥有者             | `pCity:GetOriginalOwner()`                                    |                                 |
| 获取城市名                 | `pCity:GetName()`                                             |                                 |
| 设置城市名                 | `pCity:SetName("hehe")`                                       |                                 |
| 绑定修改器                 | `pCity:AttachModifierByID(ModifierId)`                        |                                 |
| 设置可以用信仰购买建筑      | `pCity:SetBuildingFaithPurchaseEnabled(building.Index, true)` | 本城有效                        |
| 设置可以用信仰购买单位      | `pCity:SetUnitFaithPurchaseEnabled(unit.Index, true)`         | 本城有效                        |
| 设为首都                   | `CityManager.SetAsCapital(pCity)`                             |                                 |
| 设为原始首都               | `CityManager.SetAsOriginalCapital(pCity)`                     |                                 |
| 设为自由城市               | `CityManager.TransferCityToFreeCities(pCity)`                 |                                 |
| 移除城市                   | `CityManager.DestroyCity(pCity)`                              |                                 |
| 移除城市                   | `Cities.DestroyCity(pCity)`                                   |                                 |
| **城市成长**              |                                                               |                                 |
| 获取住房数量               | `pCity:GetGrowth():GetHousing()`                              |                                 |
| 获取到下一次人口增长的回合数 | `pCity:GetGrowth():GetTurnsUntilGrowth()`                     |                                 |
| 获取幸福度                 | `pCity:GetGrowth():GetHappiness()`                            |                                 |
| 获取食物剩余               | `pCity:GetGrowth():GetFoodSurplus()`                          |                                 |
| 获取宜居度                 | `pCity:GetGrowth():GetAmenities()`                            | ❓待验证                         |
| **建造队列**              |                                                               |                                 |
| 加生产进度                 | `pCity:GetBuildQueue():AddProgress(iAmount)`                  | 参数似乎是锤子数                 |
| 完成当前建造               | `pCity:GetBuildQueue():FinishProgress()`                      |                                 |
| 获取区域花费               | `pCity:GetBuildQueue():GetDistrictCost(district.Index)`       |                                 |
| 创建区域                   | `pCity:GetBuildQueue():CreateDistrict(district.Index, iPlot)` |                                 |
| 创建建筑                   | `pCity:GetBuildQueue():CreateBuilding(building.Index)`        |                                 |
| 获得当前建造任务            | `pCity:GetBuildQueue():CurrentlyBuilding()`                   | 返回值：如 "BUILDING_MONUMENT"   |
| **建筑**                  |                                                               |                                 |
| 是否有该建筑               | `pCity:GetBuildings():HasBuilding(iIndex)`                    |                                 |
| 获取建筑位置               | `pCity:GetBuildings():GetBuildingLocation(iIndex)`            | 返回值：iPlotIndex （和区域不同） |
| 设置建筑被掠夺             | `pCity:GetBuildings():SetPillaged(building.Index, true)`      |                                 |
| 判断建筑是否被掠夺          | `pCity:GetBuildings():IsPillaged("BUILDING_XX")`              | 参数也可以是 building.Index     |
| 移除建筑                   | `pCity:GetBuildings():RemoveBuilding(building.Index)`         |                                 |
| **区域**                  |                                                               |                                 |
| 获取区域位置               | `pCity:GetDistricts():GetDistrictLocation(district.Index)`    | 返回值：(iX, iY)                |
| 判断是否有该区域            | `pCity:GetDistricts():HasDistrict(district.Index)`            |                                 |
| 判断该区域是否被掠夺        | `pCity:GetDistricts():IsPillaged()`                           |                                 |
| 设置该区域为被掠夺          | `pCity:GetDistricts():SetPillaged(true)`                      |                                 |
| 移除区域                   | `pCity:GetDistricts():RemoveDistrict(district.Index)`         |                                 |



### 计算距离最近的城市

```lua
function GetNearestCity(PlotX, PlotY, PlayerID)
    local dist = 9999
    local city = nil
    local pPlayerCities = Players[PlayerID]:GetCities()
    
    for i, pCity in pPlayerCities:Members() do
        local iDistance = Map.GetPlotDistance(PlotX, PlotY, pCity:GetX(), pCity:GetY())
        
        if (iDistance < dist) then
            dist = iDistance
            city = pCity
        end
    end
    
    return city or pPlayerCities:GetCapitalCity()
end
```

### 创建区域（WorldBuilder方式）

比如要在 (15,13) 的位置建造一座学院：

```lua
local index = GameInfo.Districts["DISTRICT_CAMPUS"].Index
local iPlot = Map.GetPlotIndex(15, 13)
WorldBuilder.CityManager():CreateDistrict(pCity, index, 100, iPlot)    -- 100是完成度
```

### 获取区域信息

比如要查询某座城市里面圣地 DISTRICT_HOLY_SITE 的位置：

```lua
local index = GameInfo.Districts['DISTRICT_HOLY_SITE'].Index
local pDistrict = pCity:GetDistricts():GetDistrict(index)
if (pDistrict ~= nil) then
	local x = pDistrict:GetX();
	local y = pDistrict:GetY();
end
```



### 允许用信仰购买建筑

```lua
pCity:SetBuildingFaithPurchaseEnabled(iBuildingIndex, true)
```

### UI 环境

#### 摧毁城市

毁灭城市的选项：

- CityDestroyDirectives.LIBERATE_FOUNDER
- CityDestroyDirectives.LIBERATE_PREVIOUS_OWNER
- CityDestroyDirectives.KEEP
- CityDestroyDirectives.RAZE
- CityDestroyDirectives.REJECT (DLC1)

```lua
local tParameters = {};
tParameters[UnitOperationTypes.PARAM_FLAGS] = CityDestroyDirectives.RAZE;
if (CityManager.CanStartCommand( g_pSelectedCity, CityCommandTypes.DESTROY, tParameters)) then
	CityManager.RequestCommand( g_pSelectedCity, CityCommandTypes.DESTROY, tParameters);
end
```

#### 推荐建造

```lua
local m_kRecommendedItems = {}

for _,kItem in ipairs(pCity:GetCityAI():GetBuildRecommendations()) do
	m_kRecommendedItems[kItem.BuildItemHash] = kItem.BuildItemScore;
end
```

结果：

```
InGame: 1967074475	1535
InGame: -1188273497	1345
InGame: -754251518	1235
```

---

## 格位与地图

- 注意区分

|       变量名        |     含义      |
| ------------------ | ------------ |
| pPlot              | 格位对象      |
| iPlot / iPlotIndex | 格位序号或序数 |
| iX, iY             | 格位坐标      |



### 常用功能

|     转换     |               代码                |   返回值    |
| ----------- | --------------------------------- | ---------- |
| 坐标 -> 序号 | `Map.GetPlotIndex(iX, iY)`        | iPlotIndex |
| 坐标 -> 格位 | `Map.GetPlot(iX, iY)`             | pPlot      |
| 序号 -> 格位 | `Map.GetPlotByIndex(iPlotIndex)`  | pPlot      |
| 序号 -> 坐标 | `Map.GetPlotLocation(iPlotIndex)` | (iX, iY)   |
| 格位 -> 坐标 | `pPlot:GetX(), pPlot:GetY()`        | (iX, iY)   |
| 格位 -> 序号 | `pPlot:GetIndex()`                  | iPlotIndex |


### Plot

- 获取格位信息

|        功能        |                 代码                 |         说明         |
| ------------------ | ------------------------------------ | -------------------- |
| 防御力附加值        | `pPlot:GetDefenseModifier()`         |                      |
| 地块产出            | `pPlot:GetYield(yield.Index) -> int` |                      |
| 区域ID             | `pPlot:GetDistrictID()`              |                      |
| 区域类型（数字）     | `pPlot:GetDistrictType()`            | 返回Index            |
| 地貌               | `pPlot:GetFeature()`                 |                      |
| 地貌类型            | `pPlot:GetFeatureType()`             | 返回Index            |
| 改良设施所有者      | `pPlot:GetImprovementOwner()`        |                      |
| 改良设施类型（数字） | `pPlot:GetImprovementType()`         | 返回Index            |
| 移动力消耗          | `pPlot:GetMovementCost()`            |                      |
| 国家公园名字        | `pPlot:GetNationalParkName()`        | 没有则返回空字符串''   |
|                    | `pPlot:GetNearestLandArea()`         | ❓Area是啥，待深入测试 |
| 最近的陆地单元格     | `pPlot:GetNearestLandPlot()`         | 返回pPlot，可以是自己  |
| 所有者             | `pPlot:GetOwner()`                   |                      |
| 地形类型（数字）     | `pPlot:GetTerrainType()`             | 返回Index            |
| 单位数量            | `pPlot:GetUnitCount()`               |                      |

> 地貌方向：
> pFeature:GetDirection()

### 格位判断

|      功能       |                           代码                            |           说明           |
| -------------- | --------------------------------------------------------- | ----------------------- |
| 能否建区域      | `pPlot:CanHaveDistrict(district.Index, playerID, cityID)` |                         |
| 能否建奇观      | `pPlot:CanHaveWonder(building.Index, playerID, cityID)`   |                         |
| 靠近主人        | `pPlot:IsAdjacentOwned()`                                 | ❓有何意义               |
| 靠近玩家        | `pPlot:IsAdjacentPlayer(playerID)`                        |                         |
|                | `pPlot:IsAdjacentToArea()`                                |                         |
| 靠近陆地        | `pPlot:IsAdjacentToLand()`                                |                         |
| 靠近浅水格位     | `pPlot:IsAdjacentToShallowWater()`                        |                         |
| 是峡谷          | `pPlot:IsCanyon()`                                        |                         |
| 是阻塞点        | `pPlot:IsChokepoint()`                                    | ❓未知                   |
| 是城市          | `pPlot:IsCity()`                                          | 且市中心                 |
| 是海岸陆地      | `pPlot:IsCoastalLand()`                                   |                         |
| 是平地          | `pPlot:IsFlatlands()`                                     | 陆地平原、草原，不能有树林 |
| 有淡水          | `pPlot:IsFreshWater()`                                    | 靠近河流、湖泊            |
| 是丘陵          | `pPlot:IsHills()`                                         | 非山脉                   |
| 是否可以通行     | `pPlot:IsImpassable()`                                    |                         |
| 被掠夺的改良设施 | `pPlot:IsImprovementPillaged()`                           |                         |
|                | `pPlot:IsInternalOnlyDistrict()`                          | ❓未知                   |
| 是湖泊          | `pPlot:IsLake()`                                          |                         |
| 是山脉          | `pPlot:IsMountain()`                                      |                         |
| 是国家公园      | `pPlot:IsNationalPark()`                                  |                         |
| 是自然奇观      | `pPlot:IsNaturalWonder()`                                 |                         |
| 是开阔地带      | `pPlot:IsOpenGround()`                                    | 非丘陵，可以有树林        |
| 是崎岖的地方     | `pPlot:IsRoughGround()`                                   | 非丘陵，非树林            |
| 是否拥有        | `pPlot:IsOwned()`                                         | 相对于本地玩家？          |
| 有河流          | `pPlot:IsRiver()`                                         |                         |
| 靠近河流        | `pPlot:IsRiverAdjacent()`                                 | ❓和IsRiver有什么区别     |
| 有路            | `pPlot:IsRoute()`                                         |                         |
| 有被掠夺的路     | `pPlot:IsRoutePillaged()`                                 |                         |
|                | `pPlot:IsStartingPlot()`                                  | ❓未知                   |
|                | `pPlot:IsValidFoundLocation()`                            | ❓未知                   |
| 是水域          | `pPlot:IsWater()`                                         | 湖泊和海洋，非河流        |
| 是否有单位      | `pPlot:IsUnit()`                                          |                         |


- 判断河流与悬崖的方位

|   功能    |         代码          |
| --------- | --------------------- |
| 悬崖东北方 | `pPlot:IsNEOfCliff()` |
| 河流东北方 | `pPlot:IsNEOfRiver()` |
| 悬崖西北方 | `pPlot:IsNWOfCliff()` |
| 河流西北方 | `pPlot:IsNWOfRiver()` |
| 悬崖正西方 | `pPlot:IsWOfCliff()`  |
| 河流正西方 | `pPlot:IsWOfRiver()`  |


### Map

|         功能         |                         代码                          |                    说明                    |
| -------------------- | ----------------------------------------------------- | ------------------------------------------ |
| 获取两个坐标的距离     | `Map.GetPlotDistance(x1, y1, x2, y2)`                 | 距离包含首尾格位在内                         |
|                      | `Map.GetPlotXY(iX, iY, dx, dy, iRange)`               | ❓未知，返回一个pPlot                        |
|                      | `Map.GetPlotXYWithRangeCheck(iX, iY, dx, dy, iRange)` | ❓未知，返回一个pPlot                        |
| 获取相邻格位          | `Map.GetAdjacentPlot(iX, iY, iDirection)`             | 【1】iDirection为0~5，返回一个pPlot          |
| 获取相邻全部格位      | `Map.GetAdjacentPlots(iX, iY)`                        |                                            |
|                      | `Map.GetCityPlots(pCity)`                             | ❓不适用于Gameplay环境？                     |
|                      | `Map.GetContinentCoastalPlots()`                      | ❓游戏会强退？😧                            |
| 获取该洲所有格位      | `Map.GetContinentPlots(eContinent)`                   | 参数:Type或Index? 返回:含有iPlotIndex的table |
| 所有格位按魅力分组     | `Map.GetContinentPlotsAppeal()`                       | 【2】                                       |
| 所有格位根据水资源分组 | `Map.GetContinentPlotsWaterAvailability()`            | 【3】                                       |
| 获取所有在用的大洲     | `Map.GetContinentsInUse()`                            | 返回含有iContinentIndex的table              |
| 获取地图大小（格数）   | `Map.GetGridSize()`                                   | 返回(iW, iH)                                |
| 获取格位总数          | `Map.GetPlotCount()`                                  |                                            |
| 获取陆地格位数量      | `Map.GetLandPlotCount()`                              |                                            |
| 获取陆地资源数量      | `Map.GetLandResourceCount(iResourceIndex)`            |                                            |
| 获取地图大小（类型）   | `Map.GetMapSize()`                                    | 返回MapSize的Index，如“小”是2                |
| 获取地图最大格位距离   | `Map.GetMaxPlotDistance()`                            | ❓未知，(74,46)->59                         |
| 获取资源数量          | `Map.GetResourceCount(iResourceIndex)`                |                                            |
|                      | `Map.GetVisibleContinentPlots()`                      | ❌无效                                     |



【1】 以 (35, 14) 为参考点，iDirection 不同取值的方向变化：

| iDirection | 返回坐标 | 所在方位 |                枚举                |
| :--------: | :-----: | :-----: | ---------------------------------- |
|     0      | 35, 15  |    ↗    | DirectionTypes.DIRECTION_NORTHEAST |
|     1      | 36, 14  |    →    | DirectionTypes.DIRECTION_EAST      |
|     2      | 35, 13  |   ↘    | DirectionTypes.DIRECTION_SOUTHEAST |
|     3      | 34, 13  |   ↙    | DirectionTypes.DIRECTION_SOUTHWEST |
|     4      | 34, 14  |    ←    | DirectionTypes.DIRECTION_WEST      |
|     5      | 34, 15  |   ↖    | DirectionTypes.DIRECTION_NORTHWEST |

总结：从12点钟开始，顺时针方向转

【2】  BreathtakingPlots, CharmingPlots, AveragePlots, UninvitingPlots, DisgustingPlots = Map.GetContinentPlotsAppeal();  
【3】 FullWaterPlots, CoastalWaterPlots, NoWaterPlots, NoSettlePlots = Map.GetContinentPlotsWaterAvailability();

### 获取格位上的单位

```lua
for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
	if(unit ~= nil) then
		if unit then
            -- do your things here.
		end
	end
end
```

### 获取相邻全部格位

```lua
local tNeighborPlots = Map.GetAdjacentPlots(iX, iY);
for _, pNeighborPlot in ipairs(tNeighborPlots) do
	if (not pNeighborPlot:IsWater() and not pNeighborPlot:IsMountain()) then
		print(pNeighborPlot:GetIndex());
	end
end
```

### 获取附近范围内的全部格位

获得的格位中包含本格在内。

```lua
local plots = Map.GetNeighborPlots(iX, iY, iRange)
for i, adjPlot in ipairs(plots) do
	print(i, adjPlot:GetIndex())
end
```


### 改变地形与地貌

关于 TerrainBuilder 的更多方法：<a href="#TerrainBuilder">点我跳转</a>

```lua
TerrainBuilder.CanHaveFeature(pPlot, iFeatureType)
TerrainBuilder.GetAdjacentFeatureCount(pPlot, iFeatureType)
TerrainBuilder.SetFeatureType(pPlot, iFeatureType)
TerrainBuilder.SetTerrainType(pPlot, iTerrainType)
```


### 添加改良设施

```lua
ImprovementBuilder.CanHaveImprovement(pPlot, iImprovement, -1) -- 为什么是-1才行？
ImprovementBuilder.SetImprovementType(pPlot, iImprovement, iPlayerID)
```

注：若 `iImprovement` 为 -1 则移除改良。

### 添加或移除资源

```lua
ResourceBuilder.SetResourceType(pPlot, eType, 1);  --添加资源（最后的1为资源的数量）
ResourceBuilder.SetResourceType(pPlot, -1);        --移除资源
```

### 格位所有者变更

```lua
WorldBuilder.CityManager():SetPlotOwner(pPlot, pCity)
```

### 获取大陆格位

```lua
local tContinents = Map.GetContinentsInUse()

for i, eContinent in ipairs(tContinents) do
    local tContinentPlots = Map.GetContinentPlots(eContinent)   -- tContinentPlots 存放的是 iPlotIndex

    for _, plot in ipairs(tContinentPlots) do
        local pPlot = Map.GetPlotByIndex(plot)
        -- use pPlot here
```


### 获取本城所有格位

注意：Map.GetCityPlots() 只在 UI 环境下生效。

```lua
local pCityPlots = Map.GetCityPlots():GetPurchasedPlots( pCity )
for _, iPlotIndex in pairs(pCityPlots) do
	print(_, iPlotIndex)
end
```

### 设置格位可见度

清除格位上的战争迷雾，让本地玩家能看得到。

```lua
local pCurPlayerVisibility = PlayersVisibility[pPlayer:GetID()];
if(pCurPlayerVisibility ~= nil) then
    -- 设为1表示设为可见，0为不可见
    pCurPlayerVisibility:ChangeVisibilityCount(iPlotIndex, 1);
end
```

判断格位 pPlot 是否可见的方法：

```lua
pCurPlayerVisibility:IsRevealed(pPlot:GetX(), pPlot:GetY())
```

设置全图可见（相当于命令行输入 `reveal all`）：

```lua
for iPlotIndex = 0, Map.GetPlotCount()-1, 1 do
    pCurPlayerVisibility:ChangeVisibilityCount(iPlotIndex, 1);
end
```

> TODO: 还有个表是 PlayerVisibilityManager 专门负责这一块的，值得深入研究。

### 添加人造奇观

```lua
local pPlot = Map.GetPlot(8, 18)
local pCity = CityManager.GetCityAt(9, 18)
WorldBuilder.CityManager():CreateBuilding(pCity,
 'BUILDING_STONEHENGE',    -- 奇观名
 100,                      -- 修建的进度
 pPlot:GetIndex());        -- 修建的位置
```

---
## 其他

### Game

|     功能      |                                代码                                |            |
| ------------ | ----------------------------------------------------------------- | ---------- |
| 解锁成就      | `Game.UnlockAchievement(pUnit:GetOwner(), "DLC3_ACHIEVEMENT_10")` |            |
| 加核辐射      | `Game.GetFalloutManager():AddFallout(iPlotIndex, iTurns)`         |            |
| 移除核辐射     | `Game.GetFalloutManager():RemoveFallout(iPlotIndex)`              |            |
| 设置当前回合数 | `Game.SetCurrentGameTurn(499)`                                    |            |
| 头顶文本      | `Game.AddWorldViewText(0, "hehe", 15, 9)`                         | 见注释【1】 |
|              | `Game.GetGameDiplomacy()`                                         | ❗待深入     |
| 获取本地观察者 | `Game.GetLocalObserver()`                                         |            |
| 获取本地玩家   | `Game.GetLocalPlayer()`                                           |            |
|              | `Game.GetPhaseName()`                                             | ❓未知      |
| 获取全部玩家   | `Game.GetPlayers()`                                               | 见注释【2】 |
| 获取当前时代   | `Game.GetEras():GetCurrentEra()`                                  | 返回Index  |
| 加时代分      | `Game.GetEras():ChangePlayerEraScore(iPlayerID, 1)`               |            |
| 获取当前回合数 | `Game.GetCurrentGameTurn()`                                       |            |
| 存储数据？     | `Game:SetProperty('abc', '666')`                                  |            |
| 获取存储的数据 | `Game:GetProperty('abc')`                                         |            |



【1】 第一个参数（好像效果没区别）：
* EventSubTypes.DAMAGE
* EventSubTypes.PLOT
* EventSubTypes.FOUND_CITY

最后似乎还有一个未知参数待确认。

【2】 包含城邦、自由城市、野蛮人在内。返回一个列表，其中每一项都是 pPlayer。

其他：

- Game.GetBarbarianManager()
- Game.GetComponentID()
- Game.GetCurrentGameTurn()
- Game.GetCurrentTurnPhase()
- Game.GetCurrentTurnPhaseName()
- Game.GetCurrentTurnSegment()
- Game.GetCurrentTurnSegmentName()
- Game.GetDefeatRequirements()
- Game.GetEras()
- Game.GetFalloutManager()
- Game.GetGameDiplomacy()
- Game.GetGreatPeople()
- Game.GetLocalObserver()
- Game.GetLocalPlayer()
- Game.GetObjectFromComponentID()
- Game.GetPhaseName()
- Game.GetPlayers()
- Game.GetProperties()
- Game.GetProperty()
- Game.GetQuestsManager()
- Game.GetRandNum()
- Game.GetRandomSeed()
- Game.GetReligion()
- Game.GetTradeManager()
- Game.GetVictoryProgressForTeam()
- Game.GetVictoryRequirements()
- Game.GetWinningTeam()
- Game.IsAllowStrategicCommands()
- Game.IsAllowTacticalCommands()
- Game.IsDefeatEnabled()
- Game.IsVictoryEnabled()
- Game.ObserverCanSeePlayer()
- Game.RetirePlayer()
- Game.SetCurrentGameTurn()
- Game.SetProperty()
- Game.SetRandomSeed()
- Game.SetWinningTeam()
- Game.UnlockAchievement()
- Game.WriteHistoryLog()



### 随机事件（自然灾害）

- GameRandomEvents.ApplyEvent() （不适用于 UI 环境）
- GameRandomEvents.GetEventForTurn()
- GameRandomEvents.GetCurrentTurnEvent()
- GameRandomEvents.GetCurrentAffectedCities()

```lua
function DoRandomEvent()
    local kEvent = {};
    kEvent.EventType = 13;    -- 13 表示 RANDOM_EVENT_TORNADO_FAMILY
    kEvent.NamedRiver = -1;
    kEvent.NamedVolcano = -1;
    -- 以上三项分别为事件类型、河流、火山的序号（即 index）

    local kEventDef = GameInfo.RandomEvents[kEvent.EventType];
    if kEventDef ~= nil then
        -- 乞力马扎罗山和维苏威火山
        if kEventDef.NaturalWonder ~= nil and kEventDef.NaturalWonder ~= "" then
            kEvent.FeatureType = kEventDef.NaturalWonder;
        end

         -- 核电站事故
         -- (EffectOperatorType: STORM, VOLCANO, DROUGHT, etc.)
        if kEventDef.EffectOperatorType == "NUCLEAR_ACCIDENT" then
            if g_Selected.ReactorIndex ~= nil then
                local reactor = Game.GetFalloutManager():GetReactorByIndex(g_Selected.ReactorIndex - 1);
                if reactor ~= nil then
                    kEvent.Location = reactor.PlotIndex;
                end
            end
        end
    end

    GameRandomEvents.ApplyEvent(kEvent)
end
```


### 建立商路（仅 UI 环境）

#### 从商人身上获取商路信息

```lua
local trade:table = m_selectedUnit:GetTrade();
local prevOriginComponentID:table = trade:GetLastOriginTradeCityComponentID();
local prevDestComponentID:table = trade:GetLastDestinationTradeCityComponentID();
```

其中 `ComponentID` 的属性：

```lua
if originCity:GetID() == prevOriginComponentID.id
and originCity:GetOwner() == prevOriginComponentID.player then
```

#### 从城市获取商路

```lua
local owningPlayer:table = Players[pUnit:GetOwner()];
local cities:table = owningPlayer:GetCities();
for _, city in cities:Members() do
	local outgoingRoutes:table = city:GetTrade():GetOutgoingRoutes();
	for i,route in ipairs(outgoingRoutes) do
		if unitID == route.TraderUnitID then
			-- Find origin city
			local originCity:table = cities:FindID(route.OriginCityID);

			-- Find destination city
			local destinationPlayer:table = Players[route.DestinationCityPlayer];
			local destinationCities:table = destinationPlayer:GetCities();
			local destinationCity:table = destinationCities:FindID(route.DestinationCityID);
```

其中 `route` 的属性：

```lua
route.OriginCityID
route.OriginCityPlayer
route.DestinationCityPlayer
route.DestinationCityID
route.TraderUnitID
route.OriginYields
```


#### 给单位建立商路

```lua
local destinationCity = GetDestinationCity();
if destinationCity and m_selectedUnit then
	local operationParams = {};
	operationParams[UnitOperationTypes.PARAM_X0] = destinationCity:GetX();
	operationParams[UnitOperationTypes.PARAM_Y0] = destinationCity:GetY();
	operationParams[UnitOperationTypes.PARAM_X1] = m_selectedUnit:GetX();
	operationParams[UnitOperationTypes.PARAM_Y1] = m_selectedUnit:GetY();
	if (UnitManager.CanStartOperation(m_selectedUnit, UnitOperationTypes.MAKE_TRADE_ROUTE, nil, operationParams)) then
		UnitManager.RequestOperation(m_selectedUnit, UnitOperationTypes.MAKE_TRADE_ROUTE, operationParams);
		--UI.SetInterfaceMode(InterfaceModeTypes.SELECTION);
        --UI.PlaySound("START_TRADE_ROUTE");
	end
end
```

#### TradeManager

```lua
local tradeManager = Game.GetTradeManager();

-- 判断能否建立商路
tradeManager:CanStartRoute(originCity:GetOwner(), originCity:GetID(), destinationCity:GetOwner(), destinationCity:GetID())

-- 获取商路
local pathPlots:table = {};
pathPlots, portalEntrances, portalExits = tradeManager:GetTradeRoutePath(m_originCityOwner, m_originCityID, cityOwner, cityID );
```




### Lua 与 Modifier 互动

首先在数据库中创建一个 `ModifierId`，然后在 lua 中绑定：

```
pPlayer:AttachModifierByID(ModifierId)
pCity:AttachModifierByID(ModifierId)
```


### 野蛮人管理器

#### 获取野蛮人管理器
```lua
local pBarbManager = Game.GetBarbarianManager()
```

#### 待验证
```lua
-- 用法未知
pBarbManager:CreateSpecificTribe()
```

#### 创建蛮族营地

```lua
pBarbManager:CreateTribeOfType(iBarb, iPlotIndex)
```

第一个数字可能是不同蛮族阵营的编号，用于指挥它们攻击不同的城市。该方法来自 DLC *雅德维加的遗产*。

#### 根据升级类型召唤单位

```lua
-- 参数：
-- 1. iTribeNumber: 蛮族部落编号
-- 2. sPromClassType: 单位类型，如 "CLASS_MELEE", "CLASS_RANGED" 等等
-- 3. iAmount: 单位数量
-- 4. iPlotIndex: 格位序号
-- 5. iRange: 范围（待验证）
pBarbManager:CreateTribeUnits(iTribeNumber, sPromClassType, iAmount, iPlotIndex, iRange)
```

#### 野蛮人行动指导方针

```lua
-- 参数：
-- 1. iTribeNumber: 蛮族部落编号
-- 2. 行动类型，如 "Barbarian Attack"
-- 3. eGdansk: 目标城市编号
-- 4. cityID: 目标城市ID
-- （注：“编号”与ID不同）
pBarbManager:StartOperationWithCityTarget(iTribeNumber, "Barbarian City Assault", eGdansk, cityID)
```


### 带参数的文本

1. 在 lua 脚本中：

```lua
local szEffectText = Locale.Lookup("LOC_SCENARIO_AUSTRALIA_EVENT_DANGER_EFFECT_5", pUnit:GetName(), pCity:GetName());
```

2. 在 xml 文本定义时：

```xml
    <Replace Tag="LOC_SCENARIO_AUSTRALIA_EVENT_DANGER_EFFECT_5" Language="zh_Hans_CN">
        <Text>您的{1_UnitName}已返回最近的城市{2_CityName}。</Text>
    </Replace>
```

>  判断有没有对应的文本：Locale.HasTextKey('LOC_XXXX')




### 出生点编辑器 StartPositioner

玩家出生点相关的功能。

- StartPositioner.DivideMapIntoMajorRegions()
- StartPositioner.DivideMapIntoMinorRegions()
- StartPositioner.GetMajorCivStartInfo()
- StartPositioner.GetMajorCivStartPlots()
- StartPositioner.GetMinorCivStartInfo()
- StartPositioner.GetMinorCivStartPlots()
- StartPositioner.GetNumMajorCivStarts()
- StartPositioner.GetNumMinorCivStarts()
- StartPositioner.GetOceanStartTile()
- StartPositioner.GetPlotFertility()
- StartPositioner.GetTotalOceanStartCandidates()
- StartPositioner.MarkMajorRegionUsed()
- StartPositioner.PlaceOceanStartCivs()


<div id="TerrainBuilder"/>
### 地形编辑器 TerrainBuilder

用于修改游戏地形。

- TerrainBuilder.AddCoastalLowland()
- TerrainBuilder.AddIce()
- TerrainBuilder.AnalyzeChokepoints()
- TerrainBuilder.CanHaveFeature()
- TerrainBuilder.GenerateFloodplains()
- TerrainBuilder.GetAdjacentFeatureCount()
- TerrainBuilder.GetFractalFlags()
- TerrainBuilder.GetInlandCorner()
- TerrainBuilder.GetRandomNumber()
- TerrainBuilder.SetContinentType()
- TerrainBuilder.SetFeatureType()
- TerrainBuilder.SetMultiPlotFeatureType()
- TerrainBuilder.SetNEOfCliff()
- TerrainBuilder.SetNEOfRiver()
- TerrainBuilder.SetNWOfCliff()
- TerrainBuilder.SetNWOfRiver()
- TerrainBuilder.SetTerrainType()
- TerrainBuilder.SetWOfCliff()
- TerrainBuilder.SetWOfRiver()
- TerrainBuilder.StampContinents()



### 河流编辑器 RiverManager

用于获取河流信息。



常用方法：

```lua
local pRivers = RiverManager.EnumerateRivers()
-- 返回 {1: pRiver1, 2: pRiver2, ...}
```

每条河流 `pRiver` 的属性：

- pRiver.Name: string
- pRiver.Edges: table
- pRiver.TypeID: number （有名字的河流在GameInfo.NamedRivers中的Index）
- pRiver.ID: number    （好像和该河流在本地图所有河流中的序号Index是一样的）

其中 `Edges` 的元素数量相当于河流的长度。以 `local edges = river.Edges[1]` 举例，由于河流的每一节都是两个格位构成，所以 `edges` 是一个含有两个格位 Index 的 table。

> 1）如果一条河流是另一条的支流，比如嘉陵江的长度只算到重庆就停了，不能把长江的长度算在内。
> 2）河流可能只有一部分是有名字的，比如金沙江只在长江的上游。




- RiverManager.GetRiverTypeAtIndex
- RiverManager.GetRiverNameByType
- RiverManager.GetRiverIndexByID
- RiverManager.GetRiverTypes
- RiverManager.GetRiverIDAtIndex
- RiverManager.GetFloodplainLocation
- RiverManager.GetRiverName
- RiverManager.GetRiverForFloodplain
- RiverManager.IsFlooded
- RiverManager.GetRiverByIndex
- RiverManager.GetNumRivers
- RiverManager.GetNumFloods
- RiverManager.GetRiverByID
- RiverManager.EnumerateRivers
- RiverManager.GetNumFloodableRivers
- RiverManager.CanBeFlooded
- RiverManager.GetRiverType
- RiverManager.GetFloodplainPlots










