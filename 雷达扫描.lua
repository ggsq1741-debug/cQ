--========================================================
-- 📡 右上角 ESP 玩家雷达 + 全局人数 + 拖动+折叠开关
-- LocalScript
--========================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
--========================================================
-- 配置
--========================================================
local RADAR_SIZE = 190
local RADAR_RANGE = 150
local PLAYER_DOT_SIZE = 7
local SHOW_DISTANCE = true
local SHOW_NAMES = true
--========================================================
-- 清理旧版本
--========================================================
local OldGui = PlayerGui:FindFirstChild("TopRightPlayerRadar")
if OldGui then
    OldGui:Destroy()
end
--========================================================
-- ScreenGui
--========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TopRightPlayerRadar"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- 拖动容器：所有雷达UI放进这个Frame，实现整体拖拽
local DragContainer = Instance.new("Frame")
DragContainer.Name = "DragContainer"
DragContainer.AnchorPoint = Vector2.new(1,0)
DragContainer.Position = UDim2.new(1, -18, 0, 8)
DragContainer.Size = UDim2.fromOffset(RADAR_SIZE + 10, RADAR_SIZE + 70)
DragContainer.BackgroundTransparency = 1
DragContainer.ClipsDescendants = false
DragContainer.Parent = ScreenGui

--==================== 折叠开关按钮 ====================
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.AnchorPoint = Vector2.new(1,0)
ToggleBtn.Position = UDim2.new(1,0,0,0)
ToggleBtn.Size = UDim2.fromOffset(32,22)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,120,70)
ToggleBtn.BackgroundTransparency = 0.2
ToggleBtn.Text = "▼"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.TextSize =14
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.ZIndex =100
ToggleBtn.Parent = DragContainer
local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0,4)
BtnCorner.Parent = ToggleBtn

local isCollapsed = false -- 折叠状态标记

-- 折叠切换逻辑
local function ToggleRadar()
    isCollapsed = not isCollapsed
    -- 获取雷达子组件
    local PlayerCount = DragContainer:FindFirstChild("GlobalPlayerCount")
    local Radar = DragContainer:FindFirstChild("Radar")
    if isCollapsed then
        ToggleBtn.Text = "▲"
        if PlayerCount then PlayerCount.Visible = false end
        if Radar then Radar.Visible = false end
    else
        ToggleBtn.Text = "▼"
        if PlayerCount then PlayerCount.Visible = true end
        if Radar then Radar.Visible = true end
    end
end
ToggleBtn.MouseButton1Click:Connect(ToggleRadar)

--==================== 拖动实现 ====================
local dragging = false
local dragStartPos
local frameStartPos

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
        frameStartPos = Vector2.new(DragContainer.AbsolutePosition.X, DragContainer.AbsolutePosition.Y)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos
        local newPos = frameStartPos + delta
        DragContainer.Position = UDim2.fromOffset(newPos.X, newPos.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

--========================================================
-- 全局人数文字
--========================================================
local PlayerCount = Instance.new("TextLabel")
PlayerCount.Name = "GlobalPlayerCount"
PlayerCount.AnchorPoint = Vector2.new(1, 0)
PlayerCount.Position = UDim2.new(1,0,0,26)
PlayerCount.Size = UDim2.fromOffset(RADAR_SIZE, 28)
PlayerCount.BackgroundTransparency = 1
PlayerCount.Text = "全局人数：0"
PlayerCount.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerCount.TextSize = 16
PlayerCount.Font = Enum.Font.GothamBold
PlayerCount.TextXAlignment = Enum.TextXAlignment.Center
PlayerCount.TextYAlignment = Enum.TextYAlignment.Center
PlayerCount.ZIndex = 50
PlayerCount.Parent = DragContainer

--========================================================
-- 人数更新
--========================================================
local function UpdatePlayerCount()
    local Count = #Players:GetPlayers()
    PlayerCount.Text = "全局人数：" .. tostring(Count)
end
UpdatePlayerCount()
Players.PlayerAdded:Connect(UpdatePlayerCount)
Players.PlayerRemoving:Connect(function()
    task.defer(UpdatePlayerCount)
end)

--========================================================
-- 雷达主体
--========================================================
local Radar = Instance.new("Frame")
Radar.Name = "Radar"
Radar.AnchorPoint = Vector2.new(1, 0)
Radar.Position = UDim2.new(1,0,0,58)
Radar.Size = UDim2.fromOffset(RADAR_SIZE, RADAR_SIZE)
Radar.BackgroundColor3 = Color3.fromRGB(8, 18, 15)
Radar.BackgroundTransparency = 0.12
Radar.BorderSizePixel = 0
Radar.ClipsDescendants = true
Radar.Parent = DragContainer

--========================================================
-- 圆形雷达
--========================================================
local RadarCorner = Instance.new("UICorner")
RadarCorner.CornerRadius = UDim.new(1, 0)
RadarCorner.Parent = Radar
local RadarStroke = Instance.new("UIStroke")
RadarStroke.Color = Color3.fromRGB(70, 220, 125)
RadarStroke.Thickness = 2
RadarStroke.Transparency = 0.15
RadarStroke.Parent = Radar

--========================================================
-- 雷达圆圈
--========================================================
local function CreateCircle(scale, transparency)
    local Circle = Instance.new("Frame")
    Circle.AnchorPoint = Vector2.new(0.5, 0.5)
    Circle.Position = UDim2.fromScale(0.5, 0.5)
    Circle.Size = UDim2.fromScale(scale, scale)
    Circle.BackgroundTransparency = 1
    Circle.Parent = Radar
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Circle
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(50, 150, 90)
    Stroke.Thickness = 1
    Stroke.Transparency = transparency
    Stroke.Parent = Circle
end
CreateCircle(0.33, 0.55)
CreateCircle(0.66, 0.60)
CreateCircle(0.99, 0.35)

--========================================================
-- 十字线
--========================================================
local Vertical = Instance.new("Frame")
Vertical.AnchorPoint = Vector2.new(0.5, 0.5)
Vertical.Position = UDim2.fromScale(0.5, 0.5)
Vertical.Size = UDim2.new(0, 1, 1, 0)
Vertical.BackgroundColor3 = Color3.fromRGB(60, 170, 100)
Vertical.BackgroundTransparency = 0.65
Vertical.BorderSizePixel = 0
Vertical.Parent = Radar
local Horizontal = Instance.new("Frame")
Horizontal.AnchorPoint = Vector2.new(0.5, 0.5)
Horizontal.Position = UDim2.fromScale(0.5, 0.5)
Horizontal.Size = UDim2.new(1, 0, 0, 1)
Horizontal.BackgroundColor3 = Color3.fromRGB(60, 170, 100)
Horizontal.BackgroundTransparency = 0.65
Horizontal.BorderSizePixel = 0
Horizontal.Parent = Radar

--========================================================
-- 方向文字
--========================================================
local function DirectionLabel(text, position)
    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.AnchorPoint = Vector2.new(0.5, 0.5)
    Label.Position = position
    Label.Size = UDim2.fromOffset(25, 18)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(120, 220, 150)
    Label.TextSize = 10
    Label.Font = Enum.Font.GothamBold
    Label.TextTransparency = 0.2
    Label.ZIndex = 4
    Label.Parent = Radar
end
DirectionLabel("N", UDim2.fromScale(0.5, 0.07))
DirectionLabel("S", UDim2.fromScale(0.5, 0.93))
DirectionLabel("W", UDim2.fromScale(0.07, 0.5))
DirectionLabel("E", UDim2.fromScale(0.93, 0.5))

--========================================================
-- 自己
--========================================================
local SelfDot = Instance.new("Frame")
SelfDot.Name = "Self"
SelfDot.AnchorPoint = Vector2.new(0.5, 0.5)
SelfDot.Position = UDim2.fromScale(0.5, 0.5)
SelfDot.Size = UDim2.fromOffset(10, 10)
SelfDot.BackgroundColor3 = Color3.fromRGB(70, 255, 120)
SelfDot.BorderSizePixel = 0
SelfDot.ZIndex = 20
SelfDot.Parent = Radar
local SelfCorner = Instance.new("UICorner")
SelfCorner.CornerRadius = UDim.new(1, 0)
SelfCorner.Parent = SelfDot

--========================================================
-- 玩家点
--========================================================
local PlayerDots = {}
local function CreatePlayerDot(Player)
    if PlayerDots[Player] then
        return PlayerDots[Player]
    end
    local Dot = Instance.new("Frame")
    Dot.Name = "Player_" .. tostring(Player.UserId)
    Dot.AnchorPoint = Vector2.new(0.5, 0.5)
    Dot.Size = UDim2.fromOffset(PLAYER_DOT_SIZE, PLAYER_DOT_SIZE)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    Dot.BorderSizePixel = 0
    Dot.ZIndex = 15
    Dot.Parent = Radar
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Dot
    --====================================================
    -- 玩家名字
    --====================================================
    local Name = Instance.new("TextLabel")
    Name.Name = "PlayerName"
    Name.AnchorPoint = Vector2.new(0.5, 1)
    Name.Position = UDim2.new(0.5, 0, 0, -5)
    Name.Size = UDim2.fromOffset(100, 16)
    Name.BackgroundTransparency = 1
    Name.Text = Player.DisplayName
    Name.TextColor3 = Color3.fromRGB(255, 255, 255)
    Name.TextStrokeTransparency = 0.45
    Name.TextSize = 9
    Name.Font = Enum.Font.GothamMedium
    Name.Visible = false
    Name.ZIndex = 16
    Name.Parent = Dot
    --====================================================
    -- 距离
    --====================================================
    local Distance = Instance.new("TextLabel")
    Distance.Name = "Distance"
    Distance.AnchorPoint = Vector2.new(0.5, 0)
    Distance.Position = UDim2.new(0.5, 0, 1, 4)
    Distance.Size = UDim2.fromOffset(70, 14)
    Distance.BackgroundTransparency = 1
    Distance.TextColor3 = Color3.fromRGB(180, 180, 180)
    Distance.TextSize = 8
    Distance.Font = Enum.Font.Gotham
    Distance.Visible = false
    Distance.ZIndex = 16
    Distance.Parent = Dot
    PlayerDots[Player] = Dot
    return Dot
end

--========================================================
-- 删除玩家
--========================================================
local function RemovePlayerDot(Player)
    local Dot = PlayerDots[Player]
    if Dot then
        Dot:Destroy()
        PlayerDots[Player] = nil
    end
end

--========================================================
-- 初始化玩家
--========================================================
for _, Player in ipairs(Players:GetPlayers()) do
    if Player ~= LocalPlayer then
        CreatePlayerDot(Player)
    end
end
Players.PlayerAdded:Connect(function(Player)
    if Player ~= LocalPlayer then
        CreatePlayerDot(Player)
    end
end)
Players.PlayerRemoving:Connect(RemovePlayerDot)

--========================================================
-- 获取角色 Root
--========================================================
local function GetRoot(Player)
    local Character = Player.Character
    if not Character then
        return nil
    end
    return Character:FindFirstChild("HumanoidRootPart")
end

--========================================================
-- 更新玩家位置
--========================================================
local function UpdatePlayer(Player, Dot)
    local MyRoot = GetRoot(LocalPlayer)
    local TargetRoot = GetRoot(Player)
    if not MyRoot or not TargetRoot then
        Dot.Visible = false
        return
    end
    local Offset = TargetRoot.Position - MyRoot.Position
    local FlatOffset = Vector3.new(Offset.X, 0, Offset.Z)
    local Distance = FlatOffset.Magnitude
    if Distance <= 0.1 then
        Dot.Visible = false
        return
    end
    --====================================================
    -- 超出范围
    --====================================================
    local DisplayOffset = FlatOffset
    if Distance > RADAR_RANGE then
        DisplayOffset = FlatOffset.Unit * RADAR_RANGE
    end
    --====================================================
    -- 根据自己的朝向转换
    --====================================================
    local Right = MyRoot.CFrame.RightVector
    local Forward = MyRoot.CFrame.LookVector
    local X = DisplayOffset:Dot(Right)
    local Z = DisplayOffset:Dot(Forward)
    --====================================================
    -- 雷达坐标
    --====================================================
    local Center = RADAR_SIZE / 2
    local Radius = RADAR_SIZE / 2 - 10
    local RadarX = Center + (X / RADAR_RANGE) * Radius
    local RadarY = Center - (Z / RADAR_RANGE) * Radius
    RadarX = math.clamp(RadarX, 8, RADAR_SIZE - 8)
    RadarY = math.clamp(RadarY, 8, RADAR_SIZE - 8)
    Dot.Position = UDim2.fromOffset(RadarX, RadarY)
    Dot.Visible = true
    --====================================================
    -- 玩家名字
    --====================================================
    local Name = Dot:FindFirstChild("PlayerName")
    if Name then
        Name.Visible = SHOW_NAMES and Distance <= 100
    end
    --====================================================
    -- 距离
    --====================================================
    local DistanceText = Dot:FindFirstChild("Distance")
    if DistanceText then
        DistanceText.Visible = SHOW_DISTANCE and Distance <= 100
        DistanceText.Text = tostring(math.floor(Distance)) .. " studs"
    end
    --====================================================
    -- 距离越近点越大
    --====================================================
    local NearPower = 1 - math.clamp(Distance / RADAR_RANGE, 0, 1)
    local Size = PLAYER_DOT_SIZE + NearPower * 4
    Dot.Size = UDim2.fromOffset(Size, Size)
end

--========================================================
-- 扫描线
--========================================================
local ScanLine = Instance.new("Frame")
ScanLine.Name = "Scanner"
ScanLine.AnchorPoint = Vector2.new(0.5, 1)
ScanLine.Position = UDim2.fromScale(0.5, 0.5)
ScanLine.Size = UDim2.new(0, 2, 0.47, 0)
ScanLine.BackgroundColor3 = Color3.fromRGB(80, 255, 140)
ScanLine.BackgroundTransparency = 0.25
ScanLine.BorderSizePixel = 0
ScanLine.ZIndex = 8
ScanLine.Parent = Radar

--========================================================
-- 扫描动画
--========================================================
local ScanRotation = 0
RunService.RenderStepped:Connect(function(deltaTime)
    ScanRotation = ScanRotation + deltaTime * 120
    ScanLine.Rotation = ScanRotation
    -- 更新玩家位置
    for Player, Dot in pairs(PlayerDots) do
        if Player.Parent then
            UpdatePlayer(Player, Dot)
        else
            RemovePlayerDot(Player)
        end
    end
end)

print("📡 雷达【可拖动+折叠开关】已启动")
