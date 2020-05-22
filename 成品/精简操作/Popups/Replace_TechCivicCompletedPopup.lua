
-- 通过替换游戏自带脚本，来实现禁用 的弹窗

include("TechCivicCompletedPopup")

-- 备份原先的函数
local OnNotificationPanel_ShowTechDiscovered_BAK = OnNotificationPanel_ShowTechDiscovered
local OnNotificationPanel_ShowCivicDiscovered_BAK = OnNotificationPanel_ShowCivicDiscovered


function OnNotificationPanel_ShowTechDiscovered(ePlayer, techIndex:number, isByUser:boolean)
    --AddCompletedPopup( ePlayer, nil, techIndex, isByUser );
end

function OnNotificationPanel_ShowCivicDiscovered(ePlayer, civicIndex, isByUser:boolean)
    --AddCompletedPopup( ePlayer, civicIndex, nil, isByUser  );
end



function Initialize()
    -- 先移除原先的回调函数
    LuaEvents.NotificationPanel_ShowTechDiscovered.Remove(OnNotificationPanel_ShowTechDiscovered_BAK)
    LuaEvents.NotificationPanel_ShowCivicDiscovered.Remove(OnNotificationPanel_ShowCivicDiscovered_BAK)

    LuaEvents.NotificationPanel_ShowTechDiscovered.Add(OnNotificationPanel_ShowTechDiscovered)
    LuaEvents.NotificationPanel_ShowCivicDiscovered.Add(OnNotificationPanel_ShowCivicDiscovered)
end


Initialize();
