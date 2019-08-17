
-- 在游戏中输入汉字比较麻烦，这个例子通过在地图搜索面板中添加几个按钮，从而可以快速填充搜索框

-- ContextPtr:LookUpControl 无法定位到搜索框 MapSearchBox，暂时不知道为什么，目前只能连续地 GetChildren，有了解的大佬请指正

function SendText(loc_text)
    local ctrl = ContextPtr:LookUpControl("/InGame/MinimapPanel/MapSearchPanel")
    
    if ctrl ~= nil then
        local MapSearchBox = ctrl:GetChildren()[1]:GetChildren()[2]:GetChildren()[1]:GetChildren()[4]:GetChildren()[1]
        MapSearchBox:SetText(Locale.Lookup(loc_text))
    else
        print("F**k LookUpControl!")
    end
end


function SetupSearchButtons()
    local ctrl = ContextPtr:LookUpControl("/InGame/MinimapPanel/MapSearchPanel")
    
    if ctrl ~= nil then
        local targetPannel = ctrl:GetChildren()[1]:GetChildren()[2]
        Controls.QuickSearchPanel:ChangeParent(targetPannel)
    else
        print("fffffffffffff")
    end
    
    Controls.ButtonHorses:RegisterCallback(Mouse.eLClick, function() SendText("LOC_RESOURCE_HORSES_NAME"); end)
    Controls.ButtonIron:RegisterCallback(Mouse.eLClick, function() SendText("LOC_RESOURCE_IRON_NAME"); end)
    Controls.ButtonNiter:RegisterCallback(Mouse.eLClick, function() SendText("LOC_RESOURCE_NITER_NAME"); end)
    Controls.ButtonCoal:RegisterCallback(Mouse.eLClick, function() SendText("LOC_RESOURCE_COAL_NAME"); end)
    Controls.ButtonOil:RegisterCallback(Mouse.eLClick, function() SendText("LOC_RESOURCE_OIL_NAME"); end)
    Controls.ButtonUranium:RegisterCallback(Mouse.eLClick, function() SendText("LOC_RESOURCE_URANIUM_NAME"); end)
    Controls.ButtonAluminum:RegisterCallback(Mouse.eLClick, function() SendText("LOC_RESOURCE_ALUMINUM_NAME"); end)
end


Events.LoadScreenClose.Add(SetupSearchButtons)

