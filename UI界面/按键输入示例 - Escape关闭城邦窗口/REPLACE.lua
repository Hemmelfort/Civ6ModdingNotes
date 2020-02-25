
-- 本代码用于替换游戏自带的 CityStates.lua（城邦使者界面），
-- 实现按 Esc 键关闭该窗口的功能。


-- 先继承原装界面
include("CityStates")

-- 按键响应函数
function OnInputHandler( pInputStruct:table )
    local uiMsg = pInputStruct:GetMessageType();
    
    if uiMsg == KeyEvents.KeyUp then
        if pInputStruct:GetKey() == Keys.VK_ESCAPE then
            OnClose()
            return true     -- 已处理响应
        end
    end

    return false;    -- 交由其他 Context 处理
end


function LateInitialize()
    -- 注册按键响应函数
    ContextPtr:SetInputHandler( OnInputHandler, true )
end

LateInitialize()

