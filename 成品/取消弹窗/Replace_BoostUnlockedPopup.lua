
-- 通过替换游戏自带脚本，来实现禁用尤里卡/鼓舞的弹窗

include("BoostUnlockedPopup")

-- 备份原先的函数
local OnNotificationPanel_ShowTechBoost_BAK = OnNotificationPanel_ShowTechBoost
local OnNotificationPanel_ShowCivicBoost_BAK = OnNotificationPanel_ShowCivicBoost


function OnNotificationPanel_ShowTechBoost( ePlayer, techIndex, iTechProgress, eSource )
	--DoTechBoost(ePlayer, techIndex, iTechProgress, eSource);
end

function OnNotificationPanel_ShowCivicBoost( ePlayer, civicIndex, iCivicProgress, eSource )
	--DoCivicBoost(ePlayer, civicIndex, iCivicProgress, eSource);
end



function Initialize()
    -- 先移除原先的回调函数
    LuaEvents.NotificationPanel_ShowTechBoost.Remove(OnNotificationPanel_ShowTechBoost_BAK)
    LuaEvents.NotificationPanel_ShowCivicBoost.Remove(OnNotificationPanel_ShowCivicBoost_BAK)

    LuaEvents.NotificationPanel_ShowTechBoost.Add(OnNotificationPanel_ShowTechBoost)
    LuaEvents.NotificationPanel_ShowCivicBoost.Add(OnNotificationPanel_ShowCivicBoost)
end


Initialize();
