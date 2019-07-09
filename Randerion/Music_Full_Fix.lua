-----------------------------------------------------------------------------------------
-- Jan 29, 2019 By HaoJun0823
-- This script comes from https://forums.civfanatics.com/threads/tutorial-adding-music-to-your-mod-civilization.621830/
-- Thanks FurionHuang,Gedemon,HerdByFate,raen.
-- Today, there is still no perfect way to add music.
-- If someone can know how to do it, please reply at the address above, thank you!
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- Gedemon's Script
-- Override the restart button

--2019/01/05
--If you click the Cancel button, the menu will be transparent and cannot be closed.
--So I canceled this menu and if it was triggered incorrectly, the auto save can still be called back.

-----------------------------------------------------------------------------------------
--HaoJun0823 (Randerion)
--2019/01/29
--So i try to fix all bugs which anythings can effect with playing fell.
--I maybe change something UI action like restart button (Just only this currently).
--This script just only change local machine,So you can use random things and don't need to worry other player.
--But you must to be know if you not equal local player is target leader all machine will be play audio or sound!
-----------------------------------------------------------------------------------------


local LEADER_NAME = "LEADER_FATE_QIN" --Set your Leader

function OnReallyRestart() -- Gedemon's Project copy the game lua and add a event.
    -- Start a fresh game using the existing game configuration.

	LuaEvents.RestartGame() -- add the function(s) you want to call before restarting a game to this lua event : LuaEvents.RestartGame.Add(myFunction)
    Network.RestartGame()
end

function OnEnterGame()   -- override the default callback once all the files are loaded...
--We need it to replace the restart button.



   
       ContextPtr:LookUpControl("/InGame/TopOptionsMenu/RestartButton"):RegisterCallback( Mouse.eLClick, OnReallyRestart )  
	   print("replace restart button!")


end

print("Randerion Audio Lua loaded:"..LEADER_NAME.." Pass Lua Check.")

-----------------------------------------------------------------------------------------
-- FurionHuang's Script
-- Stop the music when exit game.
-----------------------------------------------------------------------------------------


function OnUIExitGame() --easily to know.
	stopMusic()
end

function OnPlayerDefeatStopMusic( player, defeat, eventID) -- it's well done.
    --print("Defeat Event Activated.");
	stopMusic()

end

function OnTeamVictoryStopMusic(team, victory, eventID) -- same as the last.
    --print("Victory Event Activated.");
	stopMusic()
   
end

function OnOpenDiplomacyActionView(otherPlayerID) -- The diplomacuy panel open when your access target leader.
	--play some music use anyway for your want.
	local playerConfig:table = PlayerConfigurations[otherPlayerID]
	local leaderName = playerConfig:GetLeaderTypeName()


	if leaderName == LEADER_NAME then
	pauseWarPeaceMusic();
		
		local time = randomNumber(99)
		if(time <33) then
		UI.PlaySound("Play_Leader_Music_FATE_QIN_Other");
			else if (time >=33 and time <=66) then
			UI.PlaySound("Play_Leader_Music_FATE_QIN_Self");
				else if (time >66) then
				UI.PlaySound("Play_Leader_Music_FATE_QIN_War");
				end
			end
		end
	end


end



function DiplomacyActionView_ShowIngameUI()	
	--Now you need stop your played music.
	stopDiplomacyMusic();
	resumeWarPeaceMusic();
end

----------Events----------

function init() -- I can write this to optimize the event.

	
  print("Initialization event loading.")

  local localPlayerID:number = Game.GetLocalPlayer();
  local playerConfig:table = PlayerConfigurations[localPlayerID]
  local leaderName = playerConfig:GetLeaderTypeName()
 
  if leaderName == LEADER_NAME  then -- Consistent with the above variables
	-- There are local machine things.
	Events.LeaveGameComplete.Add(OnUIExitGame);
	Events.PlayerDefeat.Add(OnPlayerDefeatStopMusic);
	Events.TeamVictory.Add(OnTeamVictoryStopMusic);
	Events.LoadScreenClose.Add(OnEnterGame);
	LuaEvents.RestartGame.Add(OnUIExitGame);
	print(LEADER_NAME.." is local player, add event finished!")
	else
	print(LEADER_NAME.." not local player, don't need add event!")
	

  end

	--There are global game things(Other player need listen diplomacuy music)
	--So you need add a stop Diplomacy Music event for Play_Music event.
	LuaEvents.DiplomacyRibbon_OpenDiplomacyActionView.Add(OnOpenDiplomacyActionView);
	LuaEvents.DiplomacyActionView_ShowIngameUI.Add(DiplomacyActionView_ShowIngameUI);

	print("Event loaded.")
end

init()
-----------------------------------------------------------------------------------------
-- Done.
-----------------------------------------------------------------------------------------

function stopMusic() -- Use this method to stop music to fix something or you can write to other methods.

 UI.PlaySound("Stop_Music_FATE_QIN");
  --UI.PlaySound("Stop_Leader_Music_FATE_QIN_War");
   UI.PlaySound("Stop_Music_War_FATE_QIN");
    --UI.PlaySound("Stop_Leader_Music_FATE_QIN_Other");
	 --UI.PlaySound("Stop_Leader_Music_FATE_QIN_Self");
	  UI.PlaySound("Stop_Music_Peace_FATE_QIN");
	  
	  stopDiplomacyMusic()

end

function stopDiplomacyMusic()
  UI.PlaySound("Stop_Leader_Music_FATE_QIN_War");
    UI.PlaySound("Stop_Leader_Music_FATE_QIN_Other");
	 UI.PlaySound("Stop_Leader_Music_FATE_QIN_Self");
end




-----------------------------------------------------------------------------------------
-- Really Done.
-----------------------------------------------------------------------------------------