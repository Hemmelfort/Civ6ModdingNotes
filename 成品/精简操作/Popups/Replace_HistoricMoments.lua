
include("HistoricMoments")

local OnProcessNotification_BAK = OnProcessNotification
local AUTO_SHOW_INTEREST_LEVEL:number = 3
local HISTORIC_MOMENT_HASH:number = DB.MakeHash("NOTIFICATION_PRIDE_MOMENT_RECORDED")


function OnProcessNotification(playerID:number, notificationID:number, activatedByUser:boolean)

	if (not activatedByUser) and (playerID == Game.GetLocalPlayer()) then
        local pNotification = NotificationManager.Find(playerID, notificationID);
        
		if pNotification and pNotification:GetType() == HISTORIC_MOMENT_HASH then
			local momentID = pNotification:GetValue("MomentID");
			
			if momentID then
                local momentData:table = Game.GetHistoryManager():GetMomentData(momentID);
                local momentInfo:table = momentData and GameInfo.Moments[momentData.Type] or nil;
                
                if momentInfo and momentInfo.InterestLevel < AUTO_SHOW_INTEREST_LEVEL then
                    return;
                end
                
                UI.PlaySound("Pride_Moment");
			end
            
        end
    end
end


Events.NotificationActivated.Remove(OnProcessNotification_BAK);
Events.NotificationActivated.Add(OnProcessNotification);

