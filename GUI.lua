-- ============================================
-- 悬浮飞车 (防拉回注入版)
-- ============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ⭐ 核心：飞车防检测 Hook
local FlyingEnabled = false
local carMt = getrawmetatable(game)
local carOldIndex = carMt.__index
setreadonly(carMt, false)

carMt.__index = newcclosure(function(self, key)
    -- 如果开启了飞车，当游戏尝试读取速度时，永远返回 0
    if FlyingEnabled and (key == "AssemblyLinearVelocity" or key == "Velocity") and self:IsA("BasePart") then
        return Vector3.new(0, 0, 0)
    end
    return carOldIndex(self, key)
end)
setreadonly(carMt, true)

-- ============================================
-- 配置
-- ============================================
local FlyConfig = {
    Speed = 350,
    AutoHover = true,
    TakeoffHeight = 15,
    VerticalSpeed = 18,
    VerticalAccel = 3,
    VerticalJitter = 0.1,
}

local Input = {
    Forward = false, Backward = false,
    Left = false, Right = false,
    Up = false, Down = false,
}

local FlightSpeed = 350
local CurrentAO, CurrentLV, CurrentMoverAttachment, FlightConnection
local VehicleRoot = nil
local hoverY = nil
local currentVertSpeed = 0

-- ============================================
-- 电脑端键盘监听
-- ============================================
local KeyMap = {
    [Enum.KeyCode.W] = "Forward",
    [Enum.KeyCode.S] = "Backward",
    [Enum.KeyCode.A] = "Left",
    [Enum.KeyCode.D] = "Right",
    [Enum.KeyCode.Space] = "Up",
    [Enum.KeyCode.LeftControl] = "Down",
}

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    local key = KeyMap[input.KeyCode]
    if key then Input[key] = true end
end)

UserInputService.InputEnded:Connect(function(input)
    local key = KeyMap[input.KeyCode]
    if key then Input[key] = false end
end)

-- ============================================
-- 获取载具
-- ============================================
local function getCurrentVehicle()
    local char = LocalPlayer.Character
    if not char then return nil, nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil, nil end
    local seat = hum.SeatPart
    if not seat then return nil, nil end
    local vehicle = seat:FindFirstAncestorOfClass("Model")
    if not vehicle then return nil, nil end
    local root = vehicle.PrimaryPart
    if not root then
        local biggest = 0
        for _, part in ipairs(vehicle:GetDescendants()) do
            if part:IsA("BasePart") then
                local s = part.Size.Magnitude
                if s > biggest then biggest = s; root = part end
            end
        end
    end
    return vehicle, root or seat
end

-- ============================================
-- BodyMovers
-- ============================================
local function setupVehicleBodyMovers(vehicle, rootPart)
    local moverParent = workspace:FindFirstChildOfClass("Terrain") or workspace
    local moverAttachment = Instance.new("Attachment", rootPart)
    moverAttachment.Name = "VehicleFlyAttachment"

    local alignOrientation = Instance.new("AlignOrientation")
    alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    alignOrientation.RigidityEnabled = true
    alignOrientation.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    alignOrientation.CFrame = rootPart.CFrame
    alignOrientation.Attachment0 = moverAttachment
    alignOrientation.Parent = moverParent

    local linearVelocity = Instance.new("LinearVelocity")
    linearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
    linearVelocity.MaxForce = 9e9
    linearVelocity.Attachment0 = moverAttachment
    linearVelocity.Parent = moverParent

    return alignOrientation, linearVelocity, moverAttachment
end

-- ============================================
-- 开始 / 停止
-- ============================================
local function startCarFly()
    if FlyingEnabled then return false end
    local vehicle, rootPart = getCurrentVehicle()
    if not vehicle or not rootPart then return false end

    VehicleRoot = rootPart
    
    -- ⭐ 强行夺取载具的网络所有权，防止服务器乱动
    pcall(function() VehicleRoot:SetNetworkOwner(LocalPlayer) end)

    hoverY = rootPart.Position.Y + FlyConfig.TakeoffHeight
    CurrentAO, CurrentLV, CurrentMoverAttachment = setupVehicleBodyMovers(vehicle, rootPart)
    
    FlyingEnabled = true -- 开启 Hook 保护
    currentVertSpeed = 0

    FlightConnection = RunService.Heartbeat:Connect(function(dt)
        if not FlyingEnabled or not CurrentLV or not CurrentAO then
            if FlightConnection then FlightConnection:Disconnect() FlightConnection = nil end
            return
        end
        if not VehicleRoot or not VehicleRoot.Parent then
            stopCarFly()
            return
        end

        local cam = workspace.CurrentCamera
        local fwd = (Input.Forward and 1 or 0) - (Input.Backward and 1 or 0)
        local side = (Input.Right and 1 or 0) - (Input.Left and 1 or 0)
        local vert = (Input.Up and 1 or 0) - (Input.Down and 1 or 0)

        -- 水平
        local horizVec = (cam.CFrame.LookVector * fwd + cam.CFrame.RightVector * side)
        if horizVec.Magnitude > 0 then
            CurrentLV.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            CurrentLV.VectorVelocity = horizVec.Unit * FlightSpeed
        else
            CurrentLV.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            CurrentLV.VectorVelocity = Vector3.new(0, 0, 0)
        end

        -- 垂直
        local maxV = FlyConfig.VerticalSpeed
        local accel = maxV * dt * FlyConfig.VerticalAccel
        local targetV = 0

        if vert > 0 then
            targetV = maxV
        elseif vert < 0 then
            targetV = -maxV
        elseif FlyConfig.AutoHover and hoverY then
            local diff = hoverY - VehicleRoot.Position.Y
            if math.abs(diff) > 1 then
                targetV = math.clamp(diff * 3, -maxV, maxV)
            end
        end

        if currentVertSpeed < targetV then
            currentVertSpeed = math.min(targetV, currentVertSpeed + accel)
        elseif currentVertSpeed > targetV then
            currentVertSpeed = math.max(targetV, currentVertSpeed - accel)
        end

        if math.abs(currentVertSpeed) > 0.1 then
            local moveY = currentVertSpeed * dt
            moveY = moveY + (math.random() - 0.5) * FlyConfig.VerticalJitter * dt * 60
            pcall(function()
                VehicleRoot.CFrame = VehicleRoot.CFrame + Vector3.new(0, moveY, 0)
            end)
            pcall(function()
                local v = VehicleRoot.AssemblyLinearVelocity
                VehicleRoot.AssemblyLinearVelocity = Vector3.new(v.X, 0, v.Z)
            end)
        end

        CurrentAO.CFrame = CFrame.new(VehicleRoot.Position, VehicleRoot.Position + cam.CFrame.LookVector)
    end)

    return true
end

function stopCarFly()
    if not FlyingEnabled then return end
    FlyingEnabled = false
    if FlightConnection then FlightConnection:Disconnect() FlightConnection = nil end
    if CurrentAO then CurrentAO:Destroy() CurrentAO = nil end
    if CurrentLV then CurrentLV:Destroy() CurrentLV = nil end
    if CurrentMoverAttachment then CurrentMoverAttachment:Destroy() CurrentMoverAttachment = nil end
    VehicleRoot = nil
    hoverY = nil
    currentVertSpeed = 0
    for k in pairs(Input) do Input[k] = false end
end

-- ============================================
-- 悬浮按钮 UI
-- ============================================
local dirPanel = nil

local function createBtn(parent, text, pos, size, bgColor, textColor)
    local btn = Instance.new("TextButton")
    btn.Size = size
    btn.Position = pos
    btn.BackgroundColor3 = bgColor
    btn.BackgroundTransparency = 0.15
    btn.Text = text
    btn.TextColor3 = textColor
    btn.TextSize = 22
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = parent

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(1, 0)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(150, 180, 220)
    s.Thickness = 2
    s.Parent = btn

    return btn
end

local function bindHold(btn, inputKey, onColor, offColor)
    local function press()
        Input[inputKey] = true
        btn.BackgroundColor3 = onColor
    end
    local function release()
        Input[inputKey] = false
        btn.BackgroundColor3 = offColor
    end
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
           or input.UserInputType == Enum.UserInputType.MouseButton1 then
            press()
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
           or input.UserInputType == Enum.UserInputType.MouseButton1 then
            release()
        end
    end)
    btn.MouseLeave:Connect(release)
end

local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CarFlyUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

    local offColor = Color3.fromRGB(45, 45, 60)
    local onColorGreen = Color3.fromRGB(80, 200, 100)
    local onColorBlue = Color3.fromRGB(100, 180, 255)

    local mainBtn = createBtn(ScreenGui, "飞车\nOFF",
        UDim2.new(0, 20, 0.5, -40),
        UDim2.new(0, 80, 0, 80),
        offColor, Color3.fromRGB(255, 255, 255))
    mainBtn.TextSize = 16

    local panel = Instance.new("Frame")
    panel.Name = "DirPanel"
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundTransparency = 1
    panel.Visible = false
    panel.Parent = ScreenGui
    dirPanel = panel

    local sz = UDim2.new(0, 60, 0, 60)
    local btnF = createBtn(panel, "▲", UDim2.new(1, -200, 1, -240), sz, offColor, Color3.new(1,1,1))
    local btnB = createBtn(panel, "▼", UDim2.new(1, -200, 1, -110), sz, offColor, Color3.new(1,1,1))
    local btnL = createBtn(panel, "◄", UDim2.new(1, -270, 1, -175), sz, offColor, Color3.new(1,1,1))
    local btnR = createBtn(panel, "►", UDim2.new(1, -130, 1, -175), sz, offColor, Color3.new(1,1,1))
    local btnUp = createBtn(panel, "🔼", UDim2.new(1, -270, 1, -310), sz, offColor, onColorBlue)
    local btnDown = createBtn(panel, "🔽", UDim2.new(1, -130, 1, -310), sz, offColor, onColorBlue)

    bindHold(btnF, "Forward", onColorGreen, offColor)
    bindHold(btnB, "Backward", onColorGreen, offColor)
    bindHold(btnL, "Left", onColorGreen, offColor)
    bindHold(btnR, "Right", onColorGreen, offColor)
    bindHold(btnUp, "Up", onColorBlue, offColor)
    bindHold(btnDown, "Down", onColorBlue, offColor)

    mainBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
           or input.UserInputType == Enum.UserInputType.MouseButton1 then
            if FlyingEnabled then
                stopCarFly()
                mainBtn.Text = "飞车\nOFF"
                mainBtn.BackgroundColor3 = offColor
                panel.Visible = false
            else
                local ok = startCarFly()
                if ok then
                    mainBtn.Text = "飞车\nON"
                    mainBtn.BackgroundColor3 = onColorGreen
                    panel.Visible = true
                else
                    mainBtn.Text = "没上车"
                    task.delay(1.5, function()
                        if not FlyingEnabled then
                            mainBtn.Text = "飞车\nOFF"
                            mainBtn.BackgroundColor3 = offColor
                            panel.Visible = false
                        end
                    end)
                end
            end
        end
    end)

    local dragging = false
    local dragStart, startPos
    mainBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
           or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainBtn.Position
        end
    end)
    mainBtn.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch
           or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            mainBtn.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    mainBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
           or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return ScreenGui, mainBtn, panel
end

local gui, mainBtn, panel = createUI()

LocalPlayer.CharacterAdded:Connect(function()
    if FlyingEnabled then
        task.wait(1)
        stopCarFly()
        if mainBtn then
            mainBtn.Text = "飞车\nOFF"
            mainBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        end
        if panel then panel.Visible = false end
    end
end)

print("[悬浮飞车] 防检测版加载完成 - 电脑 WASD+空格+左Ctrl | 手机 悬浮按钮")