-- ===== 重构版 GUI：霓虹风格 + 可拖动 + 可折叠 =====
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local lockedPlayer = nil
local lockConnection = nil
local isMinimized = false

-- 暴力传送函数
local function forceBring(targetPlayer)
    print(" 执行传送: " .. targetPlayer.Name)
    
    local myChar = lp.Character
    local targetChar = targetPlayer.Character
    
    if not myChar or not myChar.Parent then
        warn(" 你的角色不存在")
        return
    end
    if not targetChar or not targetChar.Parent then
        warn(" 目标角色不存在")
        return
    end
    
    local myPart = myChar:FindFirstChild("HumanoidRootPart") 
        or myChar:FindFirstChild("Torso") 
        or myChar:FindFirstChild("UpperTorso") 
        or myChar:FindFirstChild("Head")
    
    local targetPart = targetChar:FindFirstChild("HumanoidRootPart") 
        or targetChar:FindFirstChild("Torso") 
        or targetChar:FindFirstChild("UpperTorso") 
        or targetChar:FindFirstChild("Head")
    
    if not myPart or not targetPart then
        warn("❌ 找不到部件")
        return
    end
    
    local targetPos = myPart.Position + myPart.CFrame.LookVector * 2.5 + Vector3.new(0, 0.5, 0)
    
    pcall(function()
        targetPart.CFrame = CFrame.new(targetPos)
        targetPart.Position = targetPos
        targetPart.Velocity = Vector3.new(0, 0, 0)
        targetPart.RotVelocity = Vector3.new(0, 0, 0)
        targetPart.CanCollide = false
        
        for _, child in ipairs(targetChar:GetDescendants()) do
            if child:IsA("BasePart") then
                child.Velocity = Vector3.new(0, 0, 0)
                child.RotVelocity = Vector3.new(0, 0, 0)
                child.CanCollide = false
            end
        end
        
        local hum = targetChar:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = true
            hum.WalkSpeed = 0
            hum.JumpPower = 0
        end
    end)
    
    print(" 传送完成!")
end

-- 锁定玩家
local function lockPlayer(targetPlayer)
    if lockedPlayer == targetPlayer then
        if lockConnection then
            lockConnection:Disconnect()
            lockConnection = nil
        end
        lockedPlayer = nil
        print(" 已解锁")
        return
    end
    
    if lockConnection then
        lockConnection:Disconnect()
        lockConnection = nil
    end
    
    lockedPlayer = targetPlayer
    forceBring(targetPlayer)
    
    lockConnection = RunService.Heartbeat:Connect(function()
        if not lockedPlayer then return end
        
        local myChar = lp.Character
        local targetChar = lockedPlayer.Character
        if not myChar or not myChar.Parent or not targetChar or not targetChar.Parent then
            return
        end
        
        local myPart = myChar:FindFirstChild("HumanoidRootPart") 
            or myChar:FindFirstChild("Torso") 
            or myChar:FindFirstChild("UpperTorso") 
            or myChar:FindFirstChild("Head")
        
        local targetPart = targetChar:FindFirstChild("HumanoidRootPart") 
            or targetChar:FindFirstChild("Torso") 
            or targetChar:FindFirstChild("UpperTorso") 
            or targetChar:FindFirstChild("Head")
        
        if not myPart or not targetPart then return end
        
        local targetPos = myPart.Position + myPart.CFrame.LookVector * 2.5 + Vector3.new(0, 0.5, 0)
        
        pcall(function()
            targetPart.CFrame = CFrame.new(targetPos)
            targetPart.Position = targetPos
            targetPart.Velocity = Vector3.new(0, 0, 0)
            targetPart.RotVelocity = Vector3.new(0, 0, 0)
        end)
    end)
    
    print(" 已锁定: " .. targetPlayer.Name)
end

-- ===== 构建霓虹风格 GUI + 拖动 + 折叠功能 =====
local function createNeonGUI()
    -- 删除旧的 GUI
    local old = lp.PlayerGui:FindFirstChild("NeonLockGUI")
    if old then old:Destroy() end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NeonLockGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = lp:WaitForChild("PlayerGui")

    -- 主容器：圆角玻璃面板
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 220, 0, 360)
    mainFrame.Position = UDim2.new(0, 15, 0, 60)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    mainFrame.BackgroundTransparency = 0.25
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    -- 圆角处理
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    -- 发光边框
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 0, 1, 0)
    border.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    border.BackgroundTransparency = 0.7
    border.BorderSizePixel = 0
    border.Parent = mainFrame
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 12)
    borderCorner.Parent = border
    
    -- 标题栏 (拖动区域)
    local titleFrame = Instance.new("Frame")
    titleFrame.Size = UDim2.new(1, 0, 0, 35)
    titleFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    titleFrame.BackgroundTransparency = 0.3
    titleFrame.BorderSizePixel = 0
    titleFrame.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -70, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = " 锁定传送击杀"
    title.TextColor3 = Color3.fromRGB(0, 200, 255)
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Parent = titleFrame

    -- 最小化按钮
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 24, 0, 24)
    minBtn.Position = UDim2.new(1, -56, 0, 5)
    minBtn.Text = "−"
    minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minBtn.TextSize = 20
    minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    minBtn.BackgroundTransparency = 0.2
    minBtn.BorderSizePixel = 0
    minBtn.Parent = titleFrame
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(1, 0)
    minCorner.Parent = minBtn

    minBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            minBtn.Text = "+"
            -- 折叠：隐藏内容区域
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 220, 0, 35)
            }):Play()
            title.Text = " 远程击杀吸取玩家 [+]"
        else
            minBtn.Text = "−"
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                Size = UDim2.new(0, 220, 0, 360)
            }):Play()
            title.Text = " 锁定传送击杀"
        end
    end)

    minBtn.MouseEnter:Connect(function()
        TweenService:Create(minBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end)
    minBtn.MouseLeave:Connect(function()
        TweenService:Create(minBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)

    -- 关闭按钮
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -28, 0, 5)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
    closeBtn.BackgroundTransparency = 0.2
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleFrame
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        if lockConnection then lockConnection:Disconnect() end
        screenGui:Destroy()
    end)

    closeBtn.MouseEnter:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end)
    closeBtn.MouseLeave:Connect(function()
        TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)

    -- 内容容器 (用于折叠)
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, 0, 1, -35)
    contentContainer.Position = UDim2.new(0, 0, 0, 35)
    contentContainer.BackgroundTransparency = 1
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainFrame

    -- 状态标签
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -20, 0, 25)
    status.Position = UDim2.new(0, 10, 0, 5)
    status.Text = "● 未锁定"
    status.TextColor3 = Color3.fromRGB(150, 200, 255)
    status.TextSize = 13
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.Gotham
    status.Parent = contentContainer

    -- 玩家列表滚动区域
    local scroller = Instance.new("ScrollingFrame")
    scroller.Size = UDim2.new(1, -14, 1, -45)
    scroller.Position = UDim2.new(0, 7, 0, 32)
    scroller.BackgroundTransparency = 1
    scroller.BorderSizePixel = 0
    scroller.ScrollBarThickness = 4
    scroller.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    scroller.Parent = contentContainer

    local layout = Instance.new("UIListLayout")
    layout.Parent = scroller
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

    -- 拖动功能
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    local function updatePosition(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
    
    titleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    titleFrame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                         input.UserInputType == Enum.UserInputType.Touch) then
            updatePosition(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- 玩家按钮生成
    local function createPlayerButton(plr)
        if plr == lp then return end

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
        btn.BackgroundTransparency = 0.5
        btn.BorderSizePixel = 0
        btn.Text = "  " .. plr.Name
        btn.TextColor3 = Color3.fromRGB(220, 230, 255)
        btn.TextSize = 14
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.Gotham
        btn.Parent = scroller
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
        end)
        btn.MouseLeave:Connect(function()
            if btn.BackgroundColor3 ~= Color3.fromRGB(0, 80, 180) then
                TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.5}):Play()
            end
        end)

        btn.MouseButton1Click:Connect(function()
            -- 如果折叠状态，自动展开
            if isMinimized then
                isMinimized = false
                minBtn.Text = "−"
                TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                    Size = UDim2.new(0, 220, 0, 360)
                }):Play()
                title.Text = "  锁定传送击杀"
            end
            
            status.Text = "● 锁定: " .. plr.Name
            status.TextColor3 = Color3.fromRGB(0, 255, 200)
            lockPlayer(plr)

            for _, child in ipairs(scroller:GetChildren()) do
                if child:IsA("TextButton") and child ~= btn then
                    child.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
                    child.BackgroundTransparency = 0.5
                    child.TextColor3 = Color3.fromRGB(220, 230, 255)
                end
            end
            btn.BackgroundColor3 = Color3.fromRGB(0, 80, 180)
            btn.BackgroundTransparency = 0.3
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        createPlayerButton(plr)
    end

    Players.PlayerAdded:Connect(createPlayerButton)
    
    -- 动态呼吸光晕
    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(1.05, 0, 1.05, 0)
    glow.Position = UDim2.new(-0.025, 0, -0.025, 0)
    glow.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    glow.BackgroundTransparency = 0.9
    glow.BorderSizePixel = 0
    glow.ZIndex = 0
    glow.Parent = mainFrame
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 16)
    glowCorner.Parent = glow
    
    spawn(function()
        while screenGui.Parent do
            TweenService:Create(glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 0.85
            }):Play()
            task.wait(2)
            TweenService:Create(glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                BackgroundTransparency = 0.92
            }):Play()
            task.wait(2)
        end
    end)

    print("✨ 霓虹风格 GUI 加载完成！(可拖动 + 可折叠)")
end

-- ===== 启动 =====
createNeonGUI()
print("🚀 新样式已启动，按 F9 查看控制台")