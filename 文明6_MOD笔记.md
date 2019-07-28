# 文明6 Mod笔记
--- 作者：我 ---

## 准备材料

### 工具
1. ModBuddy(附带有 AssetsEditor 和 Visual Studio 2013)
2. Photoshop(或 Gimp、Paint.NET) + dds 插件
> [dds 插件地址](https://developer.nvidia.com/gameworksdownload#?dn=texture-tools-for-adobe-photoshop-8-55)


### 图片资源
1. 背景图(1920×960)
2. 半身照( *512* ×1024，带 Alpha 透明图层)
3. 新文明图标(分辨率分别为22 30 32 36 44 45 48 50 64 80 128 200 256 共十三种)

> **其中 45 分辨率为彩色，其余为白色前景透明背景**

4. 新文明领袖图标(分辨率分别为32 45 50 55 64 80 256 共七种)
5. 其余建筑、单位图标(非必需)

> 背景图和半身照可各准备两份不同的文件，用于不同的界面。
> 单位 Portrait 分辨率：38 50 70 95 200 256 共六种
> 单位 Icon 分辨率：22 32 38 50 80 256 共六种
> 单位 Icon_FOW 分辨率：32 仅一种?
> 建筑 Icon 分辨率：32 38 50 80 128 256 共六种
> 建筑 Icon_FOW 分辨率：256 仅一种

### 知识储备
1. XML语法(必需)
2. SQL语法(非必需)
3. LUA语法(非必需)



## Mod 基本文件

### 标准的 Mod 文件结构（构建前）

 + ArtDefs
    - (*.artdef)
 + Textures
    - (*.dds)
    - (*.tex)
 + XLPs
    - (*.xlp)
 - Mod.Art.xml
 - (*.xml)

#### 构建之前：
1. artdef 文件用于模型定义，可用 AssetsEditor 生成。 **文件名必须与自带的一致，且必须在根目录的 `ArtDefs` 文件夹下。** 添加后要将信息记录在 Mod.Art.xml 里面相应位置。 *由于 ModBuddy 的 Bug，可能每次构建之后都必须用 AssetsEditor 生成的 artdef 文件去替换Mod文件夹中相应的文件*。
2. dds 文件用 Photoshop（或者 Gimp）制作，要去英伟达官网下载一个 dds 插件。
3. tex 文件记录了 dds 文件的相关信息，会和 dds 一起被打包成 blp 文件。 `Textures`文件夹不需要包含在 ModBuddy 项目中。
4. xlp 文件（xml library package）定义了图像资源的变量名、类型（如 UITexture/LeaderFallback）。构建后生成 blp 文件。
5. Mod.Art.xml 文件记录了 Mod 的相关资源的信息，必须指定 xlp 文件和 artdef 文件，可由一个小脚本自动生成。（ *但该脚本不确定是否存在一下问题：a.添加 xlp 文件到 UITexture 项；b.添加 LeaderFallbacks.blp 到 gameLibraries*）
6. xml 文件由我们手动编写。（文件名不能与游戏自带的冲突，如“Icons_Buildings.xml”）

#### 构建之后：
1. dep 文件（Dependencies）由 Mod.Art.xml 文件构建而来，包含了 artdef 的相关信息。 **有了 dep 文件就不需要将 artdef 文件添加到 modinfo 中**。
2. blp 文件（Binaries Library Package）是平台依赖的资源文件，暂时无法查看里面的内容，只能由 ModBuddy 生成。
3. modinfo 文件记录mod信息，包括作者、版本、加载顺序、文件列表等等。

#### 暂时不需要的文件：
1. ast 文件（即assets）
2. sql 文件
3. lua 文件
4. mtl 文件




## 步骤与规则

### 创建一个新的单位
1. xml 文件设定 unit 参数
2. xml 文件设置 text 名称、描述
3. xml 文件设置 icon 
4. artdef 设置模型
5. (如果是自定义图标)在 xlp 文件设置 dds 图片信息
6. (如果是文明专属单位)在 xml 文件添加 trait 信息

> 用前缀“ICON_”加上名字即可自动将该对象与图标联系在一起，如：
> 图标 `ICON_UNIT_ASSASSIN`
> 头像 `ICON_UNIT_ASSASSIN_PORTRAIT`
> FOW 图标 `ICON_UNIT_ASSASSIN_FOW`


### 创建一个新的建筑
与单位的创建过程基本一致


### 添加图像资源
1. 用 AssetEditor 打开或创建 xlp 文件。
2. 选择类别 （如 LeaderFallbacks/UITexture 等），在 Entries 点击“Add New”导入你的DDS文件，它们会自动被复制到项目的 Textures 目录下。
3. 使用不同尺寸的 ICON 时需先定义 Atlas (画册、图画集)，然后再使用其中的图像。


### 添加地图
1. 创建地图
  + （旧方法）修改 Mods.lua 的 OnShow 方法
  + 修改 AppOptions.txt 将 EnableWorldBuilder 设为 1
  + 在游戏主菜单“额外内容”里打开“地图编辑器”创建地图并保存
2. 加载地图
  + 用 Mod 加载（详见范例）


### 添加 Modifier 
1. Modifier 范畴（如 BuildingModifiers/TraitModifiers/DistrictModifiers 等等）
2. ModifierId 与 ModifierType
3. ModifierArguments

以建筑 BUILDING_SUPERMARKET 加成为例:
```
<BuildingModifiers>
    <Row>
        <BuildingType>BUILDING_SUPERMARKET</BuildingType>               建筑名
        <ModifierId>BUILDING_SUPERMARKET_MODIFIER_GOLD</ModifierId>     修改器名
    </Row>
</BuildingModifiers>

<Modifiers>
    <Row>
        <ModifierId>BUILDING_SUPERMARKET_MODIFIER_GOLD</ModifierId>     修改器名
        <ModifierType>MODIFIER_PLAYER_ADJUST_PLOT_YIELD</ModifierType>  修改目标
    </Row>
</Modifiers>

<ModifierArguments>
    <Row>
        <ModifierId>BUILDING_SUPERMARKET_MODIFIER_GOLD</ModifierId>     修改器名
        <Name>YieldType</Name>
        <Value>YIELD_GOLD</Value>
    </Row>
    <Row>
        <ModifierId>BUILDING_SUPERMARKET_MODIFIER_GOLD</ModifierId>
        <Name>Amount</Name>
        <Value>2</Value>
    </Row>
</ModifierArguments>
```


### 在文明选择界面设置领袖图片
1. 用 AssetEditor 将 something.dds 添加到 UITexture.xlp 。
2. 在 Config.xml 的 `<Players>` 中添加： `<Portrait> something </Portrait>` 


### 设置加载界面的图片，以及外交界面的背景图
1. 将 LOADING_FOREGROUND.dds / LOADING_BACKGROUND.dds / DIP_BACKGROUND.dds 添加到 UITexture.xlp
2. 在 xml 中添加一下两项：
```
<LoadingInfo>
    <Row LeaderType="LEADER_YOURLEADER" ForegroundImage="LOADING_FOREGROUND.dds" BackgroundImage="LOADING_BACKGROUND.dds" EraText="LOC_LOADING_INFO" PlayDawnOfManAudio="0"/>
</LoadingInfo>

<DiplomacyInfo>
    <Row Type="LEADER_YOURLEADER" BackgroundImage="DIP_BACKGROUND.dds"/>
</DiplomacyInfo>
```


### 设置外交界面的领袖图片
1. 将 LEADER_YOURLEADER_FALLBACK.dds 添加到 LeaderFallbacks.xlp
2. 设置类型为 LeaderFallback
3. 新建 artdef，选择模板 `LeaderFallback`，在 Leaders 项上右键添加新元素并设置名字（如 LEADER_GERALT）
4. 在子项 Animations 上新建元素，名字设为 `DEFAULT`，然后在 `BLP Entry` 中选择刚刚导入的 LEADER_YOURLEADER_FALLBACK，保存为 `FallbackLeaders.artdef`，最后在 ModBuddy 中导入




--------
### Mod 只支持 DLC 的设置
@Hajee:
I think if you have a mod that is using a Ruleset based on Vallina Game play you need to add this line to your modinfo file
```
<ActionCriteria>
    <Criteria id="Expansion1">
        <GameCoreInUse>Expansion1</GameCoreInUse>
    </Criteria>
</ActionCriteria>
```

--------
### About Adding LeaderFallback

I see you also created Icons.xlp already, 
so you don't have to use "ICON_ROGER_BERNARD_256.dds" in your Icons.xml. 
Instead, just "ICON_ROGER_BERNARD_256" and make sure entries here 
match what you entered in the xlp file.

Diplomacy screen leader is the fallbacks artdef 
and background UI_LeaderScenes package or direct dds import.


> kingchris20:
> 1. 你需要用AssetsEditor导入DDS文件，有两种办法：用Texture的方式导入，或者导入到XLP文件中（后者会自动生成相应的tex文件，如果同一个Category下已经有对应的XLP文件的话就用前面这种方法）。
> 2. 在下拉列表中选XLP的Class为LeaderFallback，PackageName应为LeaderFallbacks。在Entries点击“Add New”导入你的DDS文件，再保存为LeaderFallbacks.xlp。
> The **m_PackageName** name in .xlp needs to match the name of the file.
> 这时候DDS文件会自动复制到Textures文件夹下，用ModBuddy将其添加到工程中，再把刚刚生成的LeaderFallbacks.xlp也添加进来。
> 3. 用同样的方法生成artdef文件并导入。然后在Modbuddy中修改BLPEntryValue：
>   m_EntryName     XLP文件中对应的EntryID
>   m_XLPClass      固定为LeaderFallback
>   m_XLPPath       刚才保存的LeaderFallbacks.xlp
>   m_BLPPackage    XLP文件中m_PackageName，即LeaderFallbacks
>   m_LibraryName   （LeaderFallback，对应Mod.Art.xml中相应的libraryName）
>   （artdef是将dds和游戏中的对象联系在一起的地方，这里是将dds指定到游戏中对应的Leader上，而dds的定义或导入则是由xlp文件负责）
> 4. 修改Mod.Art.xml。
> 在 artConsumers 下 consumerName="LeaderFallback" 的地方，添加 relativeArtDefPaths 为 FallbackLeaders.artdef， 添加 libraryDependencies 为 LeaderFallback。
> 在 gameLibraries 下 libraryName="LeaderFallback" 的地方，添加 relativePackagePaths 为 LeaderFallbacks.blp。
```
<Element>
    <consumerName text="LeaderFallback"/>
    <relativeArtDefPaths>
        --- ADD THIS LINE to point to the artdef
        <Element text="FallbackLeaders.artdef"/>
    </relativeArtDefPaths>
    <libraryDependencies>
        --- This should already be there and it points to the Game Libraries section below
        <Element text="LeaderFallback"/>
    </libraryDependencies>
    <loadsLibraries>true</loadsLibraries>
</Element>
```
```
<Element>
    ---Tied in from the above
    <libraryName text="LeaderFallback"/>
    <relativePackagePaths>
        ---Ties to your blp, which is created by your xlp.
        <Element text="LeaderFallbacks.blp"/>
    </relativePackagePaths>
</Element>
```


---




### <CIVILOPEDIA TEXT>

The civilopedia text has a tricky part, you have you have to start with right parameter, for intance LOC_PEDIA_UNITS_PAGE (if buildings change to BUILDINGS, etc), then concatenate with you unit type (building type, etc), and finally define chapter number (defines order, and you can add whatever paragraphs you want) => LOC_PEDIA_UNITS_PAGE_UNIT_YOURUNIQUEUNIT_CHAPTER_HISTORY_PARA_1


### <ICONS>

Icon type has a tricky part, you have always to start bit ICON and then concatenate with your unit type name => "ICON_UNIT_YOURUNIQUEUNIT


### <ARTDEFS>

Important note: In the case of artdef files you must maintain the original names (including its folder: ArtDefs), for example units.artdef.

Artdefs are about animations in game, so it is no that easy to make your own. Once more you reuse existent ones. There is a catch, for instance if you want to use a building as an improvement no can do (at least without modifying it, which is a hard task), or a wonder like a building, besides all belonging to buildings table in this last case.



-------------------
### 一个完整文明的 XML 文件

> Witcher_Config.xml        显示在文明选择界面的信息
> Witcher_Civilization.xml  定义文明的特性、颜色、城市名等等
> Witcher_Leaders.xml       定义领袖
> Witcher_Units.xml         定义单位
> Witcher_Buildings.xml     定义建筑
> Witcher_Icons.xml         定义图标
> Witcher_Text.xml          定义文本


Witcher_Civilization.xml
  - Types
  - Civilizations
  - CivilizationLeaders
  - Traits
  - CivilizationTraits
  - CityNames
  - CivilizationCitizenNames
  - Colors
  - PlayerColors
  - StartBiasResources
  - StartBiasTerrains
  - LoadingInfo
  - DiplomacyInfo

> ETHNICITY_ASIAN, ETHNICITY_AFRICAN, ETHNICITY_MEDIT, ETHNICITY_SOUTHAM
> CIVILIZATION_LEVEL_TRIBE      部落，野蛮人
> CIVILIZATION_LEVEL_CITY_STATE 城邦
> CIVILIZATION_LEVEL_FULL_CIV   完整国家








    ╭╯☆★☆★╭╯ 
　　╰╮★☆★╭╯ 
　　　│☆╭─╯ 
　　 ╭ ╭╯ 
　╔╝★╚╗                                    ★☆╮╭☆★  
　║★☆★║╔═══╗　╔═══╗　╔═══╗  ╔═══╗
　║☆★☆║║★　☆║　║★　☆║　║★　☆║  ║★　☆║
◢◎══◎╚╝◎═◎╝═╚◎═◎╝═╚◎═◎╝═╚◎═◎╝.........
--------
## Firaxis官方SDK开发者：

- **FrontEndActions** are things the mod does when it's enabled to adjust the setup screen. 
- **InGameActions** are things the mod does when the game is started.
- You can also specify **criteria** to the actions to conditionally turn things off. 
For example, only apply these actions if this leader is playable or if we're in a specific ruleset:
**<Settings> == <FrontEndActions>
  <Components> == <InGameActions>**

Mods that don't do anything to the game aren't required when loading the saves. So if you have a bunch of leader/civ mods that affect the standard game enabled but you jump into a scenario, those extra mods won't be needed even though they were turned on. The goal was to minimize micro managing mods.

There's a setup field called `Ruleset`. Regular games use RULESET_STANDARD, scenarios use a custom ruleset. This provides a simple way to distinguish between a regular game and a standard one.

InGameActions can use the criteria RulesetInUse to specify only use this action if in standard game

I'm hoping to provide some more examples in the future showing off the modifier system and its uses for gameplay modding as well as the unit attachment system and its uses for kit-bashing 3d models since sometimes you just want to add new weapons and armor and not entire new humanoids.

The gameplay DLL is running on a separate thread and has it's own set of lua exposures. The UI scripts act on cached data that may not be 100% in sync with the state of the gameplay dll (for example if it's playing back combat) Because of this the UI-side lua scripts have some different exposures than the gameplay side.

**Text XMLs require the UpdateText action.**
The **LocalizedText** database table is in a separate database from the gameplay one.



ART TOOLS / ASSET EDITOR

Just a heads up to anyone using the art tools. You'll see the options greyed out in modbuddy at first. You have to have a mod project open before they are enabled (since launching the tools automatically provide the path to the project via command line)

The asset editor has to be launched via modbuddy so that it gets the right command line params. This is because the editor will generate lots of files and meta-data and needs to know where they go and what dependencies are from other projects.

**Also the first time you launch asset editor it will take a while...** usually 5-10min on reasonable machines but if you have <4gigs of memory you'll be caught paging a lot of data. This initial launch looks at the assets and generates a dependency graph but does cache it so **future launches are much much faster.**

There's an example modbuddy project that demos making 2d leaders so you should be able to get up and running with that fairly quickly.

No 3d art examples yet (I suck at art...) But I'll be adding more example starters in later updates.

**Everything you need is in the asset editor AFAIK.** It's a bear of a tool and can be difficult to navigate but we use it to define practically everything art related in the game. From 2d leaders to units, terrain features and 3d leaders.

Things may be a bit rough around the edges with this first release. But we'll be providing updates and I'm obviously keeping an eye out :)

To use the asset editor, downlod `the developer assets` **(it's 27 gigs!)** then launch the developer tools, click on modbuddy and get that running (you may have to install the shell redistributable). **Once it's running, navigate to Tools->Options->Civilization VI and verify the paths are correct.** People like to install things to custom steam library paths so it's good to double check. After that's done create a new mod project and then select Tools->Asset Editor. The first time you run it give it about 10min or so. It takes a while to generate a dependency graph of all of the assets but it gets cached so future runs are faster.

**The .tex files get created automatically by the asset editor.** It's used to specify how the textures get processed. The cooking/building process may compress the textures or do things with em based on what context the texture is being used.

The asset tools do have a bit of a learning curve. Best thing to do IMO is to use the starter projects and open the art defs and XLPs created and go from there.

You don't need the assets technically for art mods but in practice you almost always do.

**Mod.Art.Xml is a file that tells the cooker what systems need to use what art defs and XLPs.** For now you have to **hand-edit it** to add the references (if you diff the 2d leader example from say the empty mod you can see what changes were made).

The mod.art file and the dependencies go under UpdateArt. If you made any artdefs or xlps for your mod, you'll want the UpdateArt step and set it to **(Mod Art Dependency File)**.
**You will never need to reference the mod.art.xml directly.**
When your mod includes any art def files or XLP files, the build process creates a .dep file. This is the file you need to reference in your <UpdateArt> action. But! this file is generated at build time. So what you want to use instead is (Mod Art Dependency File) which is just a way of telling mod buddy to fill in the blank later with the generated file.

modbuddy won't do anything with it if there aren't any artdefs or XLPs in the root folder of the mod.
**Those artdefs and xlp's don't have to be part of the modbuddy project** either, the build step looks for all of them in the project folder.

I verified the textures are correct w/ what's on steam. Some do not open (at least in visual studio 2015) but others do just fine. For example YieldAtlas.dds works just fine for me. The others I suspect have additional information in them perhaps? I'll have to ask our engine guys.

> BLPs are files that contain the asset data
> artdefs are meta-data files

**Resources.artdef** defines clutter items for specific resources along with variants for terrain and feature type.

-------------------------------------------------------------
ART EXAMPLE

In asset editor, click on the toolbar button that says Open Existing Art Def.

From there navigate to the civ6 SDK assets and open Resources.artdef then do it again for Clutter.artdef
you'll see Resources.artdef specifies the resource type and expanded the base clutter ID along with variants
clutter == stuff on the map

in clutter.artdef you can see the clutter entry for gold which expanded shows that it uses several models for planets of varying scales and rotations
-------------------------------------------------------------







             * 
            /.\
           /..'\
           /'.'\
          /.''.'\
          /.'.'.\
   "'""""/'.''.'.\""'"'"
         ^^^[_]^^^
 
 
## Audio with Wwise 2015.1.9

[下载地址](https://www.audiokinetic.com/downloads/previous/)     
[或者](https://www.audiokinetic.com/files/?get=2015.1.9_5624/Wwise_v2015.1.9_Setup.exe)

(search 'wwise adpcm to pcm' if you want to convert wem to wav)

版本不能有错，2016/17都不行。
> Firaxis：
> 要覆盖已存在的音频，只需建立一个同名的 event ，mod的优先级会比游戏更高。
> 要添加新的音频，就要取一个唯一的前缀（give it a unique prefix），然后把 event 添加到新的 sound bank （参考波兰和澳大利亚的DLC）。最后在 lua 脚本中添加 UI.PlaySound() 即可。

Civ6 music for new civs: if the game doesn't recognize a civ, it'll issue events with the civ's name in them as follows:
`Start_Music_NAME` to force the civ's main theme to play (e.g. Waltzing Matilda for Aus).
`Play_Music_NAME` to play a random piece for the current era (more later), 
`Stop_Music_NAME` to stop both Play_Music & Start_Music.
`Pause_Music_NAME` to pause the Play or Start music for e.g. a leader screen, 
`Resume_Music_NAME` to resume it.
In leader screens, `Play_Leader_Music_NAME` and `Stop_Leader_Music_NAME` are issued. 
**NAME is always the name of the civ from the DB**.

For unrecognized custom unit types, `Unit_Selected_TYPE` is issued when clicking the unit (we use this ourselves in the DLC).
Custom unit types in the 2D view also issue `Unit_Move_2D_TYPE`, 
`Stop_Unit_Move_2D_TYPE`, `Unit_Embark_2D_TYPE`,
`Unit_Disembark_2D_TYPE`, `Unit_Combat_Lose_2D_TYPE`, 
`Unit_Death_2D_TYPE`, `Nuke_Attack_2D_TYPE`, & 
`Nuke_Attack_Smaller_2D_TYPE`.

Finally, **all Wwise events are NOT case sensitive**. Unit_Select_Dingo and Unit_SELECT_DINGO are the same event. That's all.




### Infixo Edition ###
@[Infixo](https://forums.civfanatics.com/members/infixo.276284/)

All sounds in the game are routed thorugh sound buses organized in a hierarchical tree.At the top there's always Master Audio Bus created by WWise and cannot be changed or removed.

- Ambience Bus      (id=4202237879)
- Master Music Bus  (id=48433064)
- Master SFX Bus    (id=3577355056)
- Speech Bus        (id=1472570345)

1. 以上所有的 Bus 都可以用。在 Audio 选项卡的 `Master-Mixer Hierarchy` 的 `Master Audio Bus` 下添加一个 child bus，选 `Audio Bus` 而不是 `Auxiliary Bus`。
2. Then assign sounds to buses. Again, 'Audio' tab, Actor-Mixer Hierarchy, select your sound. On the right there will be a window and in the middle a section 'Output Bus'. Click '...' to select a desired bus. Repeat for all your sounds.


### NerdByFate ###
[NerdByFate](https://forums.civfanatics.com/members/nerdbyfate.286744/)

A few notes for anyone attempting to follow this guide:
1. See Eras.artdef in the base game's files for all of the switches you can use. Not every era has its own switch in the game. Classical uses Ancient's switch, Renaissance uses Medieval's switch, Modern uses Industrial's switch (weirdly). and both Atomic and Informational use Modern's switch (meaning that whatever you assign to modern won't actually play until Atomic). This means you can't assign a playlist to every era, some will simply carry over to the next era(s).
2. Your playlists will not loop throughout their respective eras by default. To accomplish this, visit this [link](https://www.audiokinetic.com/courses/wwise201/?id=looping_music_segment_using_playlist_container).
3. If you have already linked a Civilizations.artdef to use base game music and you want to switch over to this, you MUST remove this link as it overrides the custom SoundBank. If you don't, the music you selected in Civilizations.artdef will play, not your music. 如果你在 Civilizations.artdef 中使用了自带文明的音乐，而你想用自己的音乐时，必须删除在 Civilizations.artdef 中的引用。否则游戏不会播放你的音乐。

> Ancient_Era:      Ancient     &   Classical
> Medieval_Era:     Medieval    &   Renaissance
> Industrial_Era:   Industrial  &   Modern
> Modern_Era:       Atomic      &   Information


### FurionHuang Edition ###
@[FurionHuang](https://forums.civfanatics.com/members/furionhuang.301776/)
[Tutorial: Adding Music to Your MOD Civilization](https://forums.civfanatics.com/threads/tutorial-adding-music-to-your-mod-civilization.621830/) 




### Ewok-Bacon-Bits Edition ###
@[Ewok-Bacon-Bits](https://forums.civfanatics.com/members/ewok-bacon-bits.291823/)
 
1. 首先下载安装 Wwise，用来生成需要的3个文件（bnk, xml, txt）。
2. 打开后在左上角 `Project Explorer` 的 `Audio` 选项卡中右键选择 `Import audio files` 导入wav文件。
3. 在 `Events` 选项卡中点击 `Create new event`。
4. 选中刚创建的 event 然后重命名：“ This name is what you will reference when you actually play it via the UI. I'm guessing if you were to replace an already existing event made by Firaxis you will want to rename it too that exact event like "POLA_JA_DEFEAT_B_1" for instance which in this case would replace Jadwiga's speech when she is defeated but I have not tested this exactly yet. ”。
5. After renaming click browse inside event actions, find your music file. Just set the action as Play which is default. You will most likely just want one file per event.
6. 切换到 `SoundBanks` 选项卡点击 `Create New Soundbank` 。右键选中编辑、重命名。
7. 保持当前面板打开，点击 event 选项卡把所有 event 拖进来，保存。
8. 右键该 soundbank 选择 `Generate Soundbank(s) for current platform` 。
9. 现在可以在资源管理器中看到刚刚生成的文件了。
10. 我们需要把3个文件复制到 mod 文件夹中（bnk, xml, txt）。
11. 打开 xml 文件把 `SoundBank Language` 标签删掉或注释掉。比如：
```
<SoundBank Language="SFX" Id="1355168291">
    <ShortName>Init</ShortName>
    <Path>Init.bnk</Path>
</SoundBank>
```
12. 现在还需要一个 ini 文件（可以在游戏目录中找到类似的），比如：
```
[Global]
[Menu]
[InGame]
Event.bnk   ; 这里就是你的 bnk 文件加载的时机
[2D]
[3D]
[FMV]
```
13. 根据自己的加载时机，把 bnk 文件名添加到 ini 文件中合适的位置（如上）。
14. 在 ModBuddy 中添加一个 `UpdateAudio` 到 modinfo 中，要包含以上4个文件。
15. 在游戏脚本中添加一行命令 `UI.PlaySound("Your_Event_Name")` 到一个你想要指定的函数中就可以了。如果你想替换游戏自带的 event 可以跳过这一步，我还没试过, it should just play instead of whatever audio was there before when it is called.

 
 
 
 
 
               . 
               |
           \   *  ./
          .  * * * .
         -=*  POP! *=-              
         .  .* * *  .
          /    *  .\
               |  
               .     



## ArtDef with AssetEditor

The Armor geometries come with different attachment points for accessories and bodies and etc. Most of the attachments will go in a point called “Root”, but there are some specifics. In order to place attachments in the Asset Previewer you must find the tab corresponding our current asset.
护甲的几何图形通过不同的接触点连接到身体和其他附件？！大部分的附件都汇聚到一个叫“Root”的地方，但也有例外。为了放置这些附件，你必须找到当前asset相关的选项卡。



artdef reload Camera 

 
 


## CAMERA.ARTDEF 
[12@!n](https://forums.civfanatics.com/resources/kinetikam.25487/)

**HeightCurve** is the CollectionName for all variables relating to height, of which there are 4.

**HeightCurve2** is the sub-collection category for the two variables that control camera transition speed and maximum distance when zooming **out**.

The two variables are:
 + "Time" - appears to control transition speed and smoothness. 0 is slowest and the higher the variable the quicker and less smooth the transition. The default value is 100.000000.
 + "Height" - appears to control the maximum distance away from focal point. The default value is 600.000000.

**HeightCurve1** is the sub-collection category for the two variables that control camera transition speed and maximum distance when zooming **in**.

The two variables are:
 + "Time" - appears to control transition speed and smoothness. 0 is slowest and the higher the variable the quicker and less smooth the transition. The default value is 0.000000.
 + "Height" - appears to control the maximum zoom level to focal point. The default value is 120.000000.

**TiltCurve** is the CollectionName for all variables relating to pitch, of which there are 4.

**TiltCurve1** appears to be the subcollection category for the two variables that control camera transition speed and maximum distance when zooming **out**.

The two variables are:
 + "Time" - appears to control transition speed and smoothness. 0 is slowest and the higher the variable the quicker and less smooth the transition. The default value is 100.000000.
 + "Tilt" - appears to control the pitch, with lower values pitching down and higher values pitching up, in accordance with the six degrees of freedom. The default value is 45.000000.

**TiltCurve2** appears to be the sub-collection category for the two variables that control camera transition speed and maximum distance when zooming **in**.

The two variables are:
 + "Time" - appears to control transition speed and smoothness. 0 is slowest and the higher the variable the quicker and less smooth the transition. The default value is 0.000000.
 + "Tilt" - appears to control the pitch, with lower values pitching down and higher values pitching up, in accordance with the six degrees of freedom. The default value is 55.000000.


-------------------------
The yellow squares, which I call "clipping artifacts", tend to occur when:
You're at an extreme end of the zoom spectrum (i.e. when you zoom in very close, or out very far) AND
The camera is tilted too much (or possibly too little)e.g. I've seen it happen along the bottom edge of the map when you zoom in too close and angle the camera up toward the horizon. I've also seen it happen along the top edge when you zoom out too far, even with the camera pointing nearly straight down.

When tweaking for this mod I did my best to minimize the occurrence of clipping - at least compared to other "zoom out further" mods - by doing a lot of testing, and setting reasonable limits within the file. But I can't account for all screen resolutions and graphics settings.

If you're still seeing it, aren't afraid of doing some text editing, then you can fiddle with both the zoom limits and tilt in an effort to make the clipping go away:
Install Notepad++ or a similar text editor that isn't Notepad.

Run Notepad++, and open the file:
C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization VI\Base\ArtDefs\Camera.artdef

Find the section that looks like this:
Code:
<!-- Camera tilt at farthest zoom. Lower values make it more two-dimensional (like a map on a wall). Default was 45. -->
<m_fValue>10.000000</m_fValue>
<m_ParamName text="Tilt"/>
Change the 10.000000 to something smaller (e.g. 8.000000). That will make the camera look "down" more when at the farthest zoom level. Alternatively, you can try changing it to be a big bigger (e.g. 15).

Save the file, quit Civilization VI (if it's running) and restart it.
You can also reduce a number further down in the file, which controls how far you are allowed to zoom out (and will in fact probably be more effective than the above change):
Code:
<!-- Altitude at furthest zoom in WorldView map. Default was 600. -->
<m_fValue>2500.000000</m_fValue>
Try a value like 1500.000000. Don't go below 600 unless you also reduce the existing 600 value later in the file (the one near the comment "Altitude at 30% zoom").

Note you don't have to include the ".000000" parts.

Keep playing around with those numbers until the clipping artifacts go away. You have to restart Civilization VI between each edit.

Other values you can play with are described in the comments (the human-friendly text between the <!-- and --> brackets).

If you're really adventurous, you can try adjusting these values near the top of the file, although I gave up before finding values that clear up the clipping:
Code:
<Element class="AssetObjects::FloatValue">
    <m_fValue>10.000000</m_fValue>
    <m_ParamName text="NearClip"/>
</Element>
<Element class="AssetObjects::FloatValue">
    <m_fValue>10000.000000</m_fValue>
    <m_ParamName text="FarClip"/>
</Element>
If this is is still too complicated for you, I'm sure there are friendly folks around here who can give you a hand. Good luck!
-------------------------------------






### How the different combinations of the RunOnce and Permanent flags work ?
**RUNONCE** and **PERMANENT**
@luei333

1. RunOnce: A boolean that identifies whether or not this modifier applies a one-time effect, such as a free unit, an inspiration or eureka boost, etc. False by default. It is not always clear when this should be used, but when in doubt, refer to the base game files and emulate them, i.e. find a modifier with the same ModifierType as the one you’re using, and use that as a reference.

2. Permanent: A boolean that identifies whether or not this modifier should apply permanently. False by default. While seemingly contradictory, this is often used in conjunction with RunOnce. This is to prevent the modifier from applying itself again if, for whatever reason, the modifier disappears and then reappears. There are also some cases where this is used without RunOnce. Again, when in doubt as to whether you should use these, emulate the base game.

> Short version, RunOnce means that the modifier will only run one time, instead of constantly applying its effects over multiple turns. Only really applicable for certain things, like granting units or population, etc.

> Permanent means that the modifier will ALWAYS exist on that entity, as long as the entity itself exists. Persistent bonuses, like bonuses to yields, will be applied forever and aren't turned off when the requirements are no longer met. And since the modifier can never be UN-applied, it can never be RE-applied. Combined with RunOnce, you can make modifiers that can trigger once, and only ever once per entity they can affect.

Imagine adding a modifier to a city that grants 1 population (or a similar effect), and requires a builder to be in the city center's tile. The first time a builder walk onto its tile, the city will receive an extra population. If the RunOnce value isn't set to true, it will likely continue to gain extra population every turn or so, as long as the builder remains on its tile (or however often the effect would trigger). If Permanent but not RunOnce, it will likely gain extra population continuously for the rest of the game! Adding RunOnce means that the city would get extra population only one time, but without permanent it could trigger multiple times. Not sure on the exact nature there, but it might be as simple as moving the builder off of the tile and back on repeatedly to trigger the population gain again and again. With both RunOnce and Permanent set, that city would only ever be able to gain 1 extra population from having a builder on its tile, no matter how many different builders go on it throughout the course of the game.






ATTACH TO TRAIT_LEADER_MAJOR_CIV

- instead of attaching the Modifier to every Civilization via a Trait,
- attach the Modifier to the following trait only:

INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
('TRAIT_LEADER_MAJOR_CIV', 'SUPER_BUILDCHARGES_MODIFIER');

- and make sure to use PLAYER_IS_HUMAN requirement as OWNER RequirementSetId

This way, you don't need to duplicate the trait for each civ. TRAIT_LEADER_MAJOR_CIV will give it to the leaders of all major civs, and PLAYER_IS_HUMAN will limit it only to you, human, while you are playing a specific civ.

SUBJECT vs. OWNER of MODIFIER

Now, as for the SubjectRequirementSetId vs OwnerRequirementSetId. The Modifier Type you used -- MODIFIER_PLAYER_UNITS_ADJUST_BUILDER_CHARGES -- refers to COLLECTION_PLAYER_UNITS.

So, the Subject of the Modifier is: Player Units
And, the Owner of the Modifier is: (as a result of being attached to a Trait) either Civilization or Leader Major Civ (as per my suggestion above).

As a result, PLAYER_IS_HUMAN should properly refer to the Owner of the Modifier -- you should insert it as OwnerRequirementSetId.
Any requirement that you wish to attach to Player Units would go in as SubjectRequirementSetId.

REQUIREMENTS / REQUIREMENT SETS

Generally, you can attach two Requirement Sets to each Modifier. 
**OwnerRequirementSet** attaches to the Owner - to the object that is the source of the modifier. 
**SubjectRequirementSet** attaches to the Subject - to the object being modified by the modifier.

OwnerRequirementSet：自己拥有一个修改器，只要自己满足一定条件，修改器就激活；
SubjectRequirementSet：自己拥有一个修改器，想修改另一个对象，若对象满足一定条件，修改器就激活。



-----------------------------------------





























