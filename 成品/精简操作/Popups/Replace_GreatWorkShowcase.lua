
include("GreatWorkShowcase")

local OnGreatWorkCreated_BAK = OnGreatWorkCreated


function OnGreatWorkCreated(playerID:number, creatorID:number, cityX:number, cityY:number, buildingID:number, greatWorkIndex:number)
	--DisplayGreatWorkCreated(playerID, creatorID, cityX, cityY, buildingID, greatWorkIndex, false);
end


function Initialize()
	Events.GreatWorkCreated.Remove(OnGreatWorkCreated_BAK)
	Events.GreatWorkCreated.Add(OnGreatWorkCreated)
end


Initialize();
