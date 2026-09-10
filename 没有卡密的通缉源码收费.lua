local ReplicatedStorage = game:GetService("ReplicatedStorage")

print("[🔧] 开始安全删除反作弊文件...")

local deletedCount = 0

-- ============================================
-- 安全删除列表（只删这些）
-- ============================================
local function deleteIfExists(parent, ...)
    local obj = parent
    local parts = {...}
    for _, part in ipairs(parts) do
        if obj then
            obj = obj:FindFirstChild(part)
        else
            break
        end
    end
    if obj then
        pcall(function()
            obj:Destroy()
            deletedCount = deletedCount + 1
            print("[🔥] 删除: " .. obj:GetFullName())
        end)
        return true
    end
    return false
end

print("📌 删除反作弊核心文件...")

-- 1. RateLimiter（限速器 - 反作弊核心）
deleteIfExists(ReplicatedStorage, "Shared", "Core", "RateLimiter")
deleteIfExists(ReplicatedStorage, "Vendor", "ReplicaService", "RateLimiter")

-- 2. GetAsset（资源检测 - 反作弊）
deleteIfExists(ReplicatedStorage, "Shared", "Core", "GetAsset")

-- 3. DebugTeleport（传送检测 - 反作弊）
deleteIfExists(ReplicatedStorage, "Client", "Core", "DebugTeleport")

-- 4. ClientPlayerFlags（玩家标志 - 反作弊标记）
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "Modules", "ClientPlayerFlags")

-- 5. Telemetry（遥测 - 监控玩家行为）
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "Objects", "DevvChassis", "Components", "Telemetry")

print("📌 删除Cmdr管理命令（可能用于反作弊）...")

-- 6. CmdrClient（管理命令 - 可能用于检查）
deleteIfExists(ReplicatedStorage, "CmdrClient")

-- 7. Vendor.Cmdr（管理命令）
deleteIfExists(ReplicatedStorage, "Vendor", "Cmdr")

print("📌 删除Report/Flag相关（举报/标记系统）...")

-- 8. ReportApp（举报应用）
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "UI", "Screens", "PhoneScreen", "Apps", "ReportApp")

-- 9. ReportDialog（举报对话框）
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "UI", "Screens", "DialogScreen", "Dialogs", "ReportDialog")

-- 10. Flags相关（标记系统）
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "Modules", "ClientPlayerFlags", "Flags")

-- 11. GameShopFlags（商店标记）
deleteIfExists(ReplicatedStorage, "Shared", "Wanted", "Indicies", "GameShopFlags")

print("📌 删除安全相关UI...")

-- 12. SecurityCameraScreen（监控摄像头）
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "UI", "Screens", "SecurityCameraScreen")
deleteIfExists(ReplicatedStorage, "Client", "Assets", "Guis", "Screens", "SecurityCameraScreen")

-- 13. SecurityDesk（安全台）
deleteIfExists(ReplicatedStorage, "Shared", "Wanted", "Indicies", "FurnitureInteractions", "Interactions", "SecurityDesk")
deleteIfExists(ReplicatedStorage, "Shared", "Wanted", "Indicies", "Objects", "Props", "World", "SecurityDesk")

-- 14. SecurityCamera（安全摄像头）
deleteIfExists(ReplicatedStorage, "Shared", "Wanted", "Indicies", "FurnitureInteractions", "Interactions", "SecurityCamera")

-- 15. SecurityShutter（安全卷帘门）
deleteIfExists(ReplicatedStorage, "Shared", "Wanted", "Indicies", "Objects", "Props", "World", "SecurityShutter")

-- ============================================
-- 删除反作弊Remote事件
-- ============================================
print("📌 删除反作弊Remote...")

local function deleteRemote(parent, name)
    if parent then
        local obj = parent:FindFirstChild(name)
        if obj and (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) then
            pcall(function()
                obj:Destroy()
                deletedCount = deletedCount + 1
                print("[🔥] 删除Remote: " .. obj:GetFullName())
            end)
        end
    end
end

-- 查找并删除反作弊Remote
local function scanAndDeleteRemotes()
    local keywords = {"anticheat", "exploit", "cheat", "hack", "detect", "ban", "flag", "violation"}
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local name = string.lower(obj.Name)
            for _, kw in ipairs(keywords) do
                if string.find(name, kw, 1, true) then
                    pcall(function()
                        obj:Destroy()
                        deletedCount = deletedCount + 1
                        print("[🔥] 删除Remote: " .. obj:GetFullName())
                    end)
                    break
                end
            end
        end
    end
end

scanAndDeleteRemotes()

-- ============================================
-- 完成
-- ============================================
print("═══════════════════════════════════════")
print("[✅] 删除完成！")
print("   📊 共删除 " .. deletedCount .. " 个反作弊文件")
print("   ⚠️ 游戏功能文件未受影响")
print("═══════════════════════════════════════")

-- ============================================
-- 导出函数
-- ============================================
_G.SafeDelete = {
    Run = function()
        print("[🔧] 重新执行删除...")
        -- 重新执行上面的删除逻辑
        deletedCount = 0
        -- 这里可以重新执行删除
        print("[✅] 完成")
    end
}

print("[💡] 如果按键被删，重新加入游戏即可恢复")

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/main.lua"))()
WindUI:Notify({
    Title = "",
    Content = "有问题bug联系作者",
    Icon = "circle-user-round",
    Duration = 20,
})
WindUI:Notify({
    Title = "问题",
    Content = "跑步拉回的话请连续跳跃在奔跑",
    Icon = "circle-user-round",
    Duration = 10,
})
WindUI:Notify({
    Title = "纸飞机",
    Content = "@you25801",
    Icon = "circle-user-round",
    Duration = 120,
})
WindUI:Notify({
    Title = "更新",
    Content = "灵魂/实体飞行和ESP2",
    Icon = "circle-user-round",
    Duration = 15,
})
local Popup = WindUI:Popup({
    Title = "hi你好👋",
    Content = "✈️更新飞行:但是此飞行可能存在一些Bug，玩家如果在空中飞行要落地的话，尽量角色与地面着地再关闭，否则可能会导致回拉此飞行类似于其他游戏外挂中的灵魂飞行思路来源（AF作者秋辞）❤️ ✅解决ESP物品卡顿问题🟢",
    Buttons = {
        {
            Title = "Get Started",
            Callback = function()
                print("Getting started...")
            end
        }
    }
})
-- ==================== 自定义三角洲行动风格主题（精确覆盖所有文字） ====================
local techGreen = Color3.fromRGB(0, 255, 160)   -- 科技绿
local white = Color3.fromRGB(245, 248, 255)
local lightGray = Color3.fromRGB(175, 185, 200)

WindUI:AddTheme({
    Name = "DeltaForce",
    -- 【全局所有图标颜色！侧边标签图标、控件小图标全部变成绿色】
    Icon = Color3.fromHex("#22c55e"), 

    WindowTopbarTitle = techGreen,
    WindowTopbarAuthor = techGreen,
    TabTitle = techGreen,

    ElementTitle = white,
    ButtonText = white,
    PopupTitle = white,
    DialogTitle = white,

    ElementDesc = lightGray,
    PopupContent = lightGray,
    DialogContent = lightGray,

    PlaceholderText = techGreen,

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
    Title = "港猫的通缉Wanted",
    Author = "作者港猫😔😔😔",
    Folder = "MyHub",
    Transparent = true,
    Theme = "DeltaForce",
    SideBarWidth = 130,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    Background = "https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/image_download_1789060091738.jpg",
    BackgroundImageTransparency = 0.4,
    User = { Enabled = true },
    ToggleKey = Enum.KeyCode.F,
})

print("窗口标题应为绿色，控件标题应为白色")
local Tabs = {
    wj = Window:Tab({ Title = "玩家", Icon = "users" }),
    jx = Window:Tab({ Title = "远程击杀+雷达", Icon = "crown" }), 
    bot = Window:Tab({ Title = "瞄准", Icon = "target" }),
    ESP = Window:Tab({ Title = "ESP", Icon = "eye" }),
    ESPP = Window:Tab({ Title = "ESP2", Icon = "eye" }),
    wb = Window:Tab({ Title = "ESP物品", Icon = "box" }),
    qq = Window:Tab({ Title = "删除", Icon = "trash-2" }),
    rsao = Window:Tab({ Title = "娱乐功能", Icon = "zap" }),
    gm = Window:Tab({ Title = "购买", Icon = "shopping-cart" }),
}
-- ============================================================
-- ==================== 工具函数 ====================
local function getCharacter()
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        return LocalPlayer.Character
    end
    return nil
end
-- ==================== 无限跳（JumpRequest 事件） ====================
local isInfiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if isInfiniteJumpEnabled then
        local character = getCharacter()
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
------------===============----------
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local speedConn = nil
local currentSpeed = 1
-- 刷新角色&重连加速
local speedConn = nil
local currentSpeed = 1
-- 角色销毁/关闭功能自动断开连接
local function updateChar()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if speedConn then
        speedConn:Disconnect()
        speedConn = nil
    end
    if not hum or currentSpeed <= 1 then return end
    -- 降低更新频率，不用每帧
    speedConn = RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then
            speedConn:Disconnect()
            speedConn = nil
            return
        end
        local h = LocalPlayer.Character.Humanoid
        if h.MoveDirection.Magnitude > 0 then
            LocalPlayer.Character:TranslateBy(h.MoveDirection * currentSpeed / 10)
        end
    end)
end
LocalPlayer.CharacterAdded:Connect(updateChar)
task.spawn(updateChar)
Tabs.wj:Code({
    Title = "你好",
    Code = "纸飞机@you25801"
})
Tabs.wj:Input({
    Title = "超级快跑",
    Placeholder = "输入1~200数字",
    Default = "1",
    Numeric = true,
    Callback = function(val)
        local num = tonumber(val)
        if not num then return end
        currentSpeed = math.clamp(num,1,200)
        updateChar()
    end
})
Tabs.wj:Slider({
    Title = "超级快跑",
    Desc = "",
    Value = {Min = 1, Max = 200, Default = 1},
    Step = 1,
    IsTextbox = true,
    Callback = function(val)
        currentSpeed = val
        updateChar()
    end
})
local Players = game:GetService("Players")
local RunService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

local isWarpFlying = false
local flySpeed = 50

local MICRO_STEP_INTERVAL = 0.001
local MAX_STEP_SIZE = 10

local hrp, hum
local ControlModule = require(
    lp.PlayerScripts:WaitForChild("PlayerModule")
):GetControls()

local microStepConn, healthLockConn, diedConn
local originalCanCollide = {}
local descendantConnection

local function clearFlyRes()
    pcall(function()
        for part, state in pairs(originalCanCollide) do
            if part and part.Parent then
                part.CanCollide = state
            end
        end
        table.clear(originalCanCollide)

        if descendantConnection then descendantConnection:Disconnect() end
        if microStepConn then microStepConn:Cancel() end
        if healthLockConn then healthLockConn:Cancel() end
        if diedConn then diedConn:Disconnect() end

        if hrp and hum then
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end

local function microStepLoop()
    local targetPos = hrp.Position
    local lastTime = tick()

    while isWarpFlying do
        local now = tick()
        local dt = now - lastTime
        lastTime = now

        local mv = ControlModule:GetMoveVector()
        local cf = camera.CFrame

        local moveDir =
            (cf.LookVector * -mv.Z) +
            (cf.RightVector * mv.X)

        local vertical = 0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            vertical = 1
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            vertical = -1
        end

        local totalDelta =
            (moveDir + Vector3.new(0, vertical, 0)) *
            flySpeed * dt

        targetPos += totalDelta

        local currentPos = hrp.Position
        local remaining = targetPos - currentPos
        local distance = remaining.Magnitude

        if distance > 0 then
            local steps = math.ceil(distance / MAX_STEP_SIZE)
            local stepVec = remaining / steps

            for i = 1, steps do
                if not isWarpFlying then break end
                currentPos += stepVec
                hrp.CFrame =
                    CFrame.new(currentPos) * hrp.CFrame.Rotation
                hrp.Velocity = Vector3.zero
            end
        else
            hrp.CFrame =
                CFrame.new(targetPos) * hrp.CFrame.Rotation
            hrp.Velocity = Vector3.zero
        end

        hum:ChangeState(Enum.HumanoidStateType.Climbing)
        task.wait(MICRO_STEP_INTERVAL)
    end
end

local function healthLockLoop()
    while isWarpFlying do
        if hum and hum.Health < hum.MaxHealth then
            hum.Health = hum.MaxHealth
        end
        RunService.Heartbeat:Wait()
    end
end

local function onDied()
    if hum and isWarpFlying then
        hum.Health = hum.MaxHealth
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end
end

local function startWarpFly()
    if isWarpFlying then return end

    local char = lp.Character
    if not char then return end

    hrp = char:FindFirstChild("HumanoidRootPart")
    hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            originalCanCollide[part] = part.CanCollide
            part.CanCollide = false
        end
    end

    descendantConnection = char.DescendantAdded:Connect(function(desc)
        if desc:IsA("BasePart") then
            originalCanCollide[desc] = desc.CanCollide
            desc.CanCollide = false
        end
    end)

    isWarpFlying = true
    hum:ChangeState(Enum.HumanoidStateType.Climbing)

    microStepConn = task.spawn(microStepLoop)
    healthLockConn = task.spawn(healthLockLoop)
    diedConn = hum.Died:Connect(onDied)
end

local function stopWarpFly()
    isWarpFlying = false
    clearFlyRes()
end

-- ===================== WindUI控件 =====================
-- 放到你脚本里随便哪个标签，例如 Tabs.wj（玩家标签）
Tabs.wj:Toggle({
    Title = "灵魂飞行",
    Desc = "飞行思路来自AF作者秋辞❤️",
    Default = false,
    Callback = function(Value)
        if Value then
            startWarpFly()
        else
            stopWarpFly()
        end
    end
})

Tabs.wj:Slider({
    Title = "飞行速度",
    Desc = "",
    Value = {
        Min = 10,
        Max = 130 ,
        Default = 50
    },
    Step = 1,
    Callback = function(val)
        flySpeed = val
    end
})
-- =================== 旋转模块（完全修复版） ===================

local SpinEnabled = false
local SpinSpeed = 5
local SpinConnection = nil

-- ⭐线程控制（核心修复）
local AnimationLockThread = nil
-- ================= 开始旋转 =================
local function StartSpin()

    if SpinConnection then return end

    local plr = game.Players.LocalPlayer

    SpinConnection = game:GetService("RunService").RenderStepped:Connect(function(dt)

        if not SpinEnabled then return end

        local char = plr.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(SpinSpeed) * dt * 60, 0)

    end)

    ApplyAnimationLock(plr.Character)
end

-- ================= 停止旋转 =================
local function StopSpin()

    SpinEnabled = false -- ⭐必须

    if SpinConnection then
        SpinConnection:Disconnect()
        SpinConnection = nil
    end

    RemoveAnimationLock(game.Players.LocalPlayer.Character)
end

-- ================= 重生修复 =================
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)

    if SpinEnabled then

        task.wait(0.5)

        ApplyAnimationLock(char)

        if not SpinConnection then
            StartSpin()
        end
    end
end)

Tabs.wj:Toggle({
    Title = "人物自转",
    Default = false,
    Callback = function(v)

        SpinEnabled = v

        if v then
            StartSpin()
            AddFeature("自转")
        else
            StopSpin()
            RemoveFeature("自转")
        end

    end
})

-- ⭐ Input → Slider（稳定）
Tabs.wj:Slider({
    Title = "旋转速度",
    Value = {
        Min = 1,
        Max = 200,
        Default = SpinSpeed,
    },
    Increment = 5,
    Callback = function(v)
        SpinSpeed = v
    end
})
-- ============================================
-- WindUI - 其他玩家头部缩放（本地修改）
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- ========== 配置 ==========
local CONFIG = {
    defaultSize = 1,
    minSize = 1,
    maxSize = 5000,
    loadDelay = 0.15,
}

-- ========== 状态管理 ==========
local HeadScaler = {
    enabled = false,
    headSize = CONFIG.defaultSize,
    heartbeatConn = nil,
    playerAddedConn = nil,
    charBindings = {},
    _initialized = false,
}

-- ========== 核心功能 ==========

function HeadScaler:UpdateAllHeads()
    local size = Vector3.new(self.headSize, self.headSize, self.headSize)
    local localPlayer = Players.LocalPlayer
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == localPlayer then continue end
        
        local character = player.Character
        if not character then continue end
        
        local head = character:FindFirstChild("Head")
        if not head then continue end
        
        pcall(function()
            head.Size = size
            head.CanCollide = false
        end)
    end
end

function HeadScaler:BindPlayer(player)
    if self.charBindings[player] then return end
    
    local conn = player.CharacterAdded:Connect(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
    
    self.charBindings[player] = conn
    
    -- 立即处理当前角色
    task.spawn(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
end

function HeadScaler:UnbindPlayer(player)
    local conn = self.charBindings[player]
    if conn then
        conn:Disconnect()
        self.charBindings[player] = nil
    end
end

function HeadScaler:ClearAll()
    -- 清理心跳
    if self.heartbeatConn then
        self.heartbeatConn:Disconnect()
        self.heartbeatConn = nil
    end
    
    -- 清理玩家加入事件
    if self.playerAddedConn then
        self.playerAddedConn:Disconnect()
        self.playerAddedConn = nil
    end
    
    -- 清理所有角色绑定
    for player, conn in pairs(self.charBindings) do
        conn:Disconnect()
        self.charBindings[player] = nil
    end
end

function HeadScaler:SetEnabled(enable)
    if self.enabled == enable then return end
    
    self:ClearAll()
    self.enabled = enable
    
    if not enable then return end
    
    -- 开启功能
    local localPlayer = Players.LocalPlayer
    
    -- 1. 心跳连接
    self.heartbeatConn = RunService.Heartbeat:Connect(function()
        self:UpdateAllHeads()
    end)
    
    -- 2. 绑定已有玩家
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            self:BindPlayer(player)
        end
    end
    
    -- 3. 监听新玩家
    self.playerAddedConn = Players.PlayerAdded:Connect(function(player)
        if player ~= localPlayer then
            self:BindPlayer(player)
        end
    end)
    
    -- 4. 立即执行
    self:UpdateAllHeads()
end

function HeadScaler:SetSize(newSize)
    local clamped = math.clamp(newSize, CONFIG.minSize, CONFIG.maxSize)
    self.headSize = clamped
    
    if self.enabled then
        self:UpdateAllHeads()
    end
end

-- ========== 初始化 ==========

function HeadScaler:Init()
    if self._initialized then return end
    self._initialized = true
    
    -- 玩家离开时自动清理
    Players.PlayerRemoving:Connect(function(player)
        self:UnbindPlayer(player)
    end)
    
    print("[HeadScaler] 初始化完成 ✅")
end

-- ========== WindUI 控件 ==========

-- 初始化
HeadScaler:Init()

-- 🎛️ 开关控件
Tabs.wj:Toggle({
    Title = "修改别人头部大小(仅本地)",
    Default = false,
    Callback = function(value)
        HeadScaler:SetEnabled(value)
    end
})

-- 📝 输入控件
Tabs.wj:Input({
    Title = "别人头部尺寸",
    Placeholder = "输入数字 1-5000",
    Default = tostring(CONFIG.defaultSize),
    Numeric = true,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            HeadScaler:SetSize(num)
        end
    end
})

-- ========== 调试命令 ==========

-- 在控制台输入 HeadScalerStatus() 查看状态
_G.HeadScalerStatus = function()
    local count = 0
    for _ in pairs(HeadScaler.charBindings) do count = count + 1 end
    
    print(string.format(
        [[
📊 HeadScaler 状态
├─ 启用: %s
├─ 尺寸: %.2f
├─ 绑定玩家: %d
└─ 心跳: %s
        ]],
        HeadScaler.enabled and "✅ 是" or "❌ 否",
        HeadScaler.headSize,
        count,
        HeadScaler.heartbeatConn and "🟢 运行中" or "🔴 已停止"
    ))
end

print("💡 输入 HeadScalerStatus() 查看状态")
Tabs.wj:Toggle({
    Title = "无限跳",
    Desc = "",
    Value = false,
    Callback = function(state)
        isInfiniteJumpEnabled = state
    end
})
Tabs.wj:Toggle({
    Title = "穿墙",
    Desc = "",
    Value = false,
    Callback = function(enabled)
        local RunService = game:GetService("RunService")
        local LocalPlayer = game:GetService("Players").LocalPlayer
        if clipConn then
            clipConn:Disconnect()
            clipConn = nil
        end
        if enabled then
            clipConn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        else
            --关闭穿墙：恢复碰撞
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})
Tabs.wj:Button({
    Title = "踏空行走",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))()
    end
})
Tabs.wj:Button({
    Title = "定",
    Callback = function()
        -- 空中定住 + 可拖动GUI（缩小UI版本）
-- LocalScript
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local freeze = false
local lockY = nil
local character
local root
local function LoadCharacter()
	character = player.Character or player.CharacterAdded:Wait()
	root = character:WaitForChild("HumanoidRootPart")
end
LoadCharacter()
player.CharacterAdded:Connect(function()
	task.wait(1)
	LoadCharacter()
end)
-- 创建UI
local gui = Instance.new("ScreenGui")
gui.Name = "AirFreezeUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")
-- 缩小窗口尺寸 原240,140 → 140,90
local main = Instance.new("Frame")
main.Size = UDim2.new(0,90,0,90)
main.Position = UDim2.new(0.5,-70,0.65,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,30)
main.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = main
-- 标题字号缩小
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,26)
title.BackgroundTransparency = 1
title.Text = "定"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 16
title.Parent = main
-- 缩小开关按钮 原170,45 → 100,32，位置居中适配
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0,100,0,32)
toggle.Position = UDim2.new(0.5,-50,0.48,0)
toggle.BackgroundColor3 = Color3.fromRGB(0,170,255)
toggle.Text = "开启"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.TextSize = 14
toggle.Parent = main
local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(0,8)
tc.Parent = toggle
-- 拖动功能（逻辑未改动）
local dragging = false
local dragStart
local startPos
main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch then
		input.Changed:Connect(function()
			if dragging then
				local delta = input.Position - dragStart
				main.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end)
	end
end)
-- 开关切换逻辑不变
toggle.MouseButton1Click:Connect(function()
	freeze = not freeze
	if freeze then
		toggle.Text = "关闭"
		toggle.BackgroundColor3 = Color3.fromRGB(255,70,70)
		if root then
			lockY = root.Position.Y
		end
	else
		toggle.Text = "开启"
		toggle.BackgroundColor3 = Color3.fromRGB(0,170,255)
		lockY = nil
	end
end)
-- 空中锁定逻辑不变
RunService.Heartbeat:Connect(function()
	if freeze and root and lockY then
		local pos = root.Position
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
		root.CFrame =
			CFrame.new(
				pos.X,
				lockY,
				pos.Z
			)
			*
			root.CFrame.Rotation
	end
end)

    end
})
------====---
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local AimConfig = {
    Enabled = false,
    BulletTrack = false,
    FOV = 200,
    Smoothness = 0.15,
    Prediction = 0.12,
    BulletSpeed = 1500,
    BulletDrop = 0,
    WallCheck = true,
    ShowFOV = false,
    ShowTracer = true,
    AimPart = "Head",
    TeamCheck = true,
    JumpPrediction = true,
}
-- FOV圆圈绘图
local aimFOVCircle = Drawing.new("Circle")
aimFOVCircle.Visible = false
aimFOVCircle.Color = Color3.fromRGB(255, 50, 50)
aimFOVCircle.Thickness = 1.5
aimFOVCircle.Filled = false
aimFOVCircle.Transparency = 0.4
aimFOVCircle.NumSides = 64
aimFOVCircle.Radius = AimConfig.FOV
aimFOVCircle.Position = Camera.ViewportSize / 2
-- 瞄准射线
local aimTracer = Drawing.new("Line")
aimTracer.Visible = false
aimTracer.Color = Color3.fromRGB(255, 50, 50)
aimTracer.Thickness = 1.5
aimTracer.Transparency = 0.4
aimTracer.From = Camera.ViewportSize / 2
aimTracer.To = Camera.ViewportSize / 2
local aimTargetPart = nil
local mainConn = nil
-- 寻找准星FOV内最近敌人
local function findClosestPlayer()
    local mousePos = UserInputService:GetMouseLocation()
    local viewportSize = Camera.ViewportSize
    local center = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    local best = nil
    local bestDist = AimConfig.FOV
    for i = 1, #Players:GetPlayers() do
        local player = Players:GetPlayers()[i]
        if player == LocalPlayer then
        elseif player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not hrp or humanoid.Health <= 0 then
            elseif AimConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            else
                local part = player.Character:FindFirstChild(AimConfig.AimPart)
                if not part then part = player.Character:FindFirstChild("Head") end
                if not part then part = hrp end
                if part then
                    local sp, vis = Camera:WorldToViewportPoint(part.Position)
                    if vis and sp.Z < 1000 then
                        local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                        if sd < bestDist then
                            best = part
                            bestDist = sd
                        end
                    end
                end
            end
        end
    end
    return best
end
-- 墙体检测
local function isWallHit(part)
    if not AimConfig.WallCheck then return false end
    local origin = Camera.CFrame.Position
    local dir = (part.Position - origin)
    local rayP = RaycastParams.new()
    rayP.FilterType = Enum.RaycastFilterType.Exclude
    rayP.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local result = workspace:Raycast(origin, dir, rayP)
    if result and not result.Instance:IsDescendantOf(part.Parent) then
        return true
    end
    return false
end
-- 执行相机自瞄
local function doCameraAim()
    if not aimTargetPart or not aimTargetPart.Parent then return end
    local hum = aimTargetPart.Parent:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    if isWallHit(aimTargetPart) then return end
    local dist = (aimTargetPart.Position - Camera.CFrame.Position).Magnitude
    local time = dist / math.max(AimConfig.BulletSpeed, 100)
    local vel = Vector3.zero
    local tHrp = aimTargetPart.Parent:FindFirstChild("HumanoidRootPart")
    if tHrp then
        vel = tHrp.AssemblyLinearVelocity
    end
    local predictPos = aimTargetPart.Position + vel * AimConfig.Prediction
    local dropOffset = Vector3.new(0, -AimConfig.BulletDrop * time * time, 0)
    local jumpOff = Vector3.zero
    if AimConfig.JumpPrediction and tHrp then
        if tHrp.AssemblyLinearVelocity.Y > 10 then
            jumpOff = Vector3.new(0, tHrp.AssemblyLinearVelocity.Y * AimConfig.Prediction * 0.5, 0)
        end
    end
    local targetPos = predictPos + dropOffset + jumpOff
    local targetCF = CFrame.new(Camera.CFrame.Position, targetPos)
    local s = AimConfig.Smoothness
    if s >= 1 then
        Camera.CFrame = targetCF
    else
        Camera.CFrame = Camera.CFrame:Lerp(targetCF, s)
    end
end
------远程击杀*-------
Tabs.jx:Button({
    Title = "远程传送击杀",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E8%BF%9C%E7%A8%8B%E5%87%BB%E6%9D%80.lua"))()
    end
})
Tabs.jx:Button({
    Title = "开启雷达扫描⚠️",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E9%9B%B7%E8%BE%BE%E6%89%AB%E6%8F%8F.lua"))()
    end
})
Tabs.jx:Code({
    Title = "使用方法",
    Code = "先开启ESP查看周围玩家名字再点击你要吸过来的玩家名字并击杀"
})
Tabs.jx:Code({
    Title = "当然你也可以在安全区内击杀玩家",
    Code = "天天开心哦"
})
-- ========== WindUI bot标签页UI控件 ==========
Tabs.bot:Paragraph({
    Title = "🎯自瞄与子弹追踪",
    Desc = "Camera暴力自瞄 + 扩大碰撞箱实现子弹命中",
})
Tabs.bot:Toggle({
    Title = "🎯 自瞄总开关",
    Desc = "暴力Camera自瞄，直接控制视角锁定目标",
    Default = false,
    Callback = function(state)
        AimConfig.Enabled = state
        if state then
            if not mainConn then
                mainConn = RunService.RenderStepped:Connect(function()
                    if not AimConfig.Enabled then
                        aimTargetPart = nil
                        aimFOVCircle.Visible = false
                        aimTracer.Visible = false
                        return
                    end
                    aimFOVCircle.Position = Camera.ViewportSize / 2
                    aimFOVCircle.Radius = AimConfig.FOV
                    aimFOVCircle.Visible = AimConfig.ShowFOV
                    aimTargetPart = findClosestPlayer()
                    doCameraAim()
                    if aimTargetPart and aimTargetPart.Parent then
                        local sp, vis = Camera:WorldToViewportPoint(aimTargetPart.Position)
                        if vis then
                            aimTracer.Visible = AimConfig.ShowTracer
                            aimTracer.From = Camera.ViewportSize / 2
                            aimTracer.To = Vector2.new(sp.X, sp.Y)
                        else
                            aimTracer.Visible = false
                        end
                    else
                        aimTracer.Visible = false
                    end
                end)
            end
        else
            if mainConn then
                mainConn:Disconnect()
                mainConn = nil
            end
            aimTargetPart = nil
            aimFOVCircle.Visible = false
            aimTracer.Visible = false
        end
    end
})
-- ======子弹追踪：扩大HumanoidRootPart碰撞箱【已经修改上色】 =====
local btHbSize = 8
local btHbConn = nil
local function btExpandPlayer(player)
    if player == LocalPlayer then return end
    if AimConfig.TeamCheck and player.Team and player.Team == LocalPlayer.Team then return end
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local size = math.clamp(btHbSize, 0, 100)
    pcall(function()
    hrp.Size = Vector3.new(size, size, size)
    hrp.Transparency = 0.85
    hrp.Color = Color3.fromRGB(190, 190, 190)
    hrp.Material = Enum.Material.Neon
    hrp.CanCollide = false
end)

end
local function btResetPlayer(player)
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    pcall(function()
        hrp.Size = Vector3.new(2, 2, 1)
        hrp.Transparency = 0
        hrp.Color = Color3.fromRGB(163,162,165) --恢复原本灰色
        hrp.Material = Enum.Material.Plastic    --恢复普通材质
        hrp.CanCollide = true
    end)
end
Tabs.bot:Toggle({
    Title = "💣 子弹追踪总开关",
    Desc = "扩大敌人碰撞箱",
    Default = false,
    Callback = function(state)
        AimConfig.BulletTrack = state
        if state then
            if not btHbConn then
                btHbConn = RunService.Heartbeat:Connect(function()
                    if AimConfig.BulletTrack then
                        for i = 1, #Players:GetPlayers() do
                            btExpandPlayer(Players:GetPlayers()[i])
                        end
                    end
                end)
            end
            -- 重生监听
            for i = 1, #Players:GetPlayers() do
                local player = Players:GetPlayers()[i]
                if player ~= LocalPlayer then
                    player.CharacterAdded:Connect(function()
                        task.wait(1)
                        if AimConfig.BulletTrack then
                            btExpandPlayer(player)
                        end
                    end)
                end
            end
        else
            if btHbConn then
                btHbConn:Disconnect()
                btHbConn = nil
            end
            for i = 1, #Players:GetPlayers() do
                btResetPlayer(Players:GetPlayers()[i])
            end
        end
    end
})
Tabs.bot:Slider({
    Title = "📦 判定箱大小",
    Desc = "敌人碰撞箱扩大倍数 (0=关闭,100=巨大)",
    Value = { Min = 0, Max = 100, Default = 8 },
    Step = 1,
    Callback = function(value)
        btHbSize = value
    end
})
Tabs.bot:Slider({
    Title = "🎯 自瞄FOV范围",
    Desc = "屏幕准星搜索范围(像素)",
    Value = { Min = 20, Max = 1000, Default = 200 },
    Step = 10,
    Callback = function(value)
        AimConfig.FOV = value
        aimFOVCircle.Radius = value
    end
})
Tabs.bot:Slider({
    Title = "🔘 平滑系数",
    Desc = "1=瞬间锁头，数值越小越丝滑",
    Value = { Min = 0.01, Max = 1, Default = 0.15 },
    Step = 0.01,
    Callback = function(value)
        AimConfig.Smoothness = value
    end
})
Tabs.bot:Slider({
    Title = "⚡ 预判强度",
    Desc = "预判敌人移动速度",
    Value = { Min = 0, Max = 1, Default = 0.12 },
    Step = 0.01,
    Callback = function(value)
        AimConfig.Prediction = value
    end
})
Tabs.bot:Slider({
    Title = "🔫 子弹速度",
    Desc = "用于弹道预判",
    Value = { Min = 100, Max = 5000, Default = 1500 },
    Step = 50,
    Callback = function(value)
        AimConfig.BulletSpeed = value
    end
})
Tabs.bot:Slider({
    Title = "📉 弹道下坠补偿",
    Desc = "模拟子弹下坠",
    Value = { Min = 0, Max = 200, Default = 0 },
    Step = 1,
    Callback = function(value)
        AimConfig.BulletDrop = value
    end
})
Tabs.bot:Dropdown({
    Title = "🎯 瞄准部位",
    Desc = "优先瞄准身体哪个部位",
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Callback = function(option)
        AimConfig.AimPart = option
    end
})
Tabs.bot:Toggle({
    Title = "🧱 掩体判断",
    Desc = "被墙挡住就不锁定敌人",
    Default = true,
    Callback = function(state)
        AimConfig.WallCheck = state
    end
})
Tabs.bot:Toggle({
    Title = "⭕ 显示FOV圆圈",
    Desc = "屏幕绘制自瞄搜索圈",
    Default = false,
    Callback = function(state)
        AimConfig.ShowFOV = state
    end
})
Tabs.bot:Toggle({
    Title = "📏 显示自瞄射线",
    Desc = "绘制从准星到目标红线",
    Default = true,
    Callback = function(state)
        AimConfig.ShowTracer = state
    end
})
Tabs.bot:Toggle({
    Title = "👥 区分队友",
    Desc = "不会锁定同队伍玩家",
    Default = true,
    Callback = function(state)
        AimConfig.TeamCheck = state
    end
})
Tabs.bot:Toggle({
    Title = "🦘 跳跃预判",
    Desc = "预判敌人向上跳跃位移",
    Default = true,
    Callback = function(state)
        AimConfig.JumpPrediction = state
    end
})
------=======ESP=======---
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

ESP_Config = {
    EnableESP = false,
    ShowBox = true,
    ShowHealth = true,
    ShowName = true,
    ShowDistance = true,
    ShowTracer = false,
    ShowSkeleton = false,
    ShowWeapon = false,
    WallHack = false,
    TeamCheck = false,
    MaxDrawDistance = 350,
    BoxThickness = 1,
    TracerThickness = 1,
    SkeletonThickness = 2,
    EnemyColor = Color3.new(1, 0.3, 0.3),
    TeammateColor = Color3.new(0.3, 1, 0.3),
    NPCColor = Color3.new(1, 1, 0.2),
    BoxColor = Color3.new(1, 1, 1),
    TracerColor = Color3.new(1, 0, 0),
    SkeletonColor = Color3.new(0.2, 0.8, 1),
    HealthBarColor = Color3.new(0, 1, 0),
}

-- Drawing API ESP组件表
local ESPComponents = {}

-- 创建单个玩家的Drawing ESP
local function createESP(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = ESP_Config.BoxColor
    box.Thickness = ESP_Config.BoxThickness
    box.Filled = false

    local healthBar = Drawing.new("Square")
    healthBar.Visible = false
    healthBar.Color = ESP_Config.HealthBarColor
    healthBar.Thickness = 1
    healthBar.Filled = true

    local healthBarBackground = Drawing.new("Square")
    healthBarBackground.Visible = false
    healthBarBackground.Color = Color3.new(0, 0, 0)
    healthBarBackground.Transparency = 0.5
    healthBarBackground.Thickness = 1
    healthBarBackground.Filled = true

    local healthBarBorder = Drawing.new("Square")
    healthBarBorder.Visible = false
    healthBarBorder.Color = Color3.new(1, 1, 1)
    healthBarBorder.Thickness = 1
    healthBarBorder.Filled = false

    local healthText = Drawing.new("Text")
    healthText.Visible = false
    healthText.Color = Color3.new(1, 1, 1)
    healthText.Size = 14
    healthText.Font = Drawing.Fonts.Monospace
    healthText.Outline = true
    healthText.OutlineColor = Color3.new(0, 0, 0)

    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Color = Color3.new(1, 1, 1)
    nameText.Size = 16
    nameText.Font = Drawing.Fonts.Monospace
    nameText.Outline = true
    nameText.OutlineColor = Color3.new(0, 0, 0)

    local distanceText = Drawing.new("Text")
    distanceText.Visible = false
    distanceText.Color = Color3.new(1, 1, 0)
    distanceText.Size = 14
    distanceText.Font = Drawing.Fonts.Monospace
    distanceText.Outline = true
    distanceText.OutlineColor = Color3.new(0, 0, 0)

    local weaponText = Drawing.new("Text")
    weaponText.Visible = false
    weaponText.Color = Color3.new(1, 0.5, 0)
    weaponText.Size = 14
    weaponText.Font = Drawing.Fonts.Monospace
    weaponText.Outline = true
    weaponText.OutlineColor = Color3.new(0, 0, 0)

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = ESP_Config.TracerColor
    tracer.Thickness = ESP_Config.TracerThickness

    -- 骨架线条与头部圆点
    local skeletonLines = {}
    local skeletonPoints = {}

    for i = 1, 15 do
        skeletonLines[i] = Drawing.new("Line")
        skeletonLines[i].Visible = false
        skeletonLines[i].Color = ESP_Config.SkeletonColor
        skeletonLines[i].Thickness = ESP_Config.SkeletonThickness
    end

    skeletonPoints["Head"] = Drawing.new("Circle")
    skeletonPoints["Head"].Visible = false
    skeletonPoints["Head"].Color = Color3.new(1, 0.5, 0)
    skeletonPoints["Head"].Thickness = 2
    skeletonPoints["Head"].Filled = true
    skeletonPoints["Head"].Radius = 4

    local lastHealth = 100
    local healthChangeTime = 0
    local smoothHealth = 100

    ESPComponents[player] = {
        box = box,
        healthBar = healthBar,
        healthBarBackground = healthBarBackground,
        healthBarBorder = healthBarBorder,
        healthText = healthText,
        nameText = nameText,
        distanceText = distanceText,
        weaponText = weaponText,
        tracer = tracer,
        skeletonLines = skeletonLines,
        skeletonPoints = skeletonPoints
    }

    local function hideAll()
        box.Visible = false
        healthBar.Visible = false
        healthBarBackground.Visible = false
        healthBarBorder.Visible = false
        healthText.Visible = false
        nameText.Visible = false
        distanceText.Visible = false
        weaponText.Visible = false
        tracer.Visible = false
        for _, line in pairs(skeletonLines) do
            line.Visible = false
        end
        for _, point in pairs(skeletonPoints) do
            point.Visible = false
        end
    end

    RunService.RenderStepped:Connect(function()
        if not ESP_Config.EnableESP then
            hideAll()
            return
        end
        if not player.Character
            or not player.Character:FindFirstChild("HumanoidRootPart")
            or not player.Character:FindFirstChild("Humanoid")
            or player == LocalPlayer then
            hideAll()
            return
        end

        -- 队友过滤
        if ESP_Config.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            hideAll()
            return
        end

        local character = player.Character
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")

        if not rootPart or not humanoid or humanoid.Health <= 0 then
            hideAll()
            return
        end

        local dist = (rootPart.Position - Camera.CFrame.Position).Magnitude
        if dist > ESP_Config.MaxDrawDistance then
            hideAll()
            return
        end

        local rootPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
        local headPos, _ = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
        local legPos, _ = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))

        -- 判断颜色 (队友/敌人)
        local color = ESP_Config.EnemyColor
        if ESP_Config.TeamCheck and player.Team and player.Team == LocalPlayer.Team then
            color = ESP_Config.TeammateColor
        end

        -- 武器名称
        local weaponName = "无武器"
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                weaponName = tool.Name
                break
            end
        end

        -- 方框透视
        if ESP_Config.ShowBox and onScreen then
            box.Size = Vector2.new(1000 / rootPos.Z, headPos.Y - legPos.Y)
            box.Position = Vector2.new(rootPos.X - box.Size.X / 2, rootPos.Y - box.Size.Y / 2)
            box.Visible = true
            box.Color = ESP_Config.BoxColor
            box.Thickness = ESP_Config.BoxThickness
        else
            box.Visible = false
        end

        -- 血量条
        if ESP_Config.ShowHealth and onScreen then
            local healthPercentage = humanoid.Health / humanoid.MaxHealth
            local barWidth = 50
            local barHeight = 5
            local barX = headPos.X - barWidth / 2
            local barY = headPos.Y - 20

            healthBarBackground.Size = Vector2.new(barWidth, barHeight)
            healthBarBackground.Position = Vector2.new(barX, barY)
            healthBarBackground.Visible = true

            healthBarBorder.Size = Vector2.new(barWidth, barHeight)
            healthBarBorder.Position = Vector2.new(barX, barY)
            healthBarBorder.Visible = true

            smoothHealth = smoothHealth + (humanoid.Health - smoothHealth) * 0.1
            local smoothHP = smoothHealth / humanoid.MaxHealth

            healthBar.Size = Vector2.new(barWidth * smoothHP, barHeight)
            healthBar.Position = Vector2.new(barX, barY)

            -- 血量颜色渐变 (绿>80%, 黄>50%, 橙>20%, 红<20%)
            if smoothHP >= 0.8 then
                healthBar.Color = Color3.new(0, 1, 0)
            elseif smoothHP >= 0.5 then
                healthBar.Color = Color3.new(1, 1, 0)
            elseif smoothHP >= 0.2 then
                healthBar.Color = Color3.new(1, 0.5, 0)
            else
                healthBar.Color = Color3.new(1, 0, 0)
            end

            -- 受伤闪烁
            if humanoid.Health ~= lastHealth then
                healthChangeTime = tick()
                lastHealth = humanoid.Health
            end
            if tick() - healthChangeTime < 0.5 then
                healthBar.Color = Color3.new(1, 0, 0)
            end

            healthBar.Visible = true

            healthText.Position = Vector2.new(barX + barWidth + 5, barY - 5)
            healthText.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
            healthText.Color = color
            healthText.Visible = true
        else
            healthBar.Visible = false
            healthBarBackground.Visible = false
            healthBarBorder.Visible = false
            healthText.Visible = false
        end

        -- 名称 & 距离 & 武器
        if ESP_Config.ShowName and onScreen then
            nameText.Position = Vector2.new(headPos.X, headPos.Y - 35)
            nameText.Text = player.Name
            nameText.Color = color
            nameText.Visible = true

            if ESP_Config.ShowDistance then
                distanceText.Position = Vector2.new(headPos.X, headPos.Y + 10)
                distanceText.Text = math.floor(dist) .. "m"
                distanceText.Visible = true
            else
                distanceText.Visible = false
            end

            if ESP_Config.ShowWeapon then
                weaponText.Position = Vector2.new(headPos.X, headPos.Y - 50)
                weaponText.Text = weaponName
                weaponText.Visible = true
            else
                weaponText.Visible = false
            end
        else
            nameText.Visible = false
            distanceText.Visible = false
            weaponText.Visible = false
        end

        -- 射线透视 (从屏幕底部中心到头部)
        if ESP_Config.ShowTracer then
            local head = character:FindFirstChild("Head")
            if head then
                local hPos, hOnScreen = Camera:WorldToViewportPoint(head.Position)
                if hOnScreen then
                    tracer.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
                    tracer.To = Vector2.new(hPos.X, hPos.Y)
                    tracer.Visible = true
                    tracer.Color = ESP_Config.TracerColor
                    tracer.Thickness = ESP_Config.TracerThickness

                    -- 距离变色
                    if dist < 20 then
                        tracer.Color = Color3.new(0, 1, 0)
                    elseif dist < 50 then
                        tracer.Color = Color3.new(1, 1, 0)
                    else
                        tracer.Color = ESP_Config.TracerColor
                    end
                else
                    tracer.Visible = false
                end
            else
                tracer.Visible = false
            end
        else
            tracer.Visible = false
        end

        -- 骨架透视
        if ESP_Config.ShowSkeleton and onScreen then
            local head = character:FindFirstChild("Head")
            local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
            local leftArm = character:FindFirstChild("Left Arm") or character:FindFirstChild("LeftUpperArm")
            local rightArm = character:FindFirstChild("Right Arm") or character:FindFirstChild("RightUpperArm")
            local leftLeg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftUpperLeg")
            local rightLeg = character:FindFirstChild("Right Leg") or character:FindFirstChild("RightUpperLeg")

            if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                local hP = Camera:WorldToViewportPoint(head.Position)
                local tP = Camera:WorldToViewportPoint(torso.Position)
                local laP = Camera:WorldToViewportPoint(leftArm.Position)
                local raP = Camera:WorldToViewportPoint(rightArm.Position)
                local llP = Camera:WorldToViewportPoint(leftLeg.Position)
                local rlP = Camera:WorldToViewportPoint(rightLeg.Position)

                skeletonPoints["Head"].Position = Vector2.new(hP.X, hP.Y)
                skeletonPoints["Head"].Visible = true

                -- 头->躯干
                skeletonLines[1].From = Vector2.new(hP.X, hP.Y)
                skeletonLines[1].To = Vector2.new(tP.X, tP.Y)
                skeletonLines[1].Visible = true
                -- 躯干->左臂
                skeletonLines[2].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[2].To = Vector2.new(laP.X, laP.Y)
                skeletonLines[2].Visible = true
                -- 躯干->右臂
                skeletonLines[3].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[3].To = Vector2.new(raP.X, raP.Y)
                skeletonLines[3].Visible = true
                -- 躯干->左腿
                skeletonLines[4].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[4].To = Vector2.new(llP.X, llP.Y)
                skeletonLines[4].Visible = true
                -- 躯干->右腿
                skeletonLines[5].From = Vector2.new(tP.X, tP.Y)
                skeletonLines[5].To = Vector2.new(rlP.X, rlP.Y)
                skeletonLines[5].Visible = true

                -- 下臂/下腿 (6-9)
                if character:FindFirstChild("LeftLowerArm") then
                    local pos = Camera:WorldToViewportPoint(character.LeftLowerArm.Position)
                    skeletonLines[6].From = Vector2.new(laP.X, laP.Y)
                    skeletonLines[6].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[6].Visible = true
                end
                if character:FindFirstChild("RightLowerArm") then
                    local pos = Camera:WorldToViewportPoint(character.RightLowerArm.Position)
                    skeletonLines[7].From = Vector2.new(raP.X, raP.Y)
                    skeletonLines[7].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[7].Visible = true
                end
                if character:FindFirstChild("LeftLowerLeg") then
                    local pos = Camera:WorldToViewportPoint(character.LeftLowerLeg.Position)
                    skeletonLines[8].From = Vector2.new(llP.X, llP.Y)
                    skeletonLines[8].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[8].Visible = true
                end
                if character:FindFirstChild("RightLowerLeg") then
                    local pos = Camera:WorldToViewportPoint(character.RightLowerLeg.Position)
                    skeletonLines[9].From = Vector2.new(rlP.X, rlP.Y)
                    skeletonLines[9].To = Vector2.new(pos.X, pos.Y)
                    skeletonLines[9].Visible = true
                end
            else
                for _, line in pairs(skeletonLines) do line.Visible = false end
                for _, point in pairs(skeletonPoints) do point.Visible = false end
            end
        else
            for _, line in pairs(skeletonLines) do line.Visible = false end
            for _, point in pairs(skeletonPoints) do point.Visible = false end
        end
    end)
end

-- 清理玩家ESP Drawing对象
local function cleanupESP(player)
    if ESPComponents[player] then
        local comps = ESPComponents[player]
        for key, component in pairs(comps) do
            if typeof(component) == "table" then
                for _, drawing in pairs(component) do
                    if typeof(drawing) == "userdata" then
                        pcall(function() drawing:Remove() end)
                    end
                end
            else
                if typeof(component) == "userdata" then
                    pcall(function() component:Remove() end)
                end
            end
        end
        ESPComponents[player] = nil
    end
end

-- 为现有玩家创建ESP
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESP(player)
    end
end

-- 新玩家加入时创建ESP
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createESP(player)
    end
end)

-- 玩家离开时清理ESP
Players.PlayerRemoving:Connect(function(player)
    cleanupESP(player)
end)

-- ================= HB Tabs.zho UI控制面板 =================
Tabs.ESP:Paragraph({
    Title = "ESP透视设置",
    Desc = "Drawing API高性能透视",
    ImageSize = 22,
    ThumbnailSize = 0
})

-- ESP总开关
Tabs.ESP:Toggle({
    Title = "开启ESP总开关",
    Desc = "全局启用透视",
    Default = false,
    Callback = function(state)
        ESP_Config.EnableESP = state
        if not state then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    if ESPComponents[player] then
                        for key, component in pairs(ESPComponents[player]) do
                            if typeof(component) == "table" then
                                for _, drawing in pairs(component) do
                                    if typeof(drawing) == "userdata" then
                                        pcall(function() drawing.Visible = false end)
                                    end
                                end
                            else
                                if typeof(component) == "userdata" then
                                    pcall(function() component.Visible = false end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
})

-- 显示信息开关
Tabs.ESP:Toggle({
    Title = "显示头顶名称",
    Desc = "玩家ID",
    Default = true,
    Callback = function(v) ESP_Config.ShowName = v end
})
Tabs.ESP:Toggle({
    Title = "显示血量",
    Default = true,
    Callback = function(v) ESP_Config.ShowHealth = v end
})
Tabs.ESP:Toggle({
    Title = "显示距离",
    Default = true,
    Callback = function(v) ESP_Config.ShowDistance = v end
})

-- 功能开关
Tabs.ESP:Toggle({
    Title = "方框透视",
    Desc = "2D方框",
    Default = true,
    Callback = function(v) ESP_Config.ShowBox = v end
})
Tabs.ESP:Toggle({
    Title = "射线透视",
    Desc = "从屏幕顶部",
    Default = false,
    Callback = function(v) ESP_Config.ShowTracer = v end
})
Tabs.ESP:Toggle({
    Title = "骨架透视",
    Desc = "骨骼线条",
    Default = false,
    Callback = function(v) ESP_Config.ShowSkeleton = v end
})
Tabs.ESP:Toggle({
    Title = "武器显示",
    Desc = "显示手持武器名",
    Default = false,
    Callback = function(v) ESP_Config.ShowWeapon = v end
})
Tabs.ESP:Toggle({
    Title = "穿墙ESP",
    Desc = "墙体遮挡依旧显示",
    Default = false,
    Callback = function(v) ESP_Config.WallHack = v end
})
Tabs.ESP:Toggle({
    Title = "区分队友颜色",
    Desc = "队友绿/敌人红/NPC黄",
    Default = false,
    Callback = function(v) ESP_Config.TeamCheck = v end
})

-- 可视距离滑块
Tabs.ESP:Slider({
    Title = "ESP最大可视距离",
    Desc = "超出距离不渲染",
    Value = {Min=50, Max=1000, Default=350},
    Step = 10,
    IsTextbox = true,
    Callback = function(val) ESP_Config.MaxDrawDistance = val end
})
---------ESP2-----
-- ==============================================
-- ESP完整版｜直接挂载 Tabs.ESPP｜Toggle开关
-- 依赖：外部已加载WindUI，已定义 Tabs.ESPP
-- ==============================================
local FONT_SIZE = 16        
local FONT_NAME = Drawing.Fonts.Monospace
local MAX_DISTANCE = 1500   
local BOX_THICKNESS = 1     
local BOX_SCALE = 2.2       

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPEnabled = false
local DrawBox = false
local DrawDistance = false
local DrawName = false
local DrawTracer = false
local DrawHealth = false

local ESPObjects = {}
local ESP_RenderConn = nil
local ESP_Initialized = false

local function WorldToScreen(worldPos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(worldPos)
    if not onScreen then return nil end
    return Vector2.new(screenPos.X, screenPos.Y)
end

local function GetCharacterData(player)
    local char = player.Character
    if not char then return nil end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    local head = char:FindFirstChild("Head")
    if not humanoid or not root or not head then return nil end
    return char, humanoid, root, head
end

local function CreateDrawingObjects()
    local objs = {}
    objs.Box = Drawing.new("Square")
    objs.Box.Filled = false
    objs.Box.Transparency = 1
    
    objs.Name = Drawing.new("Text")
    objs.Name.Size = FONT_SIZE
    objs.Name.Center = true
    objs.Name.Outline = true
    objs.Name.Font = FONT_NAME
    
    objs.Distance = Drawing.new("Text")
    objs.Distance.Size = FONT_SIZE - 2
    objs.Distance.Center = true
    objs.Distance.Outline = true
    objs.Distance.Font = FONT_NAME
    
    objs.Health = Drawing.new("Text")
    objs.Health.Size = FONT_SIZE - 2
    objs.Health.Center = true
    objs.Health.Outline = true
    objs.Health.Font = FONT_NAME
    
    objs.Tracer = Drawing.new("Line")
    objs.Tracer.Thickness = 1
    objs.Tracer.Transparency = 0.5
    return objs
end

local function DestroyDrawingObjects(objs)
    if not objs then return end
    for _, obj in pairs(objs) do
        if obj and obj.Remove then
            pcall(function() obj:Remove() end)
        end
    end
end

local function UpdatePlayerESP(player, objs)
    if player == LocalPlayer then return end
    local char, humanoid, root, head = GetCharacterData(player)

    if not char or not humanoid or humanoid.Health <= 0 then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end

    local distance = (Camera.CFrame.Position - root.Position).Magnitude
    if distance > MAX_DISTANCE then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end

    local headScreen = WorldToScreen(head.Position + Vector3.new(0, 0.5, 0))
    local rootScreen = WorldToScreen(root.Position)
    if not headScreen or not rootScreen then
        for _, obj in pairs(objs) do obj.Visible = false end
        return
    end

    local height = math.abs(headScreen.Y - rootScreen.Y) * BOX_SCALE
    local width = height * 0.65
    height = math.max(height, 15)
    width = math.max(width, 10)

    local topLeft = Vector2.new(headScreen.X - width / 2, headScreen.Y - height * 0.2)
    local bottomRight = Vector2.new(headScreen.X + width / 2, topLeft.Y + height)

    if DrawBox then
        objs.Box.Visible = true
        objs.Box.Size = bottomRight - topLeft
        objs.Box.Position = topLeft
        objs.Box.Thickness = BOX_THICKNESS
        local healthPercent = humanoid.Health / humanoid.MaxHealth
        if healthPercent > 0.5 then
            objs.Box.Color = Color3.fromRGB(0, 255, 0)
        elseif healthPercent > 0.25 then
            objs.Box.Color = Color3.fromRGB(255, 165, 0)
        else
            objs.Box.Color = Color3.fromRGB(255, 0, 0)
        end
    else
        objs.Box.Visible = false
    end

    if DrawName then
        objs.Name.Visible = true
        objs.Name.Text = player.Name
        objs.Name.Color = Color3.fromRGB(255, 255, 255)
        objs.Name.Position = Vector2.new(headScreen.X, topLeft.Y - FONT_SIZE - 2)
    else
        objs.Name.Visible = false
    end

    if DrawDistance then
        objs.Distance.Visible = true
        objs.Distance.Text = string.format("[%d m]", math.floor(distance))
        objs.Distance.Color = Color3.fromRGB(200, 200, 200)
        objs.Distance.Position = Vector2.new(headScreen.X, bottomRight.Y + 2)
    else
        objs.Distance.Visible = false
    end

    if DrawHealth then
        objs.Health.Visible = true
        objs.Health.Text = string.format("HP: %d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
        objs.Health.Color = Color3.fromRGB(0, 255, 0)
        objs.Health.Position = Vector2.new(headScreen.X, bottomRight.Y + FONT_SIZE + 2)
    else
        objs.Health.Visible = false
    end

    if DrawTracer then
        objs.Tracer.Visible = true
        objs.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, 0)
        objs.Tracer.To = Vector2.new(headScreen.X, bottomRight.Y)
        objs.Tracer.Color = Color3.fromRGB(255, 255, 255)
    else
        objs.Tracer.Visible = false
    end
end

local function InitPlayer(player)
    if player == LocalPlayer then return end
    if ESPObjects[player] then DestroyDrawingObjects(ESPObjects[player]) end
    ESPObjects[player] = CreateDrawingObjects()
end

-- 【ESP初始化按钮】
Tabs.ESPP:Button({
    Title = "初始化ESP",
    Callback = function()
        if ESP_Initialized then
            print("⚠️ ESP已经初始化，无需重复点击")
            return
        end

        ESP_Initialized = true
        for _, player in ipairs(Players:GetPlayers()) do InitPlayer(player) end

        Players.PlayerAdded:Connect(InitPlayer)
        Players.PlayerRemoving:Connect(function(player)
            if ESPObjects[player] then
                DestroyDrawingObjects(ESPObjects[player])
                ESPObjects[player] = nil
            end
        end)

        ESP_RenderConn = RunService.RenderStepped:Connect(function()
            if not ESPEnabled then return end
            for player, objs in pairs(ESPObjects) do
                if player.Parent then
                    pcall(UpdatePlayerESP, player, objs)
                else
                    DestroyDrawingObjects(objs)
                    ESPObjects[player] = nil
                end
            end
        end)
        print("✅ ESP初始化完成，请使用下方Toggle开关控制功能")
    end
})

--========================= Toggle全部挂载 Tabs.ESPP =========================
Tabs.ESPP:Toggle({
    Title = "ESP总开关",
    Value = false,
    Callback = function(s)
        ESPEnabled = s
        print("ESP总开关：", s and "✅开启" or "❌关闭")
        if not s then
            for _, objs in pairs(ESPObjects) do
                for _, obj in pairs(objs) do obj.Visible = false end
            end
        end
    end
})

Tabs.ESPP:Toggle({
    Title = "玩家方框",
    Value = false,
    Callback = function(s)
        DrawBox = s
        print("玩家方框：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "玩家名字",
    Value = false,
    Callback = function(s)
        DrawName = s
        print("玩家名字：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "玩家距离",
    Value = false,
    Callback = function(s)
        DrawDistance = s
        print("玩家距离：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "生命值",
    Value = false,
    Callback = function(s)
        DrawHealth = s
        print("生命值：", s and "✅开启" or "❌关闭")
    end
})

Tabs.ESPP:Toggle({
    Title = "射线",
    Value = false,
    Callback = function(s)
        DrawTracer = s
        print("射线：", s and "✅开启" or "❌关闭")
    end
})

-- =================滑块设置=================
Tabs.ESPP:Slider({
    Title = "最大渲染距离",
    Desc = "超过这个距离的玩家将不绘制",
    Value = {Min=500, Max=5000, Default=1500},
    Step = 100,
    IsTextbox = true,
    Callback = function(value)
        MAX_DISTANCE = value
    end
})

Tabs.ESPP:Slider({
    Title = "方框大小倍数",
    Desc = "数值越大方框越大",
    Value = {Min=1.5, Max=3.0, Default=2.2},
    Step = 0.1,
    IsTextbox = true,
    Callback = function(value)
        BOX_SCALE = value
    end
})

Tabs.ESPP:Slider({
    Title = "方框线条粗细",
    Desc = "数字越大线条越粗",
    Value = {Min=1, Max=5, Default=1},
    Step = 1,
    IsTextbox = true,
    Callback = function(value)
        BOX_THICKNESS = value
    end
})

------esp-------
Tabs.wb:Button({
    Title = "检查全局看有人偷吃印钞机没有",
    Callback = function()
        -- ====== 全局搜索 MoneyPrinter（印钞机） ======
local targetName = "MoneyPrinter"

-- ====== 创建MoneyPrinter的ESP（绿色/金钱风格） ======
local function createMoneyPrinterESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 绿色高亮（金钱风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0, 0.8, 0.2)           -- 绿色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.3, 1, 0.3)        -- 亮绿边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 180, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "有人在偷吃印钞机 MoneyPrinter"
    textLabel.TextColor3 = Color3.new(0.3, 1, 0.3)          -- 亮绿文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💰 MoneyPrinter 已标记!")
end

-- ====== 搜索全图所有 MoneyPrinter ======
local function searchAllMoneyPrinters()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createMoneyPrinterESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllMoneyPrinters()
print("✅ 找到 " .. total .. " 个 MoneyPrinter")
print("✅ MoneyPrinter 透视已启动 (绿色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createMoneyPrinterESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 MoneyPrinter")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createMoneyPrinterESP(newObj)
            print("💰 检测到新的 MoneyPrinter!")
        end
    end
end)

print("✅ 全图 MoneyPrinter（印钞机）透视已启动 (自动刷新)")
    end
})
local wbSec1 = Tabs.wb:Section({ Title = "变卖物" })
wbSec1:Button({
    Title = "金块",
    Callback = function()
        -- ====== 获取Gizmos容器 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")

if not gizmos then
    warn("Gizmos不存在")
    return
end

-- ====== 检查是否为 Gold Bar（精确匹配） ======
local function isGoldBar(obj)
    return obj.Name == "Gold Bar"
end

-- ====== 创建Gold Bar ESP（金色） ======
local function createGoldBarESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 金色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.8, 0)            -- 金色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 1, 0)           -- 亮黄色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 1000
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "金块 " .. obj.Name
    textLabel.TextColor3 = Color3.new(1, 0.8, 0)           -- 金色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root and obj:IsA("BasePart") then
                local dist = (root.Position - obj.Position).Magnitude
                distLabel.Text = string.format(" %.1fm", dist)
            elseif root and obj:IsA("Model") and obj.PrimaryPart then
                local dist = (root.Position - obj.PrimaryPart.Position).Magnitude
                distLabel.Text = string.format(" %.1fm", dist)
            end
        end)
    end
    
    print("⭐ Gold Bar 已标记!")
end

-- ====== 递归搜索所有 Gold Bar ======
local function searchGoldBar(parent)
    local count = 0
    for _, obj in ipairs(parent:GetChildren()) do
        -- 检查当前物体
        if (obj:IsA("BasePart") or obj:IsA("Model")) and isGoldBar(obj) then
            createGoldBarESP(obj)
            count = count + 1
        end
        
        -- 如果是文件夹或模型，深入搜索
        if obj:IsA("Folder") or obj:IsA("Model") then
            count = count + searchGoldBar(obj)
        end
    end
    return count
end

-- ====== 执行扫描 ======
local total = searchGoldBar(gizmos)
print("✅ 找到 " .. total .. " 个 Gold Bar")

-- ====== 监听新增 Gold Bar ======
gizmos.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and isGoldBar(newObj) then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createGoldBarESP(newObj)
            print("⭐ 新增 Gold Bar")
        end
    end
end)

print("✅ Gold Bar 透视已启动（仅精确匹配）")
    end
})
wbSec1:Button({
    Title = "BTCESP",
    Callback = function()
        -- ====== 全局搜索 Bitcoin ======
local targetName = "Bitcoin"

-- ====== 创建Bitcoin的ESP（橙色/加密货币风格） ======
local function createBitcoinESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 橙色高亮（比特币风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.6, 0)            -- 橙色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(1, 0.8, 0.2)       -- 金色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "比特币 Bitcoin"
    textLabel.TextColor3 = Color3.new(1, 0.7, 0.1)          -- 金色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("₿ Bitcoin 已标记!")
end

-- ====== 搜索全图所有 Bitcoin ======
local function searchAllBitcoin()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createBitcoinESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllBitcoin()
print("✅ 找到 " .. total .. " 个 Bitcoin")
print("✅ Bitcoin 透视已启动 (橙色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createBitcoinESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 Bitcoin")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createBitcoinESP(newObj)
            print("₿ 检测到新的 Bitcoin!")
        end
    end
end)

print("✅ 全图 Bitcoin 透视已启动 (自动刷新)")
    end
})
wbSec1:Button({
    Title = "紫宝石",
    Callback = function()
        -- ====== 扫描并透视所有宝石 ======
local function createGemESP(obj, color, icon)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = color
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = color
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = icon .. " " .. obj.Name
    textLabel.TextColor3 = color
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💎紫宝石 " .. obj.Name .. " 已标记!")
end

-- ====== 获取Gizmos容器 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")

if not gizmos then
    warn("Gizmos不存在")
    return
end

-- ====== 定义宝石颜色 ======
local gemColors = {
    ["Sapphire"] = {color = Color3.new(0.6, 0, 1), icon = "💎"},
}

-- ====== 扫描Gizmos下所有宝石 ======
local function scanAllGems()
    local count = 0
    for _, obj in ipairs(gizmos:GetChildren()) do
        local gemInfo = gemColors[obj.Name]
        if gemInfo and (obj:IsA("Model") or obj:IsA("BasePart")) then
            createGemESP(obj, gemInfo.color, gemInfo.icon)
            count = count + 1
        end
    end
    print("✅ 已标记 " .. count .. " 个宝石")
end

-- 执行
scanAllGems()

-- ====== 每5秒重新扫描 ======
spawn(function()
    while true do
        wait(5)
        -- 检查所有宝石是否还有ESP
        for _, obj in ipairs(gizmos:GetChildren()) do
            local gemInfo = gemColors[obj.Name]
            if gemInfo and (obj:IsA("Model") or obj:IsA("BasePart")) then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createGemESP(obj, gemInfo.color, gemInfo.icon)
                end
            end
        end
    end
end)

print("✅ 所有宝石透视已启动")
    end
})
wbSec1:Button({
    Title = "保险箱",
    Callback = function()
-- ====== 全局搜索 SafeDoor ======
local targetName = "SafeDoor"

-- ====== 创建SafeDoor的ESP（金色/保险柜风格） ======
local function createSafeDoorESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 金色高亮（保险柜风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.7, 0)            -- 金色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.9, 0.3)       -- 亮金边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "保险箱 SafeDoor"
    textLabel.TextColor3 = Color3.new(1, 0.8, 0)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔐 SafeDoor 已标记!")
end

-- ====== 搜索所有SafeDoor ======
local function searchAllSafeDoors()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createSafeDoorESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllSafeDoors()
print("✅ 找到 " .. total .. " 个 SafeDoor")
print("✅ SafeDoor 透视已启动 (金色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createSafeDoorESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 SafeDoor")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createSafeDoorESP(newObj)
            print(" 检测到新的 SafeDoor!")
        end
    end
end)

print("✅ SafeDoor 透视已启动 (全局搜索 + 自动刷新)")
    end
})

wbSec1:Button({
    Title = "紫水晶",
    Callback = function()
        -- ====== 获取Amethyst Ring ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
local amethystRing = gizmos and gizmos:FindFirstChild("Amethyst Ring")

if not amethystRing then
    warn("Amethyst Ring 不存在")
    return
end

-- ====== 创建Amethyst Ring的ESP（紫色） ======
local function createAmethystRingESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 紫色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.7, 0.2, 1)           -- 紫罗兰色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(0.9, 0.4, 1)        -- 亮紫边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " 紫水晶"
    textLabel.TextColor3 = Color3.new(0.8, 0.3, 1)          -- 紫色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💍 Amethyst Ring 已标记!")
end

-- 执行
createAmethystRingESP(amethystRing)
print("✅ Amethyst Ring 透视已启动")
    end
})

local wbSec2 = Tabs.wb:Section({ Title = "枪械显示" })
wbSec2:Button({
    Title = "AK47",
    Callback = function()
        -- ====== 获取AK-47 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
local pelicanCase = gizmos and gizmos:FindFirstChild("PelicanCase")
local ak47 = pelicanCase and pelicanCase:FindFirstChild("AK-47")

if not ak47 then
    warn("AK-47 不存在，请检查路径")
    return
end

-- ====== 创建AK-47的ESP ======
local function createAK47ESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 高亮（红色/橙色，醒目）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.2, 0)            -- 红橙色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0, 0)           -- 红色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（MaxDistance = 0 无限远）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 35)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0  -- 无限远
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "AK-47"
    textLabel.TextColor3 = Color3.new(1, 0.3, 0)           -- 橙色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                -- 获取位置
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" AK-47 已标记!")
end

-- 执行
createAK47ESP(ak47)
print("✅ AK-47 透视已启动")
    end
})

wbSec2:Button({
    Title = "AUG A1",
    Callback = function()
        -- ====== 全局搜索 AUG A1 ======
local targetName = "AUG A1"

-- ====== 创建AUG A1的ESP（紫色/步枪风格） ======
local function createAUGESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 紫色高亮（科技/步枪风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.6, 0.2, 1)           -- 紫色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.8, 0.4, 1)        -- 亮紫边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 28)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "AUG A1"
    textLabel.TextColor3 = Color3.new(0.7, 0.3, 1)          -- 紫色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔫 AUG A1 已标记!")
end

-- ====== 搜索全图所有 AUG A1 ======
local function searchAllAUG()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createAUGESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllAUG()
print("✅ 找到 " .. total .. " 个 AUG A1")
print("✅ AUG A1 透视已启动 (紫色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createAUGESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 AUG A1")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createAUGESP(newObj)
            print("🔫 检测到新的 AUG A1!")
        end
    end
end)

print("✅ 全图 AUG A1 透视已启动 (自动刷新)")
    end
})
wbSec2:Button({
    Title = "米拉玛狙神AWM",
    Callback = function()
        -- ====== 全局搜索 AWM（仅绘制可交互物品） ======
local targetName = "AWM"

-- ====== 检查物品是否可交互 ======
local function isInteractable(obj)
    if obj:FindFirstChild("ClickDetector") then
        return true
    end
    if obj:FindFirstChild("ProximityPrompt") then
        return true
    end
    if obj:FindFirstChild("TouchInterest") then
        return true
    end
    if obj:IsA("Tool") then
        return true
    end
    if obj:FindFirstChild("Handle") then
        return true
    end
    
    if obj.Parent then
        if obj.Parent:FindFirstChild("ClickDetector") then
            return true
        end
        if obj.Parent:FindFirstChild("ProximityPrompt") then
            return true
        end
        if obj.Parent:FindFirstChild("TouchInterest") then
            return true
        end
        if obj.Parent:IsA("Tool") then
            return true
        end
        if obj.Parent:FindFirstChild("Handle") then
            return true
        end
    end
    
    for _, child in ipairs(obj:GetChildren()) do
        if child:IsA("ClickDetector") or child:IsA("ProximityPrompt") or child:IsA("TouchInterest") then
            return true
        end
        if child.Name == "Handle" then
            return true
        end
    end
    
    return false
end

-- ====== 创建AWM的ESP ======
local function createAWMESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.3, 0.3, 0.3)
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(1, 0.2, 0.2)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（尺寸调小）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 140, 0, 25)              -- 从200x55改为140x40
    billboard.StudsOffset = Vector3.new(0, 3, 0)           -- 从4改为3
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称（字体调小）
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " AWM"
    textLabel.TextColor3 = Color3.new(1, 0.3, 0.3)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离（字体调小）
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "📏 --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🎯 AWM 已标记 (可交互)")
end

-- ====== 搜索并绘制 ======
local function searchAndDrawAWM()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            if isInteractable(obj) then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createAWMESP(obj)
                    count = count + 1
                end
            end
        end
    end
    return count
end

local total = searchAndDrawAWM()
print("✅ 找到 " .. total .. " 个可交互的 AWM")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if isInteractable(obj) and not obj:FindFirstChild("ESP_Highlight") then
                    createAWMESP(obj)
                    count = count + 1
                end
            end
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if isInteractable(newObj) and not newObj:FindFirstChild("ESP_Highlight") then
            createAWMESP(newObj)
        end
    end
end)

print("✅ AWM 透视已启动 (仅可交互, 字体已调小)")
    end
})
wbSec2:Button({
    Title = "M4A1",
    Callback = function()
       -- ====== 获取M4A1（支持自动重连） ======
local function getM4A1()
    local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
    local pelicanCase = gizmos and gizmos:FindFirstChild("PelicanCase")
    return pelicanCase and pelicanCase:FindFirstChild("M4A1")
end

-- ====== 创建M4A1的ESP ======
local function createM4A1ESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 高亮（蓝色/青色，与AK-47区分）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0, 0.5, 1)
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(0, 1, 1)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " M4A1"
    textLabel.TextColor3 = Color3.new(0, 0.6, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔫 M4A1 已标记!")
end

-- ====== 🔄 循环检测 + 绘制 ======
local function startLoopESP()
    local lastM4A1 = nil
    
    game:GetService("RunService").Heartbeat:Connect(function()
        local currentM4A1 = getM4A1()
        
        -- 如果M4A1存在且不是同一个对象实例（重新生成），重新绘制
        if currentM4A1 and currentM4A1 ~= lastM4A1 then
            -- 清理旧ESP（如果对象变了）
            if lastM4A1 then
                local oldHighlight = lastM4A1:FindFirstChild("ESP_Highlight")
                if oldHighlight then oldHighlight:Destroy() end
                local oldTag = lastM4A1:FindFirstChild("ESP_Tag")
                if oldTag then oldTag:Destroy() end
            end
            
            createM4A1ESP(currentM4A1)
            lastM4A1 = currentM4A1
        end
        
        -- 如果M4A1丢失，重置状态
        if not currentM4A1 then
            lastM4A1 = nil
        end
    end)
end

-- 启动循环
startLoopESP()
print("✅ M4A1 循环透视已启动（自动重连）")
    end
})

wbSec2:Button({
    Title = "RPG",
    Callback = function()
        -- ====== 全局搜索 RPG-7 ======
local targetName = "RPG-7"

-- ====== 创建RPG-7的ESP（火箭筒风格） ======
local function createRPG7ESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 橙色/红色高亮（爆炸物风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0.5, 0)            -- 橙色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.2, 0)         -- 红色边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " RPG-7"
    textLabel.TextColor3 = Color3.new(1, 0.5, 0)           -- 橙色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" RPG-7 已标记!")
end

-- ====== 获取 PelicanCase 并搜索 ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
local pelicanCase = gizmos and gizmos:FindFirstChild("PelicanCase")

if not pelicanCase then
    warn("PelicanCase 不存在")
    -- 全局搜索
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createRPG7ESP(obj)
            count = count + 1
        end
    end
    print("✅ 全局搜索找到 " .. count .. " 个 RPG-7")
else
    -- 在 PelicanCase 中搜索
    local count = 0
    for _, obj in ipairs(pelicanCase:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createRPG7ESP(obj)
            count = count + 1
        end
    end
    print("✅ PelicanCase 中找到 " .. count .. " 个 RPG-7")
end

print("✅ RPG-7 火箭筒透视已启动")

-- ====== 每5秒重新搜索 ======
local function rescanRPG7()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            if not obj:FindFirstChild("ESP_Highlight") then
                createRPG7ESP(obj)
                count = count + 1
            end
        end
    end
    
    if count > 0 then
        print("🔄 重新搜索: 找到并标记 " .. count .. " 个 RPG-7")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanRPG7()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})
wbSec2:Button({
    Title = "ARX-160",
    Callback = function()
        -- ====== 全局搜索 ARX-160 ======
local targetName = "ARX-160"

-- ====== 创建ARX-160的ESP（蓝色/突击步枪风格） ======
local function createARX160ESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 蓝色高亮（突击步枪风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.2, 0.5, 1)           -- 亮蓝色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.4, 0.7, 1)        -- 淡蓝边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = " ARX-160"
    textLabel.TextColor3 = Color3.new(0.3, 0.6, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔫 ARX-160 已标记!")
end

-- ====== 搜索全图所有 ARX-160 ======
local function searchAllARX160()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createARX160ESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllARX160()
print("✅ 找到 " .. total .. " 个 ARX-160")
print("✅ ARX-160 透视已启动 (蓝色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createARX160ESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 ARX-160")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(0.1)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createARX160ESP(newObj)
            print("🔫 检测到新的 ARX-160!")
        end
    end
end)

print("✅ 全图 ARX-160 透视已启动 (自动刷新)")
    end
})
wbSec1:Button({
    Title = "货物卡",
    Callback = function()
        -- ====== 获取Cargo Card ======
local localContainer = workspace:FindFirstChild("Local")
local tools = localContainer and localContainer:FindFirstChild("Tools")
local cargoCard = tools and tools:FindFirstChild("Cargo Card")

if not cargoCard then
    warn("Cargo Card 不存在，请检查路径: workspace.Local.Tools")
    return
end

-- ====== 创建Cargo Card的ESP（蓝色卡片样式） ======
local function createCargoCardESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 蓝色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.2, 0.4, 1)           -- 亮蓝色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.5, 0.7, 1)        -- 淡蓝边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（蓝色卡片风格）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 220, 0, 60)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 背景（蓝色卡片）
    local background = Instance.new("Frame")
    background.Name = "CardBackground"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.new(0.1, 0.2, 0.5) -- 深蓝背景
    background.BackgroundTransparency = 0.2
    background.BorderSizePixel = 2
    background.BorderColor3 = Color3.new(0.3, 0.6, 1)       -- 亮蓝边框
    background.Parent = billboard
    
    -- 卡片图标
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0.2, 0, 1, 0)
    iconLabel.Position = UDim2.new(0, 5, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = "💳"
    iconLabel.TextColor3 = Color3.new(1, 1, 1)
    iconLabel.TextScaled = true
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.Parent = billboard
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0.2, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "💳 Cargo Card"
    textLabel.TextColor3 = Color3.new(0.5, 0.8, 1)          -- 淡蓝文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    distLabel.Position = UDim2.new(0.2, 0, 0.55, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "📏 --m"
    distLabel.TextColor3 = Color3.new(0.7, 0.9, 1)          -- 更淡的蓝
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format("📏 %.1fm", dist)
                end
            end
        end)
    end
    
    print("💳 Cargo Card 已标记!")
end

-- ====== 执行ESP ======
createCargoCardESP(cargoCard)
print("✅ Cargo Card 透视已启动 (蓝色卡片样式)")

-- ====== 每5秒重新搜索一遍 ======
local function rescanCargoCard()
    -- 重新获取Cargo Card（防止路径变化）
    local newLocalContainer = workspace:FindFirstChild("Local")
    local newTools = newLocalContainer and newLocalContainer:FindFirstChild("Tools")
    local newCargoCard = newTools and newTools:FindFirstChild("Cargo Card")
    
    if newCargoCard then
        -- 检查是否已有ESP，没有则创建
        if not newCargoCard:FindFirstChild("ESP_Highlight") then
            createCargoCardESP(newCargoCard)
            print("🔄 重新搜索: 找到并标记 Cargo Card")
        end
    else
        print("🔄 重新搜索: Cargo Card 未找到")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    -- 使用计时器，每5秒执行
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanCargoCard()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})

wbSec1:Button({
    Title = "红宝石",
    Callback = function()
        -- ====== 获取所有Ruby ======
local gizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")

if not gizmos then
    warn("Gizmos 不存在")
    return
end

-- ====== 创建Ruby的ESP（红色） ======
local function createRubyESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 红色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0, 0)              -- 红色
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.3, 0.3)       -- 亮红边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签（MaxDistance = 0 无限远）
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 180, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0  -- 无限远
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "🔴红宝石 Ruby"
    textLabel.TextColor3 = Color3.new(1, 0, 0)             -- 红色文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                -- 获取位置
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("🔴 Ruby 已标记!")
end

-- ====== 扫描所有Ruby ======
local function scanAllRuby()
    local count = 0
    for _, obj in ipairs(gizmos:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == "Ruby" then
            createRubyESP(obj)
            count = count + 1
        end
    end
    print("✅ 找到 " .. count .. " 个 Ruby")
end

-- 执行扫描
scanAllRuby()
print("✅ Ruby 透视已启动")

-- ====== 每5秒重新搜索一遍 ======
local function rescanRuby()
    local newGizmos = workspace.Local and workspace.Local:FindFirstChild("Gizmos")
    if not newGizmos then
        print("🔄 重新搜索: Gizmos 不存在")
        return
    end
    
    local count = 0
    for _, obj in ipairs(newGizmos:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == "Ruby" then
            if not obj:FindFirstChild("ESP_Highlight") then
                createRubyESP(obj)
                count = count + 1
            end
        end
    end
    
    if count > 0 then
        print("🔄 重新搜索: 找到并标记 " .. count .. " 个 Ruby")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanRuby()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})
wbSec1:Button({
    Title = "GPU",
    Callback = function()
        -- ====== 全局搜索 GPU（调试版） ======
local targetName = "GPU"

print("🔍 开始搜索 GPU...")

-- ====== 创建GPU的ESP ======
local function createGPUESP(obj)
    -- 避免重复添加
    if obj:FindFirstChild("ESP_Highlight") then
        print("⚠️ GPU 已有ESP，跳过: " .. obj:GetFullName())
        return
    end
    
    print("✅ 正在标记GPU: " .. obj:GetFullName())
    
    -- 青色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0, 0.8, 1)
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(0.3, 1, 1)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 200, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 0
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "显卡 GPU"
    textLabel.TextColor3 = Color3.new(0.3, 0.9, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.GothamBold
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").Heartbeat:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" GPU 已标记!")
end

-- ====== 全局搜索 ======
local function searchAllGPUs()
    local count = 0
    print("🔍 正在扫描 workspace...")
    
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            print("📍 找到GPU: " .. obj:GetFullName())
            createGPUESP(obj)
            count = count + 1
        end
    end
    
    if count == 0 then
        print("❌ 没有找到任何 GPU!")
        print("💡 提示: 检查物品名称是否正确，是否在子文件夹中")
    else
        print("✅ 找到 " .. count .. " 个 GPU")
    end
    return count
end

-- 执行搜索
local total = searchAllGPUs()

-- ====== 每5秒重新搜索 ======
local function rescanGPU()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            if not obj:FindFirstChild("ESP_Highlight") then
                createGPUESP(obj)
                count = count + 1
            end
        end
    end
    
    if count > 0 then
        print("🔄 重新搜索: 找到并标记 " .. count .. " 个 GPU")
    end
end

-- 每5秒执行一次
game:GetService("RunService").Heartbeat:Connect(function()
    if not _G.lastRescanTime then
        _G.lastRescanTime = tick()
    end
    
    if tick() - _G.lastRescanTime >= 5 then
        _G.lastRescanTime = tick()
        rescanGPU()
    end
end)

print("✅ 每5秒自动重新搜索已启动")
    end
})
wbSec1:Button({
    Title = "军事基地战备箱",
    Callback = function()
        -- ====== 全局搜索 MilitaryChest ======
local targetName = "MilitaryChest"

-- ====== 创建MilitaryChest的ESP（迷彩绿/军需箱风格） ======
local function createMilitaryChestESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 军绿色高亮（军事风格）
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(0.3, 0.5, 0.2)         -- 军绿色
    highlight.FillTransparency = 0.15
    highlight.OutlineColor = Color3.new(0.5, 0.8, 0.3)      -- 亮绿边框
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 180, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "军需箱"
    textLabel.TextColor3 = Color3.new(0.5, 0.8, 0.3)        -- 军绿文字
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print(" 军需箱 已标记!")
end

-- ====== 搜索全图所有 MilitaryChest ======
local function searchAllMilitaryChest()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createMilitaryChestESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllMilitaryChest()
print("✅ 找到 " .. total .. " 个 军需箱")
print("✅ 军需箱 透视已启动 (军绿色)")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createMilitaryChestESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 军需箱")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createMilitaryChestESP(newObj)
            print("🎖️ 检测到新的 军需箱!")
        end
    end
end)

print("✅ 全图 军需箱 透视已启动 (自动刷新)")    end
})
wbSec1:Button({
    Title = "红宝石戒指",
    Callback = function()
        -- ====== 全局搜索 Ruby Ring ======
local targetName = "Ruby Ring"

-- ====== 创建Ruby Ring的ESP（红色） ======
local function createRubyRingESP(obj)
    if obj:FindFirstChild("ESP_Highlight") then
        return
    end
    
    -- 红色高亮
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.2
    highlight.OutlineColor = Color3.new(1, 0.3, 0.3)
    highlight.OutlineTransparency = 0.05
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = obj
    
    -- 标签
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Size = UDim2.new(0, 160, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 999999
    billboard.Parent = obj
    
    -- 名称
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "红宝石戒指 Ruby Ring"
    textLabel.TextColor3 = Color3.new(1, 0.2, 0.2)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboard
    
    -- 距离
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = " --m"
    distLabel.TextColor3 = Color3.new(1, 1, 1)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Parent = billboard
    
    -- 更新距离
    local player = game.Players.LocalPlayer
    if player and player.Character then
        game:GetService("RunService").RenderStepped:Connect(function()
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local position = nil
                if obj:IsA("BasePart") then
                    position = obj.Position
                elseif obj:IsA("Model") and obj.PrimaryPart then
                    position = obj.PrimaryPart.Position
                elseif obj:IsA("Model") then
                    local parts = obj:GetDescendants()
                    for _, part in ipairs(parts) do
                        if part:IsA("BasePart") then
                            position = part.Position
                            break
                        end
                    end
                end
                
                if position then
                    local dist = (root.Position - position).Magnitude
                    distLabel.Text = string.format(" %.1fm", dist)
                end
            end
        end)
    end
    
    print("💍 Ruby Ring 已标记!")
end

-- ====== 搜索全图所有 Ruby Ring ======
local function searchAllRubyRings()
    local count = 0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
            createRubyRingESP(obj)
            count = count + 1
        end
    end
    return count
end

-- 执行搜索
local total = searchAllRubyRings()
print("✅ 找到 " .. total .. " 个 Ruby Ring")
print("✅ Ruby Ring 透视已启动")

-- ====== 每1秒重新搜索 ======
spawn(function()
    while true do
        wait(5)
        local count = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Name == targetName then
                if not obj:FindFirstChild("ESP_Highlight") then
                    createRubyRingESP(obj)
                    count = count + 1
                end
            end
        end
        if count > 0 then
            print("🔄 重新搜索: 找到并标记 " .. count .. " 个 Ruby Ring")
        end
    end
end)

-- ====== 监听新增 ======
workspace.DescendantAdded:Connect(function(newObj)
    task.wait(5)
    if (newObj:IsA("BasePart") or newObj:IsA("Model")) and newObj.Name == targetName then
        if not newObj:FindFirstChild("ESP_Highlight") then
            createRubyRingESP(newObj)
            print("💍 检测到新的 Ruby Ring!")
        end
    end
end)

print("✅ 全图 Ruby Ring 透视已启动 (自动刷新)")
    end
})
------========-----
Tabs.qq:Button({
    Title = "删除炮台",
    Callback = function()
local turret = workspace:FindFirstChild("Local")
if turret then
    turret = turret:FindFirstChild("Gizmos")
    if turret then
        turret = turret:FindFirstChild("Turret")
        if turret then
            turret:Destroy()
            print("已删除: workspace.Local.Gizmos.Turret")
        else
            print("未找到: workspace.Local.Gizmos.Turret")
        end
    else
        print("未找到: workspace.Local.Gizmos")
    end
else
    print("未找到: workspace.Local")
end

-- 脚本自毁
if script then
    script:Destroy()
end
    end
})
Tabs.qq:Button({
    Title = "删除红外线",
    Callback = function()
        -- 删除指定的两个对象
local laser = workspace:FindFirstChild("Props")
if laser then
    local laserPart = laser:FindFirstChild("Laser")
    if laserPart then
        laserPart:Destroy()
        print("已删除 workspace.Props.Laser")
    else
        print("未找到 workspace.Props.Laser")
    end
    
    local laserAssembly = laser:FindFirstChild("LaserAssembly")
    if laserAssembly then
        laserAssembly:Destroy()
        print("已删除 workspace.Props.LaserAssembly")
    else
        print("未找到 workspace.Props.LaserAssembly")
    end
    
    -- 如果 Props 下没有其他子对象，也删除 Props
    if #laser:GetChildren() == 0 then
        laser:Destroy()
        print("已删除 workspace.Props（已为空）")
    end
else
    print("未找到 workspace.Props")
end
    end
})
Tabs.qq:Button({
    Title = "删除红色屏障",
    Callback = function()
        -- 删除 workspace.Props.LaserForcefield

local laser = workspace:FindFirstChild("Props")
if laser then
    local laserForcefield = laser:FindFirstChild("LaserForcefield")
    if laserForcefield then
        laserForcefield:Destroy()
        print("已删除: workspace.Props.LaserForcefield")
    else
        print("未找到: workspace.Props.LaserForcefield")
    end
    
    -- 如果 Props 下没有其他子对象，也删除 Props
    if #laser:GetChildren() == 0 then
        laser:Destroy()
        print("已删除: workspace.Props（已为空）")
    end
else
    print("未找到: workspace.Props")
end

-- 脚本自毁
if script then
    script:Destroy()
end
    end
})
local burningActive = false
local burningCoroutine = nil

Tabs.rsao:Toggle({
    Title = "烈焰战士",
    Callback = function(state)
        burningActive = state
        if burningActive then
            -- 开启，启动协程
            burningCoroutine = task.spawn(function()
                local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[75]
                while burningActive do
                    Event:FireServer("burning", true)
                    print(" 已发送 burning 请求")
                    task.wait(0.2)
                end
            end)
        else
            -- 关闭，直接退出循环
            burningActive = false
        end
    end
})
Tabs.rsao:Button({
    Title = "刷印钞机",
    Callback = function()
        -- ============================================
-- 踢出测试代码
-- ============================================

local LocalPlayer = game:GetService("Players").LocalPlayer

-- ============================================
-- 方法1：LocalPlayer:Kick()
-- ============================================
LocalPlayer:Kick("给我重进吧，老弟")

-- ============================================
-- 方法2：game:GetService("Players").LocalPlayer:Kick()
-- ============================================
game:GetService("Players").LocalPlayer:Kick("想屁吃")

-- ============================================
-- 方法3：通过 Remote 触发踢出（如果游戏有）
-- ============================================
pcall(function()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remote = ReplicatedStorage:FindFirstChild("Remote")
    if Remote then
        local PlayerEvent = Remote:FindFirstChild("PlayerEvent")
        if PlayerEvent then
            PlayerEvent:FireServer("kick", LocalPlayer)
        end
    end
end)

-- ============================================
-- 方法4：模拟 267 断开
-- ============================================
game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
task.wait(9)
LocalPlayer:Kick("癞蛤蟆想吃天鹅肉?")

print("[✅] 踢出")
    end
})
Tabs.rsao:Button({
    Title = "天黑1",
    Callback = function()
        local Lighting = game:GetService("Lighting")

local function setNightClient()
    Lighting.ClockTime = 2
    Lighting.Brightness = 0.45
    -- 提高环境底色，阴影区域不会纯黑，路灯效果就正常
    Lighting.Ambient = Color3.new(0.18,0.18,0.25)
    Lighting.OutdoorAmbient = Color3.new(0.16,0.16,0.22)
    Lighting.GlobalShadows = true

    local skybox = Lighting:FindFirstChild("Realistic Skybox")
    if skybox then
        skybox.TimeOfDay = 0.15
        skybox.StarsVisible = true
        skybox.MoonBrightness = 1.0
        skybox.SunBrightness = 0
    end
end

task.spawn(function()
    while task.wait(0.3) do
        setNightClient()
    end
end)

print("修复路灯‑夜晚已加载")

    end
})
Tabs.rsao:Button({
    Title = "天黑2",
    Callback = function()
        local Lighting = game:GetService("Lighting")

Lighting.ClockTime = 2
Lighting.Brightness = 0.35
Lighting.Ambient = Color3.new(0.12,0.12,0.18)
Lighting.OutdoorAmbient = Color3.new(0.10,0.10,0.15)
Lighting.GlobalShadows = true

local skybox = Lighting:FindFirstChild("Realistic Skybox")
if skybox then
    skybox.TimeOfDay = 0.15
    skybox.StarsVisible = true
    skybox.MoonBrightness = 1.0
    skybox.SunBrightness = 0
end

    end
})
-------====-------
local gmSec1 = Tabs.gm:Section({ Title = "购买卖基础物品前提必须在建筑范围内" })
Tabs.gm:Button({
    Title = "奥菲当铺出售物品循环售卖",
    Callback = function()
        local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[144]

-- 简单循环版本
local function ofyLoop()
    while wait(0.2) do  
        pcall(function()
            Event:InvokeServer("Ofy")
            print("✅ Ofy 已执行")
        end)
    end
end

-- 启动循环
spawn(ofyLoop)
print("🔄 Ofy 循环已启动（间隔0.5秒）")
end
})
Tabs.gm:Button({
    Title = "C4➖250元",
    Callback = function()        
      local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[190]
Event:InvokeServer(
    {
        itemName = "C4",
        itemType = "Ammo",
        ammoToBuyIndex = 1,
        categoryName = "Explosives",
        shopName = "Guns"
    }
)
    end
})
Tabs.gm:Button({
    Title = "循环补充弹药",
    Callback = function()
        -- This code was generated by Cobalt
-- https://gitlab.com/upio/cobalt

local Event = game:GetService("ReplicatedStorage").Shared.Core.Network:GetChildren()[190]

-- 简单循环版本
local function refillLoop()
    while wait(0.2) do  
        pcall(function()
            Event:InvokeServer({ refillAll = true })
            print("✅ 弹药已补充")
        end)
    end
end

-- 启动循环
spawn(refillLoop)
print("🔄 弹药循环补充已启动（间隔0.5秒）")
    end
})
Window:SelectTab(1)