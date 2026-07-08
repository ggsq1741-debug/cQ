local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- ==================== 自定义三角洲行动风格主题（精确覆盖所有文字） ====================
local techGreen = Color3.fromRGB(0, 255, 65)   -- 科技绿
local white = Color3.fromRGB(255, 255, 255)
local lightGray = Color3.fromRGB(200, 200, 210)

--- 创建新主题，明确指定每个文字属性
WindUI:AddTheme({
    Name = "DeltaForce",
    -- 大标题（窗口标题、作者、标签页标题）
    WindowTopbarTitle = techGreen,
    WindowTopbarAuthor = techGreen,
    TabTitle = techGreen,
    -- 小标题（控件标题、按钮文字、弹窗标题）
    ElementTitle = white,
    ButtonText = white,
    PopupTitle = white,
    DialogTitle = white,
    -- 描述文字（灰色）
    ElementDesc = lightGray,
    PopupContent = lightGray,
    DialogContent = lightGray,
    -- 占位符（科技绿，保持风格）
    PlaceholderText = techGreen,
    -- 图标（科技绿）
    Icon = techGreen,
    -- 其他（可选）
    TooltipText = white,
    TooltipSecondaryText = white,
})
WindUI:SetTheme("DeltaForce")

-- 获取服务
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 创建主窗口
local Window = WindUI:CreateWindow({
    Title = "HB网络",
    Author = "User",
    Folder = "MyHub",
    Transparent = true,
    Theme = "DeltaForce",
    SideBarWidth = 130,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    Background = "https://i.postimg.cc/Y2TWzMfg/IMG-20250905-005015.jpg",
    BackgroundImageTransparency = 0.3,
    User = { Enabled = false },
    ToggleKey = Enum.KeyCode.F,
})

-- 创建标签页
local Tabs = {
    zho = Window:Tab({ Title = "砍伐树木", Icon = "zho" }),
}

local sbxp = false
Tabs.zho:Toggle({
    Title = "范围砍树(可能会卡)",
    Default = false,
    Image = "check",
    Callback = function(state)
        sbxp = state
        while sbxp and task.wait() do
            for _, s in ipairs(workspace.TreesFolder:GetChildren()) do
                game:GetService("ReplicatedStorage"):WaitForChild("Signal"):WaitForChild("Tree"):FireServer("damage", s.Name)
            end
        end
    end
})

local sbleng = false
Tabs.zho:Toggle({
    Title = "范围捡宝箱(延迟太大就不能用)",
    Default = false,
    Image = "check",
    Callback = function(state)
        sbleng = state
        while sbleng and task.wait() do
            for _, s in ipairs(workspace.ChestFolder:GetChildren()) do
                if s:FindFirstChild("Hitpart") then
                    fireproximityprompt(s.Hitpart.ProximityPrompt)
                end
            end
        end
    end
})

Tabs.zho:Button({
    Title = "砍伐树木",
    Desc = "砍伐树木",
    Callback = function()
        local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/454244513/WindUIFix/refs/heads/main/main.lua"))()
    end
})
Window:SelectTab(1)