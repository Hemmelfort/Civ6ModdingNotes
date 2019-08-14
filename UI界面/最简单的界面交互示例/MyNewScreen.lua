
function OnButtonClicked()
    Controls.MyText:SetText(Controls.MyText:GetText() .. "啊！")
end


function OnEnterGame()
    Controls.CustomArea:ChangeParent(ContextPtr:LookUpControl("/InGame/CityPanel/MainPanel"))
    Controls.MyButton:RegisterCallback(Mouse.eLClick, OnButtonClicked)
end


--OnEnterGame() -- 这样不行
Events.LoadScreenClose.Add(OnEnterGame) -- 这样才行
