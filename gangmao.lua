-- ==================== 反作弊安全删除 ====================
print = function() end
warn = function() end
printidentity = function() end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local deletedCount = 0
local function deleteIfExists(parent, ...)
    local obj = parent
    local parts = {...}
    for _, part in ipairs(parts) do
        if obj then obj = obj:FindFirstChild(part) else break end
    end
    if obj then pcall(function() obj:Destroy(); deletedCount = deletedCount + 1 end) return true end
    return false
end

deleteIfExists(ReplicatedStorage, "Shared", "Core", "RateLimiter")
deleteIfExists(ReplicatedStorage, "Vendor", "ReplicaService", "RateLimiter")
deleteIfExists(ReplicatedStorage, "Shared", "Core", "GetAsset")
deleteIfExists(ReplicatedStorage, "Client", "Core", "DebugTeleport")
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "Modules", "ClientPlayerFlags")
deleteIfExists(ReplicatedStorage, "Client", "Wanted", "Objects", "DevvChassis", "Components", "Telemetry")
deleteIfExists(ReplicatedStorage, "CmdrClient")
deleteIfExists(ReplicatedStorage, "Vendor", "Cmdr")

-- ==================== 加载 Airflow UI ====================
local Airflow = loadstring(game:HttpGet("https://raw.githubusercontent.com/PookiePepelsss/Airflow-UI/refs/heads/main/Source.luau"))()

local Window = Airflow:CreateWindow({
    Name = "港猫的通缉Wanted",
    LoadingSubtitle = "作者港猫",
    Icon = "wind",
    ToggleUIKeybind = "RightShift",
    Size = UDim2.fromOffset(700, 550),
    MinSize = Vector2.new(480, 360),
    MaxSize = Vector2.new(1000, 700),
    MaxNotifications = 4,
    KeepOnScreen = true,
    OpenButton = { Title = "港猫", Icon = "wind" },
    Loading = {
        Enabled = true,
        Title = "港猫的通缉Wanted",
        Text = "正在启动",
        Steps = { "准备界面", "加载图标", "即将完成" },
        Duration = 1.5,
    },
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "GangMao-Wanted",
        FileName = "default",
    },
    Home = {
        Name = "首页",
        Welcome = "你好, ",
        Stats = { "FPS", "延迟", "执行器", "游戏", "地区", "时间" },
        TimeFormat = "%H:%M",
    },
})

-- ==================== 创建标签 ====================
local T = {}
T.wj   = Window:CreateTab({ Name = "玩家", Desc = "玩家功能", Icon = "users" })
T.wsj  = Window:CreateTab({ Name = "万圣节功能", Desc = "万圣节", Icon = "rbxassetid://7734058599" })
T.zx   = Window:CreateTab({ Name = "准心设置", Desc = "准心", Icon = "rbxassetid://7733666258" })
T.gh   = Window:CreateTab({ Name = "光环", Desc = "光环", Icon = "crown" })
T.fz   = Window:CreateTab({ Name = "进阶辅助瞄准", Desc = "自瞄", Icon = "crosshair" })
T.bot  = Window:CreateTab({ Name = "范围", Desc = "碰撞箱", Icon = "target" })
T.zj   = Window:CreateTab({ Name = "子弹追踪", Desc = "静默瞄准", Icon = "target" })
T.ESP  = Window:CreateTab({ Name = "ESP", Desc = "透视", Icon = "eye" })

-- ==================== 通用工具函数 ====================
local function getCharacter()
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        return LocalPlayer.Character
    end
    return nil
end

-- ==================== 玩家页 (WJ) ====================
local speedConn, currentSpeed = nil, 1
local function updateChar()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if speedConn then speedConn:Disconnect() speedConn = nil end
    if not hum or currentSpeed <= 1 then return end
    speedConn = RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then
            speedConn:Disconnect() speedConn = nil
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

T.wj:CreateInput({
    Name = "超级快跑",
    PlaceholderText = "输入1~200数字",
    CurrentValue = "1",
    Numeric = true,
    Flag = "WJ_Speed_Input",
    Callback = function(val)
        local num = tonumber(val)
        if not num then return end
        currentSpeed = math.clamp(num,1,200)
        updateChar()
    end,
})
T.wj:CreateSlider({
    Name = "超级快跑",
    Range = {1, 200},
    Increment = 1,
    CurrentValue = 1,
    Flag = "WJ_Speed_Slider",
    Callback = function(val)
        currentSpeed = val
        updateChar()
    end,
})

local isInfiniteJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if isInfiniteJumpEnabled then
        local character = getCharacter()
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

local FlyingEnabled = false
local FlightSpeed = 150
local CurrentAO, CurrentLV, CurrentMoverAttachment, FlightConnection
local mt_fly = getrawmetatable(game)
local old_fly_index = mt_fly.__index
setreadonly(mt_fly, false)
mt_fly.__index = newcclosure(function(self, key)
    if FlyingEnabled and (key == "AssemblyLinearVelocity" or key == "Velocity") and self:IsA("BasePart") then
        return Vector3.new(0, 0, 0)
    end
    return old_fly_index(self, key)
end)
setreadonly(mt_fly, true)

local function getFlyControlModule()
    local PlayerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
    return require(PlayerModule:WaitForChild("ControlModule"))
end
local function setupFlyBodyMovers(character)
    local hrp = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    local moverParent = workspace:FindFirstChildOfClass("Terrain") or workspace
    local moverAttachment = Instance.new("Attachment", hrp)
    moverAttachment.Name = "FlightAttachment"
    local alignOrientation = Instance.new("AlignOrientation")
    alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    alignOrientation.RigidityEnabled = true
    alignOrientation.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    alignOrientation.CFrame = hrp.CFrame
    alignOrientation.Attachment0 = moverAttachment
    alignOrientation.Parent = moverParent
    local linearVelocity = Instance.new("LinearVelocity")
    linearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
    linearVelocity.MaxForce = 9e9
    linearVelocity.Attachment0 = moverAttachment
    linearVelocity.Parent = moverParent
    return alignOrientation, linearVelocity, moverAttachment, humanoid
end
local function startFlying()
    if FlyingEnabled then return end
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if not character then return end
    CurrentAO, CurrentLV, CurrentMoverAttachment = setupFlyBodyMovers(character)
    FlyingEnabled = true
    pcall(function() character.HumanoidRootPart:SetNetworkOwner(LocalPlayer) end)
    local controlModule = getFlyControlModule()
    FlightConnection = RunService.Heartbeat:Connect(function()
        if not FlyingEnabled or not CurrentLV or not CurrentAO then
            if FlightConnection then FlightConnection:Disconnect() FlightConnection = nil end
            return
        end
        local moveVector = controlModule:GetMoveVector()
        local cam = workspace.CurrentCamera
        local F, B, L, R, Q, E = 0, 0, 0, 0, 0, 0
        F = -moveVector.Z; B = moveVector.Z; L = -moveVector.X; R = moveVector.X
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then F = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then B = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then L = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then R = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then Q = 1 end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then E = 1 end
        local flightVector = (cam.CFrame.LookVector * (F - B) + cam.CFrame.RightVector * (R - L) + Vector3.new(0, 1, 0) * (Q - E))
        if flightVector.Magnitude > 0 then
            CurrentLV.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            CurrentLV.VectorVelocity = flightVector.Unit * FlightSpeed
        else
            CurrentLV.VectorVelocity = Vector3.new(0, 0, 0)
        end
        CurrentAO.CFrame = workspace.CurrentCamera.CFrame
        if character and character:FindFirstChild("Humanoid") then character.Humanoid.PlatformStand = true end
    end)
end
local function stopFlying()
    if not FlyingEnabled then return end
    FlyingEnabled = false
    if FlightConnection then FlightConnection:Disconnect() FlightConnection = nil end
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then character.Humanoid.PlatformStand = false end
    if CurrentAO then CurrentAO:Destroy() CurrentAO = nil end
    if CurrentLV then CurrentLV:Destroy() CurrentLV = nil end
    if CurrentMoverAttachment then CurrentMoverAttachment:Destroy() CurrentMoverAttachment = nil end
end
T.wj:CreateToggle({ Name = "飞行模式", CurrentValue = false, Flag = "WJ_Fly", Callback = function(v) if v then startFlying() else stopFlying() end end })
T.wj:CreateSlider({ Name = "飞行速度", Range = {50, 400}, Increment = 10, CurrentValue = 150, Flag = "WJ_FlySpeed", Callback = function(val) FlightSpeed = val end })

local SpinEnabled, SpinSpeed, SpinConnection = false, 5, nil
local function StartSpin()
    if SpinConnection then return end
    SpinConnection = RunService.RenderStepped:Connect(function(dt)
        if not SpinEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(SpinSpeed) * dt * 60, 0)
    end)
end
local function StopSpin()
    SpinEnabled = false
    if SpinConnection then SpinConnection:Disconnect() SpinConnection = nil end
end
LocalPlayer.CharacterAdded:Connect(function() if SpinEnabled then task.wait(0.5) if not SpinConnection then StartSpin() end end end)
T.wj:CreateToggle({ Name = "人物自转", CurrentValue = false, Flag = "WJ_Spin", Callback = function(v) SpinEnabled = v; if v then StartSpin() else StopSpin() end end })
T.wj:CreateSlider({ Name = "旋转速度", Range = {1, 200}, Increment = 1, CurrentValue = 5, Flag = "WJ_SpinSpeed", Callback = function(v) SpinSpeed = v end })

local CONFIG = { defaultSize = 1, minSize = 1, maxSize = 5000, loadDelay = 0.15 }
local HeadScaler = { enabled = false, headSize = CONFIG.defaultSize, heartbeatConn = nil, playerAddedConn = nil, charBindings = {} }
function HeadScaler:UpdateAllHeads()
    local size = Vector3.new(self.headSize, self.headSize, self.headSize)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then pcall(function() head.Size = size; head.CanCollide = false end) end
        end
    end
end
function HeadScaler:BindPlayer(player)
    if self.charBindings[player] then return end
    self.charBindings[player] = player.CharacterAdded:Connect(function() task.wait(CONFIG.loadDelay); self:UpdateAllHeads() end)
    task.spawn(function() task.wait(CONFIG.loadDelay); self:UpdateAllHeads() end)
end
function HeadScaler:ClearAll()
    if self.heartbeatConn then self.heartbeatConn:Disconnect() self.heartbeatConn = nil end
    if self.playerAddedConn then self.playerAddedConn:Disconnect() self.playerAddedConn = nil end
    for player, conn in pairs(self.charBindings) do conn:Disconnect(); self.charBindings[player] = nil end
end
function HeadScaler:SetEnabled(enable)
    if self.enabled == enable then return end
    self:ClearAll(); self.enabled = enable
    if not enable then return end
    self.heartbeatConn = RunService.Heartbeat:Connect(function() self:UpdateAllHeads() end)
    for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer then self:BindPlayer(player) end end
    self.playerAddedConn = Players.PlayerAdded:Connect(function(player) if player ~= LocalPlayer then self:BindPlayer(player) end end)
    self:UpdateAllHeads()
end
function HeadScaler:SetSize(newSize)
    self.headSize = math.clamp(newSize, CONFIG.minSize, CONFIG.maxSize)
    if self.enabled then self:UpdateAllHeads() end
end
Players.PlayerRemoving:Connect(function(player) if HeadScaler.charBindings[player] then HeadScaler.charBindings[player]:Disconnect(); HeadScaler.charBindings[player] = nil end end)
T.wj:CreateToggle({ Name = "修改别人头部大小", CurrentValue = false, Flag = "WJ_HeadScale", Callback = function(value) HeadScaler:SetEnabled(value) end })
T.wj:CreateInput({ Name = "别人头部尺寸", PlaceholderText = "输入数字 1-5000", CurrentValue = "1", Numeric = true, Flag = "WJ_HeadSize", Callback = function(value) local num = tonumber(value); if num then HeadScaler:SetSize(num) end end })
T.wj:CreateToggle({ Name = "无限跳", CurrentValue = false, Flag = "WJ_InfJump", Callback = function(state) isInfiniteJumpEnabled = state end })

local clipConn
T.wj:CreateToggle({
    Name = "穿墙", CurrentValue = false, Flag = "WJ_Noclip",
    Callback = function(enabled)
        if clipConn then clipConn:Disconnect() clipConn = nil end
        if enabled then
            clipConn = RunService.Stepped:Connect(function()
                local char = LocalPlayer.Character
                if not char then return end
                for _, part in ipairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
            end)
        else
            local char = LocalPlayer.Character
            if char then for _, part in ipairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = true end end end
        end
    end,
})
T.wj:CreateButton({ Name = "踏空行走", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float'))() end })
T.wj:CreateButton({
    Name = "定", Callback = function()
        local player = LocalPlayer; local freeze, lockY = false, nil; local character, root
        local function LoadCharacter() character = player.Character or player.CharacterAdded:Wait(); root = character:WaitForChild("HumanoidRootPart") end
        LoadCharacter(); player.CharacterAdded:Connect(function() task.wait(1) LoadCharacter() end)
        local gui = Instance.new("ScreenGui"); gui.Name = "AirFreezeUI"; gui.ResetOnSpawn = false; gui.Parent = player:WaitForChild("PlayerGui")
        local main = Instance.new("Frame"); main.Size = UDim2.new(0,90,0,90); main.Position = UDim2.new(0.5,-70,0.65,0); main.BackgroundColor3 = Color3.fromRGB(25,25,30); main.Parent = gui
        local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,12); corner.Parent = main
        local title = Instance.new("TextLabel"); title.Size = UDim2.new(1,0,0,26); title.BackgroundTransparency = 1; title.Text = "定"; title.TextColor3 = Color3.new(1,1,1); title.TextSize = 16; title.Parent = main
        local toggle = Instance.new("TextButton"); toggle.Size = UDim2.new(0,100,0,32); toggle.Position = UDim2.new(0.5,-50,0.48,0); toggle.BackgroundColor3 = Color3.fromRGB(0,170,255); toggle.Text = "开启"; toggle.TextColor3 = Color3.new(1,1,1); toggle.TextSize = 14; toggle.Parent = main
        local tc = Instance.new("UICorner"); tc.CornerRadius = UDim.new(0,8); tc.Parent = toggle
        toggle.MouseButton1Click:Connect(function()
            freeze = not freeze
            if freeze then toggle.Text = "关闭"; toggle.BackgroundColor3 = Color3.fromRGB(255,70,70); if root then lockY = root.Position.Y end
            else toggle.Text = "开启"; toggle.BackgroundColor3 = Color3.fromRGB(0,170,255); lockY = nil end
        end)
        RunService.Heartbeat:Connect(function()
            if freeze and root and lockY then
                local pos = root.Position; root.AssemblyLinearVelocity = Vector3.zero; root.AssemblyAngularVelocity = Vector3.zero; root.CFrame = CFrame.new(pos.X, lockY, pos.Z) * root.CFrame.Rotation
            end
        end)
    end,
})

-- ==================== 万圣节 (WSJ) ====================
do
    local WSJ_RunService = game:GetService("RunService")
    local WSJ_Workspace = workspace
    local WSJ_Debris = game:GetService("Debris")
    local WSJ_SoundService = game:GetService("SoundService")
    
    local DevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
    if DevvFolder then
        local DevvModule  = require(DevvFolder)
        local Network     = DevvModule.load("Network")
        local ClientTools = require(ReplicatedStorage.Client.Wanted.Modules.ClientTools)
        local MathUtil    = DevvModule.load("MathUtil")
        local nuid        = DevvModule.load("NUID")
        local fireServer  = Network.FireServer

        local MobAuraConfig = { Enabled = false, Range = 300, Interval = 0.01, ShowTracer = true, TracerColor = Color3.fromRGB(255, 80, 80), TracerWidth = 0.15, TracerLife = 0.2, PlaySound = true, SoundId = "rbxassetid://6607204501", SoundVolume = 0.4 }
        local MobChamsConfig = { Enabled = false, TextSize = 10, EspColor = Color3.fromRGB(0, 255, 0) }

        local TracerFolder = WSJ_Workspace:FindFirstChild("__MobTracers") or Instance.new("Folder", WSJ_Workspace)
        TracerFolder.Name = "__MobTracers"

        local function createTracer(fromPos, toPos)
            if not MobAuraConfig.ShowTracer then return end
            pcall(function()
                local a0 = Instance.new("Attachment", TracerFolder); a0.WorldPosition = fromPos
                local a1 = Instance.new("Attachment", TracerFolder); a1.WorldPosition = toPos
                local beam = Instance.new("Beam", TracerFolder)
                beam.Attachment0, beam.Attachment1 = a0, a1
                beam.Color = ColorSequence.new(MobAuraConfig.TracerColor)
                beam.Width0, beam.Width1 = MobAuraConfig.TracerWidth, MobAuraConfig.TracerWidth
                beam.LightEmission, beam.LightInfluence, beam.FaceCamera = 1, 0, true
                beam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 0.9)})
                WSJ_Debris:AddItem(beam, MobAuraConfig.TracerLife); WSJ_Debris:AddItem(a0, MobAuraConfig.TracerLife); WSJ_Debris:AddItem(a1, MobAuraConfig.TracerLife)
            end)
        end
        local function playHitSound()
            if not MobAuraConfig.PlaySound then return end
            pcall(function()
                local snd = Instance.new("Sound", WSJ_SoundService)
                snd.SoundId, snd.Volume = MobAuraConfig.SoundId, MobAuraConfig.SoundVolume
                snd:Play(); WSJ_Debris:AddItem(snd, 1)
            end)
        end

        WSJ_RunService.RenderStepped:Connect(function()
            local mobsFolder = WSJ_Workspace:FindFirstChild("Mobs")
            if not mobsFolder then return end
            if not MobChamsConfig.Enabled then
                for _, mob in ipairs(mobsFolder:GetChildren()) do
                    if mob:IsA("Model") then
                        local hl = mob:FindFirstChild("__MobHighlight"); if hl then hl:Destroy() end
                        local head = mob:FindFirstChild("Head") or mob:FindFirstChild("HumanoidRootPart")
                        if head then local bb = head:FindFirstChild("__MobNameTag"); if bb then bb:Destroy() end end
                    end
                end
                return 
            end
            for _, mob in ipairs(mobsFolder:GetChildren()) do
                if mob:IsA("Model") then
                    pcall(function()
                        local head = mob:FindFirstChild("Head") or mob:FindFirstChild("HumanoidRootPart")
                        local hum = mob:FindFirstChildOfClass("Humanoid")
                        if head and hum then
                            local hl = mob:FindFirstChild("__MobHighlight")
                            if not hl then hl = Instance.new("Highlight"); hl.Name = "__MobHighlight"; hl.FillTransparency = 0.3; hl.OutlineTransparency = 0; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = mob end
                            hl.FillColor = MobChamsConfig.EspColor; hl.OutlineColor = MobChamsConfig.EspColor
                            local bb = head:FindFirstChild("__MobNameTag")
                            if not bb then
                                bb = Instance.new("BillboardGui"); bb.Name = "__MobNameTag"; bb.Size = UDim2.new(0, 100, 0, 25); bb.StudsOffset = Vector3.new(0, 1.5, 0); bb.AlwaysOnTop = true; bb.Parent = head
                                local textName = Instance.new("TextLabel"); textName.Name = "TagText"; textName.Size = UDim2.new(1, 0, 0.5, 0); textName.BackgroundTransparency = 1; textName.Font = Enum.Font.GothamBold; textName.TextSize = MobChamsConfig.TextSize; textName.TextStrokeTransparency = 0.2; textName.TextColor3 = MobChamsConfig.EspColor; textName.Text = "港猫的小弟"; textName.Parent = bb
                                local textHealth = Instance.new("TextLabel"); textHealth.Name = "HealthText"; textHealth.Size = UDim2.new(1, 0, 0.5, 0); textHealth.Position = UDim2.new(0, 0, 0.5, 0); textHealth.BackgroundTransparency = 1; textHealth.Font = Enum.Font.GothamBold; textHealth.TextSize = MobChamsConfig.TextSize; textHealth.TextStrokeTransparency = 0.2; textHealth.TextColor3 = Color3.new(1, 1, 1); textHealth.Parent = bb
                            end
                            local realHealth = mob:GetAttribute("health") or hum.Health
                            local maxHealth = mob:GetAttribute("maxHealth") or hum.MaxHealth
                            local tagText = bb:FindFirstChild("TagText"); if tagText then tagText.TextColor3 = MobChamsConfig.EspColor; tagText.TextSize = MobChamsConfig.TextSize end
                            local healthText = bb:FindFirstChild("HealthText"); if healthText then healthText.Text = string.format("HP: %d/%d", math.floor(realHealth), math.floor(maxHealth)); healthText.TextSize = MobChamsConfig.TextSize; healthText.TextColor3 = (realHealth < maxHealth * 0.3) and Color3.fromRGB(255, 50, 50) or Color3.new(1, 1, 1) end
                        end
                    end)
                end
            end
        end)

        local function getClosestMob()
            local myChar = LocalPlayer.Character; if not myChar then return nil end
            local myHRP = myChar:FindFirstChild("HumanoidRootPart"); if not myHRP then return nil end
            local closestMob = nil; local minDist = math.huge; local mobsFolder = WSJ_Workspace:FindFirstChild("Mobs"); if not mobsFolder then return nil end
            for _, mob in ipairs(mobsFolder:GetChildren()) do
                local hum = mob:FindFirstChildOfClass("Humanoid"); local hrp = mob:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 then
                    local dist = (myHRP.Position - hrp.Position).Magnitude
                    if dist <= MobAuraConfig.Range and dist < minDist then minDist = dist; closestMob = hrp end
                end
            end
            return closestMob
        end

        local function fireAtMob(targetPart)
            local char = LocalPlayer.Character; local myHead = char and char:FindFirstChild("Head"); if not myHead then return end
            local ok, tool = pcall(ClientTools.GetLocalEquippedTool); if not ok or not tool or not tool.toolId then return end
            local ts = tool.toolState
            if ts and ts.ammo and ts.ammo <= 0 then pcall(fireServer, "reload", tool.toolId); pcall(fireServer, "chamber", tool.toolId); return end
            local targetPos = targetPart.Position; local originPos = myHead.Position; local dir = targetPos - originPos; local bulletId = nuid(); local shootCF = MathUtil.CompressCFrame(CFrame.new(originPos, targetPos))
            pcall(function() fireServer("shoot", tool.toolId, shootCF, { { bulletId, shootCF } }) end)
            if ts and ts.ammo then ts.ammo = ts.ammo - 1 end
            createTracer(originPos, targetPos); playHitSound()
            local unit = dir.Magnitude > 0.001 and dir.Unit or myHead.CFrame.LookVector
            local args = { { massLimit = 5, hit = targetPart, position = targetPos, normal = -unit, material = targetPart.Material or Enum.Material.Plastic, distance = dir.Magnitude, collisionPoint = targetPos, direction = unit, speed = 1196.285, source = { sourceType = "Bullet", sourceId = bulletId, sourceToolId = tool.toolId, sourcePlayerId = LocalPlayer.UserId }, hitName = "HumanoidRootPart", hitType = "mob", mobType = targetPart.Parent.Name } }
            pcall(function() fireServer("registerProjectileHits", bulletId, tool.toolId, args) end)
        end

        task.spawn(function()
            while true do
                if MobAuraConfig.Enabled then pcall(function() local mobPart = getClosestMob(); if mobPart then fireAtMob(mobPart) end end); task.wait(MobAuraConfig.Interval)
                else task.wait(0.5) end
            end
        end)

        T.wsj:CreateToggle({ Name = "启用怪物光环", CurrentValue = false, Flag = "WSJ_Aura", Callback = function(v) MobAuraConfig.Enabled = v; Airflow:Notify({ Title = "光环", Content = v and "已开启" or "已关闭", Type = "Info", Duration = 2 }) end })
        T.wsj:CreateSlider({ Name = "最大攻击距离", Range = {50, 2000}, Increment = 10, CurrentValue = 300, Flag = "WSJ_Range", Callback = function(v) MobAuraConfig.Range = v end })
        T.wsj:CreateSlider({ Name = "极限射速", Range = {0.01, 1}, Increment = 0.01, CurrentValue = 0.01, Flag = "WSJ_Interval", Callback = function(v) MobAuraConfig.Interval = v end })
        T.wsj:CreateToggle({ Name = "显示弹道射线", CurrentValue = true, Flag = "WSJ_Tracer", Callback = function(v) MobAuraConfig.ShowTracer = v end })
        T.wsj:CreateToggle({ Name = "播放命中音效", CurrentValue = true, Flag = "WSJ_Sound", Callback = function(v) MobAuraConfig.PlaySound = v end })
        T.wsj:CreateDropdown({ Name = "选择音效", Options = { "Neverlose", "Gamesense", "Fatality", "Minecraft", "经典叮叮叮" }, CurrentOption = "Neverlose", Flag = "WSJ_SndSelect", Callback = function(v) local map = { ["Neverlose"] = "rbxassetid://6607204501", ["Gamesense"] = "rbxassetid://5633695679", ["Fatality"] = "rbxassetid://6607142036", ["Minecraft"] = "rbxassetid://7151570575", ["经典叮叮叮"] = "rbxassetid://4590662766" }; MobAuraConfig.SoundId = map[v] or "rbxassetid://6607204501" end })
        T.wsj:CreateToggle({ Name = "启用怪物内透", CurrentValue = false, Flag = "WSJ_Chams", Callback = function(v) MobChamsConfig.Enabled = v; Airflow:Notify({ Title = "内透", Content = v and "已开启" or "已关闭", Type = "Info", Duration = 2 }) end })
        T.wsj:CreateSlider({ Name = "字体大小", Range = {8, 18}, Increment = 1, CurrentValue = 10, Flag = "WSJ_ChamsSize", Callback = function(v) MobChamsConfig.TextSize = v end })
        T.wsj:CreateDropdown({ Name = "透视颜色", Options = { "绿色", "红色", "蓝色", "紫色", "黄色", "白色" }, CurrentOption = "绿色", Flag = "WSJ_ChamsColor", Callback = function(v) local map = { ["绿色"] = Color3.fromRGB(0, 255, 0), ["红色"] = Color3.fromRGB(255, 50, 50), ["蓝色"] = Color3.fromRGB(50, 150, 255), ["紫色"] = Color3.fromRGB(180, 50, 255), ["黄色"] = Color3.fromRGB(255, 255, 50), ["白色"] = Color3.fromRGB(255, 255, 255) }; MobChamsConfig.EspColor = map[v] or Color3.fromRGB(0, 255, 0) end })
    end

    local ZM_Enabled, ZM_ScaleMultiplier, ZM_HighlightColor, ZM_OrigData, ZM_Conn = false, 2.0, Color3.fromRGB(255, 50, 50), {}, nil
    local function ZM_Cleanup()
        local mobsFolder = workspace:FindFirstChild("Mobs")
        if mobsFolder then for _, mob in ipairs(mobsFolder:GetChildren()) do if mob:IsA("Model") then local hl = mob:FindFirstChild("NPC_Marker"); if hl then hl:Destroy() end; if ZM_OrigData[mob] then pcall(function() mob:ScaleTo(ZM_OrigData[mob].Scale) end) end end end end
        table.clear(ZM_OrigData)
    end
    local function ZM_Tick()
        local mobsFolder = workspace:FindFirstChild("Mobs"); if not mobsFolder then return end
        for _, mob in ipairs(mobsFolder:GetChildren()) do
            if mob:IsA("Model") then
                local hum = mob:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local hl = mob:FindFirstChild("NPC_Marker")
                    if not hl then hl = Instance.new("Highlight"); hl.Name = "NPC_Marker"; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.FillTransparency = 0.5; hl.OutlineTransparency = 0; hl.Parent = mob end
                    hl.FillColor = ZM_HighlightColor; hl.OutlineColor = ZM_HighlightColor
                    if not ZM_OrigData[mob] then local origScale = 1; pcall(function() origScale = mob:GetScale() end); ZM_OrigData[mob] = { Scale = origScale } end
                    local targetScale = ZM_OrigData[mob].Scale * ZM_ScaleMultiplier; local currentScale = 1; pcall(function() currentScale = mob:GetScale() end)
                    if math.abs(currentScale - targetScale) > 0.01 then pcall(function() mob:ScaleTo(targetScale); for _, part in ipairs(mob:GetDescendants()) do if part:IsA("BasePart") then part.Transparency = 0; part.CanCollide = true; part.Massless = true end end end) end
                end
            end
        end
    end
    local function ZM_Start() if ZM_Conn then return end; ZM_Conn = RunService.RenderStepped:Connect(ZM_Tick) end
    local function ZM_Stop() if ZM_Conn then ZM_Conn:Disconnect(); ZM_Conn = nil end; ZM_Cleanup() end
    T.wsj:CreateToggle({ Name = "开启僵尸范围", CurrentValue = false, Flag = "WSJ_ZM", Callback = function(v) ZM_Enabled = v; if v then ZM_Start(); Airflow:Notify({ Title = "僵尸范围", Content = "已开启", Type = "Success", Duration = 2 }) else ZM_Stop(); Airflow:Notify({ Title = "僵尸范围", Content = "已关闭", Type = "Info", Duration = 2 }) end end })
    T.wsj:CreateSlider({ Name = "实体放大倍数", Range = {1.0, 5.0}, Increment = 0.5, CurrentValue = 2.0, Flag = "WSJ_ZMScale", Callback = function(v) ZM_ScaleMultiplier = v end })
    T.wsj:CreateDropdown({ Name = "高亮颜色", Options = { "红色", "绿色", "蓝色", "黄色", "紫色", "白色", "青色" }, CurrentOption = "红色", Flag = "WSJ_ZMColor", Callback = function(v) local map = { ["红色"] = Color3.fromRGB(255, 50, 50), ["绿色"] = Color3.fromRGB(50, 255, 50), ["蓝色"] = Color3.fromRGB(50, 150, 255), ["黄色"] = Color3.fromRGB(255, 255, 50), ["紫色"] = Color3.fromRGB(180, 50, 255), ["白色"] = Color3.fromRGB(255, 255, 255), ["青色"] = Color3.fromRGB(50, 255, 255) }; ZM_HighlightColor = map[v] or Color3.fromRGB(255, 50, 50) end })
end

-- ==================== 准心设置 (ZX) ====================
do
    local CFG = { Enabled = true, Style = "十字", Color = Color3.fromRGB(0, 255, 160), Size = 12, Thickness = 2, Gap = 4, Transparency = 0, DotSize = 2, FollowMouse = false, Rotate = false, RotateSpeed = 60, Rotation = 0, AutoColor = true, ColorSpeed = 0.3, ColorHue = 0 }
    local ScreenGui = Instance.new("ScreenGui"); ScreenGui.Name = "CustomCrosshair"; ScreenGui.ResetOnSpawn = false; ScreenGui.IgnoreGuiInset = true; ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; ScreenGui.DisplayOrder = 9999
    local ok = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ok or not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    local Container = Instance.new("Frame"); Container.Name = "Container"; Container.AnchorPoint = Vector2.new(0.5, 0.5); Container.Position = UDim2.fromScale(0.5, 0.5); Container.Size = UDim2.fromOffset(100, 100); Container.BackgroundTransparency = 1; Container.Parent = ScreenGui
    local Lines = Instance.new("Frame"); Lines.Name = "Lines"; Lines.AnchorPoint = Vector2.new(0.5, 0.5); Lines.Position = UDim2.fromScale(0.5, 0.5); Lines.Size = UDim2.fromOffset(0, 0); Lines.BackgroundTransparency = 1; Lines.Parent = Container
    local Elements = {}
    local function ClearElements() for _, el in ipairs(Elements) do if el and el.Parent then el:Destroy() end end table.clear(Elements) end
    local function CreateLine(width, height, offsetX, offsetY)
        local line = Instance.new("Frame"); line.AnchorPoint = Vector2.new(0.5, 0.5); line.Position = UDim2.new(0.5, offsetX, 0.5, offsetY); line.Size = UDim2.fromOffset(width, height); line.BackgroundColor3 = CFG.Color; line.BackgroundTransparency = CFG.Transparency; line.BorderSizePixel = 0; line.Parent = Lines; table.insert(Elements, line); return line
    end
    local function CreateDot(size)
        local dot = Instance.new("Frame"); dot.AnchorPoint = Vector2.new(0.5, 0.5); dot.Position = UDim2.fromScale(0.5, 0.5); dot.Size = UDim2.fromOffset(size, size); dot.BackgroundColor3 = CFG.Color; dot.BackgroundTransparency = CFG.Transparency; dot.BorderSizePixel = 0; dot.Parent = Lines
        local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(1, 0); corner.Parent = dot; table.insert(Elements, dot); return dot
    end
    local function CreateCircle(size, thickness)
        local circle = Instance.new("Frame"); circle.AnchorPoint = Vector2.new(0.5, 0.5); circle.Position = UDim2.fromScale(0.5, 0.5); circle.Size = UDim2.fromOffset(size, size); circle.BackgroundTransparency = 1; circle.Parent = Lines
        local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(1, 0); corner.Parent = circle
        local stroke = Instance.new("UIStroke"); stroke.Color = CFG.Color; stroke.Thickness = thickness; stroke.Transparency = CFG.Transparency; stroke.Parent = circle; table.insert(Elements, circle); return circle
    end
    local function UpdateElementColors()
        for _, el in ipairs(Elements) do
            if el:IsA("Frame") then
                local stroke = el:FindFirstChildOfClass("UIStroke")
                if stroke then stroke.Color = CFG.Color; stroke.Transparency = CFG.Transparency
                else el.BackgroundColor3 = CFG.Color; el.BackgroundTransparency = CFG.Transparency end
            end
        end
    end
    local function DrawCrosshair()
        ClearElements(); if not CFG.Enabled then return end
        local S, T, G = CFG.Size, CFG.Thickness, CFG.Gap; local style = CFG.Style
        if style == "十字" then CreateLine(T, S, 0, -(G + S/2)); CreateLine(T, S, 0, (G + S/2)); CreateLine(S, T, -(G + S/2), 0); CreateLine(S, T, (G + S/2), 0)
        elseif style == "点" then CreateDot(CFG.DotSize * 2)
        elseif style == "圆" then CreateCircle(S * 2, T)
        elseif style == "十字+点" then CreateLine(T, S, 0, -(G + S/2)); CreateLine(T, S, 0, (G + S/2)); CreateLine(S, T, -(G + S/2), 0); CreateLine(S, T, (G + S/2), 0); CreateDot(CFG.DotSize * 2)
        elseif style == "圆+点" then CreateCircle(S * 2, T); CreateDot(CFG.DotSize * 2)
        elseif style == "X形" then local offsets = { {G + S/2, 0}, {-(G + S/2), 0}, {0, G + S/2}, {0, -(G + S/2)} }; for _, off in ipairs(offsets) do local line = CreateLine(T, S, off[1], off[2]); line.Rotation = 45 end
        elseif style == "括号" then
            local B = S; CreateLine(B, T, 0, -(G + B)); CreateLine(T, T*3, -(B/2), -(G + B) + T*1.5); CreateLine(T, T*3, (B/2), -(G + B) + T*1.5)
            CreateLine(B, T, 0, (G + B)); CreateLine(T, T*3, -(B/2), (G + B) - T*1.5); CreateLine(T, T*3, (B/2), (G + B) - T*1.5)
            CreateLine(T, B, -(G + B), 0); CreateLine(T*3, T, -(G + B) + T*1.5, -(B/2)); CreateLine(T*3, T, -(G + B) + T*1.5, (B/2))
            CreateLine(T, B, (G + B), 0); CreateLine(T*3, T, (G + B) - T*1.5, -(B/2)); CreateLine(T*3, T, (G + B) - T*1.5, (B/2))
        end
        UpdateElementColors()
    end
    RunService.RenderStepped:Connect(function(dt)
        if CFG.FollowMouse then local m = UserInputService:GetMouseLocation(); Container.Position = UDim2.fromOffset(m.X, m.Y) else Container.Position = UDim2.fromScale(0.5, 0.5) end
        if CFG.Rotate then CFG.Rotation = (CFG.Rotation + CFG.RotateSpeed * dt) % 360; Container.Rotation = CFG.Rotation end
        if CFG.AutoColor then CFG.ColorHue = (CFG.ColorHue + CFG.ColorSpeed * dt) % 1; CFG.Color = Color3.fromHSV(CFG.ColorHue, 1, 1); UpdateElementColors() end
    end)
    T.zx:CreateToggle({ Name = "启用准星", CurrentValue = true, Flag = "ZX_Enable", Callback = function(v) CFG.Enabled = v; Container.Visible = v; DrawCrosshair() end })
    T.zx:CreateDropdown({ Name = "准星样式", Options = { "十字", "点", "圆", "十字+点", "圆+点", "X形", "括号" }, CurrentOption = "十字", Flag = "ZX_Style", Callback = function(v) CFG.Style = v; DrawCrosshair() end })
    T.zx:CreateToggle({ Name = "跟随鼠标", CurrentValue = false, Flag = "ZX_Mouse", Callback = function(v) CFG.FollowMouse = v end })
    T.zx:CreateToggle({ Name = "启用旋转", CurrentValue = false, Flag = "ZX_Rotate", Callback = function(v) CFG.Rotate = v; if not v then CFG.Rotation = 0; Container.Rotation = 0 end end })
    T.zx:CreateSlider({ Name = "旋转速度", Range = {5, 360}, Increment = 5, CurrentValue = 60, Flag = "ZX_RotSpeed", Callback = function(v) CFG.RotateSpeed = v end })
    T.zx:CreateToggle({ Name = "启用自动变色", CurrentValue = true, Flag = "ZX_AutoColor", Callback = function(v) CFG.AutoColor = v end })
    T.zx:CreateSlider({ Name = "变色速度", Range = {0.05, 2}, Increment = 0.05, CurrentValue = 0.3, Flag = "ZX_ColorSpeed", Callback = function(v) CFG.ColorSpeed = v end })
    T.zx:CreateSlider({ Name = "准星大小", Range = {2, 40}, Increment = 1, CurrentValue = 12, Flag = "ZX_Size", Callback = function(v) CFG.Size = v; DrawCrosshair() end })
    T.zx:CreateSlider({ Name = "线条厚度", Range = {1, 8}, Increment = 1, CurrentValue = 2, Flag = "ZX_Thick", Callback = function(v) CFG.Thickness = v; DrawCrosshair() end })
    T.zx:CreateSlider({ Name = "中心间隙", Range = {0, 30}, Increment = 1, CurrentValue = 4, Flag = "ZX_Gap", Callback = function(v) CFG.Gap = v; DrawCrosshair() end })
    T.zx:CreateSlider({ Name = "中心点大小", Range = {1, 10}, Increment = 1, CurrentValue = 2, Flag = "ZX_Dot", Callback = function(v) CFG.DotSize = v; DrawCrosshair() end })
    T.zx:CreateSlider({ Name = "透明度", Range = {0, 1}, Increment = 0.05, CurrentValue = 0, Flag = "ZX_Trans", Callback = function(v) CFG.Transparency = v; UpdateElementColors() end })
    DrawCrosshair()
end

-- ==================== 光环 (GH) ====================
do
    local AuraDevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
    if AuraDevvFolder then
        local AuraDevvModule = require(AuraDevvFolder); local AuraNetwork = AuraDevvModule.load("Network"); local AuraFireServer = AuraNetwork.FireServer
        local AuraConfig = { Stomp = { Enabled = false, Interval = 0.5, Range = 50 }, Arrest = { Enabled = false, Interval = 0.5, Range = 50 }, Grab = { Enabled = false, Interval = 0.5, Range = 50 }, Revive = { Enabled = false, Interval = 0.5, Range = 50 } }
        local function getClosestAuraTarget(range, skipTeam)
            local myChar = LocalPlayer.Character; if not myChar then return nil end
            local myHRP = myChar:FindFirstChild("HumanoidRootPart"); if not myHRP then return nil end
            local closest, minDist = nil, math.huge
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local isTeammate = plr.Team and LocalPlayer.Team and plr.Team == LocalPlayer.Team
                    if not (skipTeam and isTeammate) then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart"); local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                        if hrp and hum and hum.Health > 0 then
                            local dist = (hrp.Position - myHRP.Position).Magnitude
                            if dist <= range and dist < minDist then minDist = dist; closest = plr end
                        end
                    end
                end
            end
            return closest
        end
        task.spawn(function() while true do if AuraConfig.Stomp.Enabled then local target = getClosestAuraTarget(AuraConfig.Stomp.Range, true); if target then pcall(function() AuraFireServer("finish", target.UserId) end) end end; task.wait(AuraConfig.Stomp.Interval) end end)
        task.spawn(function() while true do if AuraConfig.Arrest.Enabled then local target = getClosestAuraTarget(AuraConfig.Arrest.Range, false); if target then pcall(function() AuraFireServer("arrest", target.UserId) end) end end; task.wait(AuraConfig.Arrest.Interval) end end)
        task.spawn(function() while true do if AuraConfig.Grab.Enabled then local target = getClosestAuraTarget(AuraConfig.Grab.Range, true); if target then pcall(function() AuraFireServer("grab", target.UserId) end) end end; task.wait(AuraConfig.Grab.Interval) end end)
        task.spawn(function() while true do if AuraConfig.Revive.Enabled then local target = getClosestAuraTarget(AuraConfig.Revive.Range, false); if target then pcall(function() AuraFireServer("revive", target.UserId) end) end end; task.wait(AuraConfig.Revive.Interval) end end)
        T.gh:CreateToggle({ Name = "启用踩踏", CurrentValue = false, Flag = "GH_Stomp", Callback = function(v) AuraConfig.Stomp.Enabled = v end })
        T.gh:CreateSlider({ Name = "踩踏间隔", Range = {0.01, 5}, Increment = 0.01, CurrentValue = 0.5, Flag = "GH_StompInt", Callback = function(v) AuraConfig.Stomp.Interval = v end })
        T.gh:CreateToggle({ Name = "启用逮捕", CurrentValue = false, Flag = "GH_Arrest", Callback = function(v) AuraConfig.Arrest.Enabled = v end })
        T.gh:CreateSlider({ Name = "逮捕间隔", Range = {0.01, 5}, Increment = 0.01, CurrentValue = 0.5, Flag = "GH_ArrestInt", Callback = function(v) AuraConfig.Arrest.Interval = v end })
        T.gh:CreateToggle({ Name = "启用抓取光环", CurrentValue = false, Flag = "GH_Grab", Callback = function(v) AuraConfig.Grab.Enabled = v end })
        T.gh:CreateSlider({ Name = "抓取间隔", Range = {0.01, 5}, Increment = 0.01, CurrentValue = 0.5, Flag = "GH_GrabInt", Callback = function(v) AuraConfig.Grab.Interval = v end })
        T.gh:CreateToggle({ Name = "启用救援", CurrentValue = false, Flag = "GH_Revive", Callback = function(v) AuraConfig.Revive.Enabled = v end })
        T.gh:CreateSlider({ Name = "救援间隔", Range = {0.01, 5}, Increment = 0.01, CurrentValue = 0.5, Flag = "GH_ReviveInt", Callback = function(v) AuraConfig.Revive.Interval = v end })
    end
end

-- ==================== 进阶辅助瞄准 (FZ) ====================
do
    local ClientSettings, SettingsData, AimAssistModule
    local modulesOk = pcall(function()
        local DevvFolder = ReplicatedStorage:FindFirstChild("Devv") or ReplicatedStorage:FindFirstChild("devv")
        if not DevvFolder then error("Devv 不存在") end
        local DevvModule = require(DevvFolder); local load = DevvModule.load
        ClientSettings = load("ClientSettings"); SettingsData = require(ReplicatedStorage.Shared.Wanted.Indicies.SettingsData); AimAssistModule = require(ReplicatedStorage.Client.Wanted.Objects.ClientTool.Components.Tools.Guns.AimAssist)
    end)
    if not modulesOk then
        Airflow:Notify({ Title = "辅助瞄准", Content = "未检测到 Wanted 模块", Type = "Error", Duration = 5 })
    else
        local AA = { Enabled = false, Part = "Body", SpeedX = 2.7, SpeedY = 1, PredictionX = 2.8, PredictionY = 2.6, IgnoreTeammate = true, CampFilter = "全部", WallCheck = true, ShowFOV = false, FOVRadius = 250, FOVFixed = true, FOVColor = Color3.fromRGB(190, 120, 255), FOVThickness = 1.5, FOVTransparency = 0.3, FOVSides = 64 }
        local originalAimStep = AimAssistModule.Step
        local function setAssistSensitivity(v) pcall(function() local setting = SettingsData.settingDataByName and SettingsData.settingDataByName.assistSensitivity; if type(setting) == "table" then setting.defaultValue = v end; if type(ClientSettings.Set) == "function" then ClientSettings.Set("assistSensitivity", v) end end) end
        local function getViewportCenter(cam) if UserInputService.TouchEnabled then return cam.ViewportSize.X * 0.5, cam.ViewportSize.Y * 0.5 end; local m = UserInputService:GetMouseLocation(); return m.X, m.Y end
        local function getCamp(plr) if not plr then return nil end; local team = plr:GetAttribute("currentTeam"); if type(team) == "string" then return team end; if plr.Team then return plr.Team.Name end; return nil end
        local function isTeammate(plr) if plr == LocalPlayer then return true end; local myCamp = getCamp(LocalPlayer); local pCamp = getCamp(plr); if myCamp == nil or pCamp == nil then return plr.Team ~= nil and plr.Team == LocalPlayer.Team end; return myCamp == pCamp end
        local rayParams = RaycastParams.new(); rayParams.FilterType = Enum.RaycastFilterType.Exclude; rayParams.IgnoreWater = true
        local function checkWall(targetPart)
            if not targetPart or not targetPart.Parent then return true end; local char = LocalPlayer.Character; if not char then return true end
            local origin = Camera.CFrame.Position; local targetPos = targetPart.Position; local dir = targetPos - origin; local dist = dir.Magnitude; if dist < 0.1 then return false end
            rayParams.FilterDescendantsInstances = { char, Camera }; local result = workspace:Raycast(origin, dir, rayParams)
            if not result then return false end
            if result.Instance and result.Instance:IsDescendantOf(targetPart.Parent) then return false end
            if (result.Position - targetPos).Magnitude <= 0.6 then return false end
            return true
        end
        local function isAllowedTarget(plr)
            if AA.CampFilter ~= "全部" then local camp = getCamp(plr); if AA.CampFilter == "仅警察" and camp ~= "police" then return false end; if AA.CampFilter == "仅帮派" and camp ~= "syndicate" then return false end; if AA.CampFilter == "仅平民" and camp ~= "civilian" then return false end; return true
            else if AA.IgnoreTeammate and isTeammate(plr) then return false end; return true end
        end
        local fovCircle = Drawing.new("Circle"); fovCircle.Visible = false; fovCircle.Filled = false; fovCircle.NumSides = AA.FOVSides; fovCircle.Radius = AA.FOVRadius; fovCircle.Thickness = AA.FOVThickness; fovCircle.Transparency = AA.FOVTransparency; fovCircle.Color = AA.FOVColor; fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local function updateFOVCircle()
            if not fovCircle then return end
            fovCircle.Visible = AA.ShowFOV and AA.Enabled; fovCircle.Radius = AA.FOVRadius; fovCircle.Thickness = AA.FOVThickness; fovCircle.Transparency = AA.FOVTransparency; fovCircle.Color = AA.FOVColor; fovCircle.NumSides = AA.FOVSides
            if AA.ShowFOV and AA.Enabled then if AA.FOVFixed then fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2) else local m = UserInputService:GetMouseLocation(); fovCircle.Position = Vector2.new(m.X, m.Y) end end
        end
        RunService.RenderStepped:Connect(function() pcall(updateFOVCircle) end)
        local function aimStep(self, dt)
            local tool = self and self.tool; local ts = tool and tool.toolState
            if not ts or (ts.ammo or 0) <= 0 then return originalAimStep(self, dt) end
            local char = LocalPlayer.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); local cam = workspace.CurrentCamera
            if not char or not hrp or not cam then return originalAimStep(self, dt) end
            local cFrame = cam.CFrame; local sx, sy = getViewportCenter(cam); local bestScore, bestYaw, bestPitch = math.huge, nil, nil
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and isAllowedTarget(plr) then
                    local pchar = plr.Character; local phum = pchar and pchar:FindFirstChildOfClass("Humanoid"); local phrp = pchar and pchar:FindFirstChild("HumanoidRootPart"); local phead = pchar and pchar:FindFirstChild("Head")
                    if pchar and phum and phum.Health > 0 and phrp then
                        local target = (AA.Part == "Head") and (phead or phrp) or (pchar:FindFirstChild("UpperTorso") or pchar:FindFirstChild("Torso") or phrp)
                        local blocked = AA.WallCheck and checkWall(target) or false
                        if not blocked then
                            local predict = target.Position + (target.AssemblyLinearVelocity or Vector3.zero) * (AA.PredictionX * 0.01)
                            local rel = cFrame:PointToObjectSpace(predict); local mag = rel.Magnitude
                            if mag > 0.35 then
                                local inv = 1 / mag; local fwd = -rel.Z * inv
                                if fwd > 0.02 then
                                    local sp = cam:WorldToViewportPoint(predict); local dx, dy = sp.X - sx, sp.Y - sy; local pixDist = math.sqrt(dx * dx + dy * dy)
                                    if pixDist <= AA.FOVRadius then
                                        local score = pixDist * pixDist
                                        if score < bestScore then local yaw = math.atan2(rel.X * inv, fwd); local pitch = math.atan2(rel.Y * inv, fwd); bestYaw, bestPitch = math.deg(yaw), math.deg(pitch); bestScore = score end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if bestYaw then
                local mod = 1; if tool and tool.GetData then local ok, data = pcall(tool.GetData, tool); if ok and data and data.aimAssistMod then mod = data.aimAssistMod end end
                local spX = AA.SpeedX * mod * dt * 10; local spY = AA.SpeedY * mod * dt * 10
                local curX = LocalPlayer:GetAttribute("xAngle") or 0; local curY = LocalPlayer:GetAttribute("yAngle") or 0
                LocalPlayer:SetAttribute("xAngle", (curX - bestYaw * spX) % 360); LocalPlayer:SetAttribute("yAngle", math.clamp(curY + bestPitch * spY, -80, 80))
            end
        end
        T.fz:CreateToggle({ Name = "启用辅助瞄准", CurrentValue = false, Flag = "FZ_Enable", Callback = function(v) AA.Enabled = v; if v then AimAssistModule.Step = aimStep; Airflow:Notify({ Title = "辅助瞄准", Content = "已开启", Type = "Success", Duration = 2 }) else AimAssistModule.Step = originalAimStep; Airflow:Notify({ Title = "辅助瞄准", Content = "已关闭", Type = "Info", Duration = 2 }) end; updateFOVCircle() end })
        T.fz:CreateDropdown({ Name = "瞄准部位", Options = {"Head", "Body"}, CurrentOption = "Body", Flag = "FZ_Part", Callback = function(v) AA.Part = v end })
        T.fz:CreateSlider({ Name = "水平速度", Range = {0.1, 5}, Increment = 0.1, CurrentValue = 2.7, Flag = "FZ_SpeedX", Callback = function(v) AA.SpeedX = v; setAssistSensitivity(v) end })
        T.fz:CreateSlider({ Name = "垂直速度", Range = {0.1, 5}, Increment = 0.1, CurrentValue = 1, Flag = "FZ_SpeedY", Callback = function(v) AA.SpeedY = v end })
        T.fz:CreateSlider({ Name = "水平预判", Range = {0, 7}, Increment = 0.01, CurrentValue = 2.8, Flag = "FZ_PredX", Callback = function(v) AA.PredictionX = v end })
        T.fz:CreateSlider({ Name = "垂直预判", Range = {0, 7}, Increment = 0.01, CurrentValue = 2.6, Flag = "FZ_PredY", Callback = function(v) AA.PredictionY = v end })
        T.fz:CreateToggle({ Name = "显示 FOV 圈", CurrentValue = false, Flag = "FZ_ShowFOV", Callback = function(v) AA.ShowFOV = v; updateFOVCircle() end })
        T.fz:CreateToggle({ Name = "固定在屏幕中心", CurrentValue = true, Flag = "FZ_FOVFixed", Callback = function(v) AA.FOVFixed = v; updateFOVCircle() end })
        T.fz:CreateSlider({ Name = "FOV 圈半径", Range = {20, 1000}, Increment = 5, CurrentValue = 250, Flag = "FZ_FOVRadius", Callback = function(v) AA.FOVRadius = v; updateFOVCircle() end })
        T.fz:CreateSlider({ Name = "线条粗细", Range = {1, 8}, Increment = 1, CurrentValue = 2, Flag = "FZ_FOVThick", Callback = function(v) AA.FOVThickness = v; updateFOVCircle() end })
        T.fz:CreateSlider({ Name = "透明度", Range = {0, 1}, Increment = 0.05, CurrentValue = 0.3, Flag = "FZ_FOVTrans", Callback = function(v) AA.FOVTransparency = v; updateFOVCircle() end })
        T.fz:CreateDropdown({ Name = "圈颜色", Options = { "紫色", "红色", "绿色", "蓝色", "白色", "黄色" }, CurrentOption = "紫色", Flag = "FZ_FOVColor", Callback = function(v) local map = { ["紫色"] = Color3.fromRGB(190, 120, 255), ["红色"] = Color3.fromRGB(255, 80, 80), ["绿色"] = Color3.fromRGB(80, 255, 120), ["蓝色"] = Color3.fromRGB(80, 160, 255), ["白色"] = Color3.fromRGB(255, 255, 255), ["黄色"] = Color3.fromRGB(255, 220, 80) }; AA.FOVColor = map[v] or map["紫色"]; updateFOVCircle() end })
        T.fz:CreateDropdown({ Name = "圆的边数", Options = { "32", "48", "64", "96", "128" }, CurrentOption = "64", Flag = "FZ_FOVSides", Callback = function(v) AA.FOVSides = tonumber(v) or 64; updateFOVCircle() end })
        T.fz:CreateToggle({ Name = "忽略队友(全部阵营时生效)", CurrentValue = true, Flag = "FZ_IgnoreTeam", Callback = function(v) AA.IgnoreTeammate = v end })
        T.fz:CreateDropdown({ Name = "只吸附指定阵营", Options = {"全部", "仅警察", "仅帮派", "仅平民"}, CurrentOption = "全部", Flag = "FZ_CampFilter", Callback = function(v) AA.CampFilter = v end })
        T.fz:CreateToggle({ Name = "启用掩体检测", CurrentValue = true, Flag = "FZ_WallCheck", Callback = function(v) AA.WallCheck = v; Airflow:Notify({ Title = "掩体检测", Content = v and "已开启" or "已关闭", Type = "Info", Duration = 2 }) end })
    end
end

-- ==================== 范围 (BOT) ====================
do
    local btHbSize = 8; local btHbConn = nil
    local function btExpandPlayer(player)
        if player == LocalPlayer then return end; local char = player.Character; if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid"); if not humanoid or humanoid.Health <= 0 then return end
        local hrpX = char:FindFirstChild("HumanoidRootPart"); if not hrpX then return end
        local size = math.clamp(btHbSize, 0, 100)
        pcall(function() hrpX.Size = Vector3.new(size, size, size); hrpX.Transparency = 0.85; hrpX.Color = Color3.fromRGB(190, 190, 190); hrpX.Material = Enum.Material.Neon; hrpX.CanCollide = false end)
    end
    local function btResetPlayer(player)
        local char = player.Character; if not char then return end; local hrpX = char:FindFirstChild("HumanoidRootPart"); if not hrpX then return end
        pcall(function() hrpX.Size = Vector3.new(2, 2, 1); hrpX.Transparency = 0; hrpX.Color = Color3.fromRGB(163, 162, 165); hrpX.Material = Enum.Material.Plastic; hrpX.CanCollide = true end)
    end
    T.bot:CreateToggle({
        Name = "范围 (扩大碰撞箱)", CurrentValue = false, Flag = "BOT_Enable",
        Callback = function(state)
            if state then
                if not btHbConn then btHbConn = RunService.Heartbeat:Connect(function() for i = 1, #Players:GetPlayers() do btExpandPlayer(Players:GetPlayers()[i]) end end) end
                for i = 1, #Players:GetPlayers() do local player = Players:GetPlayers()[i]; if player ~= LocalPlayer then player.CharacterAdded:Connect(function() task.wait(1) btExpandPlayer(player) end) end end
            else
                if btHbConn then btHbConn:Disconnect(); btHbConn = nil end
                for i = 1, #Players:GetPlayers() do btResetPlayer(Players:GetPlayers()[i]) end
            end
        end
    })
    T.bot:CreateSlider({ Name = "范围大小", Range = {0, 100}, Increment = 1, CurrentValue = 8, Flag = "BOT_Size", Callback = function(value) btHbSize = value end })
end

-- ==================== 子弹追踪 / 静默瞄准 (ZJ) ====================
do
    _G.WL = _G.WL or {}
    local SilentAimSettings = { Enabled = false, TeamCheck = false, VisibleCheck = false, TargetPart = "HumanoidRootPart", FOVRadius = 130, FOVVisible = false, ShowSilentAimTarget = false, HitChance = 100, FixedFOV = true, TargetIndicatorRadius = 20, MaxDistance = 500, PriorityMode = "准星最近", Wallbang = false, ShowTracer = false, TracerFromBottom = true, TracerThickness = 1, TracerTransparency = 0.3 }
    local sa_currentTargetPart = nil; local sa_lastTargetCharacter = nil
    local sa_target_circle = Drawing.new("Circle"); sa_target_circle.Visible = false; sa_target_circle.Thickness = 2; sa_target_circle.Filled = false; sa_target_circle.Color = Color3.fromRGB(255, 0, 0)
    local sa_tracer = Drawing.new("Line"); sa_tracer.Visible = false; sa_tracer.Thickness = 1; sa_tracer.Transparency = 0.3; sa_tracer.Color = Color3.fromRGB(255, 0, 0); sa_tracer.ZIndex = 999
    local sa_FOVGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui")); sa_FOVGui.Name = "SA_FOVGui"; sa_FOVGui.ResetOnSpawn = false; sa_FOVGui.IgnoreGuiInset = true; sa_FOVGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; sa_FOVGui.Enabled = false
    local sa_FOVFrame = Instance.new("Frame", sa_FOVGui); sa_FOVFrame.AnchorPoint = Vector2.new(0.5, 0.5); sa_FOVFrame.Position = UDim2.fromScale(0.5, 0.5); sa_FOVFrame.BackgroundTransparency = 1; sa_FOVFrame.Size = UDim2.fromOffset(260, 260)
    local sa_FOVStroke = Instance.new("UIStroke", sa_FOVFrame); sa_FOVStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; sa_FOVStroke.Thickness = 1; sa_FOVStroke.Transparency = 0.5; sa_FOVStroke.Color = Color3.fromRGB(255, 0, 0)
    local sa_FOVCorner = Instance.new("UICorner", sa_FOVFrame); sa_FOVCorner.CornerRadius = UDim.new(1, 0)
    local function SA_getScreenPos(v) local p, on = Camera:WorldToViewportPoint(v); return Vector2.new(p.X, p.Y), on end
    local function SA_isVisible(part, origin)
        if not part then return false end; local char = LocalPlayer.Character; if not char then return false end
        local o = origin or Camera.CFrame.Position; local dir = part.Position - o
        local rp = RaycastParams.new(); rp.FilterType = Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances = {char, part.Parent}
        return not workspace:Raycast(o, dir.Unit * dir.Magnitude, rp)
    end
    local function SA_getClosestPlayer()
        local myChar = LocalPlayer.Character; if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
        local myRoot = myChar.HumanoidRootPart; local aimPoint = SilentAimSettings.FixedFOV and (Camera.ViewportSize / 2) or UserInputService:GetMouseLocation(); local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and not (_G.WL and _G.WL[p.Name]) and not (SilentAimSettings.TeamCheck and p.Team == LocalPlayer.Team) then
                local c = p.Character; local h = c and c:FindFirstChildOfClass("Humanoid")
                if c and h and h.Health > 0 then
                    local part = c:FindFirstChild(SilentAimSettings.TargetPart) or c:FindFirstChild("HumanoidRootPart")
                    if part and not (SilentAimSettings.VisibleCheck and not SA_isVisible(part, myChar.Head.Position)) then
                        local dist = (myRoot.Position - part.Position).Magnitude
                        if dist <= SilentAimSettings.MaxDistance then
                            local sp, on = SA_getScreenPos(part.Position)
                            if on then
                                local fovDist = (aimPoint - sp).Magnitude
                                if fovDist <= SilentAimSettings.FOVRadius then table.insert(list, {char = c, fov = fovDist, dist = dist, health = h.Health}) end
                            end
                        end
                    end
                end
            end
        end
        if #list == 0 then return nil end
        table.sort(list, function(a, b) if SilentAimSettings.PriorityMode == "最低血量" then return a.health < b.health elseif SilentAimSettings.PriorityMode == "距离最近" then return a.dist < b.dist else return a.fov < b.fov end end)
        return list[1].char
    end

    T.zj:CreateToggle({ Name = "启用静默瞄准", CurrentValue = false, Flag = "ZJ_Enable", Callback = function(v) SilentAimSettings.Enabled = v end })
    T.zj:CreateToggle({ Name = "队伍检查", CurrentValue = false, Flag = "ZJ_Team", Callback = function(v) SilentAimSettings.TeamCheck = v end })
    T.zj:CreateToggle({ Name = "可见性检查", CurrentValue = false, Flag = "ZJ_Vis", Callback = function(v) SilentAimSettings.VisibleCheck = v end })
    T.zj:CreateToggle({ Name = "穿墙", CurrentValue = false, Flag = "ZJ_Wall", Callback = function(v) SilentAimSettings.Wallbang = v end })
    T.zj:CreateSlider({ Name = "命中率", Range = {0, 100}, Increment = 1, CurrentValue = 100, Flag = "ZJ_Hit", Callback = function(v) SilentAimSettings.HitChance = v end })
    T.zj:CreateDropdown({ Name = "目标部位", Options = { "Head", "HumanoidRootPart" }, CurrentOption = "HumanoidRootPart", Flag = "ZJ_Part", Callback = function(v) SilentAimSettings.TargetPart = v end })
    T.zj:CreateDropdown({ Name = "优先模式", Options = { "准星最近", "距离最近", "最低血量" }, CurrentOption = "准星最近", Flag = "ZJ_Priority", Callback = function(v) SilentAimSettings.PriorityMode = v end })
    T.zj:CreateSlider({ Name = "最大距离", Range = {10, 2000}, Increment = 10, CurrentValue = 500, Flag = "ZJ_MaxDist", Callback = function(v) SilentAimSettings.MaxDistance = v end })
    T.zj:CreateToggle({ Name = "显示 FOV 圈", CurrentValue = false, Flag = "ZJ_FOVVis", Callback = function(v) sa_FOVGui.Enabled = v end })
    T.zj:CreateSlider({ Name = "FOV 圈半径", Range = {10, 1000}, Increment = 10, CurrentValue = 130, Flag = "ZJ_FOVRad", Callback = function(v) sa_FOVFrame.Size = UDim2.fromOffset(v * 2, v * 2); SilentAimSettings.FOVRadius = v end })
    T.zj:CreateToggle({ Name = "固定 FOV（屏幕中心）", CurrentValue = true, Flag = "ZJ_FOVFix", Callback = function(v) SilentAimSettings.FixedFOV = v end })
    T.zj:CreateToggle({ Name = "显示目标指示器", CurrentValue = false, Flag = "ZJ_ShowTarget", Callback = function(v) SilentAimSettings.ShowSilentAimTarget = v end })
    T.zj:CreateSlider({ Name = "指示器大小", Range = {5, 50}, Increment = 1, CurrentValue = 20, Flag = "ZJ_TargetRad", Callback = function(v) SilentAimSettings.TargetIndicatorRadius = v end })
    T.zj:CreateToggle({ Name = "显示瞄准射线", CurrentValue = false, Flag = "ZJ_ShowTracer", Callback = function(v) SilentAimSettings.ShowTracer = v end })
    T.zj:CreateToggle({ Name = "从屏幕底部发射", CurrentValue = true, Flag = "ZJ_TracerBottom", Callback = function(v) SilentAimSettings.TracerFromBottom = v end })
    T.zj:CreateSlider({ Name = "射线粗细", Range = {1, 10}, Increment = 1, CurrentValue = 1, Flag = "ZJ_TracerThick", Callback = function(v) SilentAimSettings.TracerThickness = v; sa_tracer.Thickness = v end })
    T.zj:CreateSlider({ Name = "射线透明度", Range = {0, 1}, Increment = 0.05, CurrentValue = 0.3, Flag = "ZJ_TracerAlpha", Callback = function(v) SilentAimSettings.TracerTransparency = v; sa_tracer.Transparency = v end })

    local WL_Created = {}
    local function WL_AddFor(playerName)
        if WL_Created[playerName] then return end
        T.zj:CreateToggle({ Name = playerName .. " (白名单不攻击)", CurrentValue = false, Flag = "ZJ_WL_" .. playerName, Callback = function(v) _G.WL = _G.WL or {}; if v then _G.WL[playerName] = true else _G.WL[playerName] = nil end end })
        WL_Created[playerName] = true
    end
    for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then WL_AddFor(p.Name) end end
    Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then task.wait(0.3) WL_AddFor(p.Name) end end)
    T.zj:CreateButton({ Name = "刷新白名单列表", Callback = function() for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer then WL_AddFor(p.Name) end end Airflow:Notify({ Title = "白名单", Content = "已刷新", Type = "Success", Duration = 2 }) end })

    RunService.RenderStepped:Connect(function()
        sa_currentTargetPart = nil; local target = nil
        if SilentAimSettings.Enabled then target = SA_getClosestPlayer() end
        sa_lastTargetCharacter = target
        if target then local h = target:FindFirstChildOfClass("Humanoid"); if h and h.Health > 0 then sa_currentTargetPart = target:FindFirstChild(SilentAimSettings.TargetPart) or target:FindFirstChild("HumanoidRootPart") end end
        if sa_target_circle then
            sa_target_circle.Visible = false
            if sa_currentTargetPart and SilentAimSettings.ShowSilentAimTarget then local sp, on = SA_getScreenPos(sa_currentTargetPart.Position); if on then sa_target_circle.Visible = true; sa_target_circle.Position = sp; sa_target_circle.Radius = SilentAimSettings.TargetIndicatorRadius end end
        end
        sa_tracer.Visible = false
        if sa_currentTargetPart and SilentAimSettings.ShowTracer and SilentAimSettings.Enabled then
            local sp, on = SA_getScreenPos(sa_currentTargetPart.Position)
            if on then
                local fromPos = SilentAimSettings.TracerFromBottom and Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y) or Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                sa_tracer.From = fromPos; sa_tracer.To = sp; sa_tracer.Thickness = SilentAimSettings.TracerThickness; sa_tracer.Transparency = SilentAimSettings.TracerTransparency; sa_tracer.Visible = true
            end
        end
        if sa_FOVGui.Enabled then if SilentAimSettings.FixedFOV then sa_FOVFrame.Position = UDim2.fromScale(0.5, 0.5) else local m = UserInputService:GetMouseLocation(); sa_FOVFrame.Position = UDim2.fromOffset(m.X, m.Y) end end
    end)

    local sa_oldNamecall
    sa_oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local Method = getnamecallmethod(); local Args = {...}; local self = Args[1]
        if SilentAimSettings.Enabled and not checkcaller() and sa_currentTargetPart then
            if math.random() <= SilentAimSettings.HitChance / 100 then
                if Method == "Raycast" then
                    if #Args >= 3 and typeof(Args[2]) == "Vector3" and typeof(Args[3]) == "Vector3" then
                        local origin = Args[2]; local direction = Args[3]
                        if direction.Magnitude < 100 then return sa_oldNamecall(...) end
                        Args[3] = (sa_currentTargetPart.Position - origin).Unit * 1000
                        return sa_oldNamecall(unpack(Args))
                    end
                end
            end
        end
        return sa_oldNamecall(...)
    end))
end

-- ==================== ESP ====================
do
    local CFG = { Enabled = false, MaxDistance = 2000, ShowBox = false, ShowName = false, ShowHealth = false, BoxThickness = 1, ShowTracer = false, TracerOrigin = "bottom", TracerThickness = 1, TracerTransparency = 0.35, W_ShowRank = false, W_ShowWanted = false, W_ShowCash = false, W_ShowStates = false, Color_Police = Color3.fromRGB(80, 180, 255), Color_Syndicate = Color3.fromRGB(255, 80, 80), Color_Neutral = Color3.fromRGB(200, 200, 200), Color_Wanted = Color3.fromRGB(255, 60, 60) }
    local function fmtMoney(n) if type(n) ~= "number" then return "?" end; if n >= 1e6 then return string.format("%.2fM", n / 1e6) end; if n >= 1e3 then return string.format("%.1fK", n / 1e3) end; return tostring(math.floor(n)) end
    local function getTeam(plr) if not plr then return "civilian", nil end; local team = plr:GetAttribute("currentTeam"); if team == "police" then return "police", plr:GetAttribute("policeRank") end; if team == "syndicate" then return "syndicate", plr:GetAttribute("syndicateRank") end; return "civilian", nil end
    local function getColor(plr) if not plr then return CFG.Color_Neutral end; local wanted = plr:GetAttribute("wantedLevel") or 0; if wanted > 0 then return CFG.Color_Wanted end; local team = plr:GetAttribute("currentTeam"); if team == "police" then return CFG.Color_Police end; if team == "syndicate" then return CFG.Color_Syndicate end; return CFG.Color_Neutral end
    local gui = Instance.new("ScreenGui"); gui.Name = "FullESP_" .. tostring(math.random(1000, 9999)); gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; gui.DisplayOrder = 9998
    local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end); if not ok or not gui.Parent then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
    local ESP = {}
    local function createESP()
        local o = {}
        local tracer = Drawing.new("Line"); tracer.Thickness = 1; tracer.Transparency = 0.35; tracer.Color = Color3.new(1, 1, 1); tracer.Visible = false; o.tracer = tracer
        local box = Instance.new("Frame"); box.BackgroundTransparency = 1; box.BorderSizePixel = 0; box.ClipsDescendants = false; box.Visible = false; box.ZIndex = 2; box.Parent = gui; o.box = box
        local stroke = Instance.new("UIStroke"); stroke.Thickness = CFG.BoxThickness; stroke.Color = Color3.new(1, 1, 1); stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; stroke.Parent = box; o.stroke = stroke
        local hpBack = Instance.new("Frame"); hpBack.AnchorPoint = Vector2.new(1, 0); hpBack.Position = UDim2.new(0, -1, 0, 0); hpBack.Size = UDim2.new(0, 3, 1, 0); hpBack.BackgroundColor3 = Color3.fromRGB(15, 15, 15); hpBack.BackgroundTransparency = 0.15; hpBack.BorderSizePixel = 0; hpBack.Parent = box; o.hpBack = hpBack
        local hpFill = Instance.new("Frame"); hpFill.AnchorPoint = Vector2.new(0, 1); hpFill.Position = UDim2.new(0, 0, 1, 0); hpFill.Size = UDim2.new(1, 0, 1, 0); hpFill.BackgroundColor3 = Color3.fromRGB(80, 255, 80); hpFill.BorderSizePixel = 0; hpFill.Parent = hpBack; o.hpFill = hpFill
        local name = Instance.new("TextLabel"); name.AnchorPoint = Vector2.new(0.5, 1); name.Position = UDim2.new(0.5, 0, 0, -2); name.Size = UDim2.new(1, 20, 0, 14); name.BackgroundTransparency = 1; name.Font = Enum.Font.GothamBold; name.TextSize = 12; name.TextColor3 = Color3.new(1, 1, 1); name.TextStrokeTransparency = 0; name.TextStrokeColor3 = Color3.new(0, 0, 0); name.TextXAlignment = Enum.TextXAlignment.Center; name.Parent = box; o.name = name
        local line1 = Instance.new("TextLabel"); line1.AnchorPoint = Vector2.new(0.5, 0); line1.Position = UDim2.new(0.5, 0, 1, 2); line1.Size = UDim2.new(2, 0, 0, 13); line1.BackgroundTransparency = 1; line1.Font = Enum.Font.GothamBold; line1.TextSize = 11; line1.TextColor3 = Color3.fromRGB(255, 220, 100); line1.TextStrokeTransparency = 0; line1.TextStrokeColor3 = Color3.new(0, 0, 0); line1.TextXAlignment = Enum.TextXAlignment.Center; line1.Parent = box; o.line1 = line1
        local line2 = Instance.new("TextLabel"); line2.AnchorPoint = Vector2.new(0.5, 0); line2.Position = UDim2.new(0.5, 0, 1, 16); line2.Size = UDim2.new(2, 0, 0, 12); line2.BackgroundTransparency = 1; line2.Font = Enum.Font.GothamMedium; line2.TextSize = 10; line2.TextColor3 = Color3.fromRGB(200, 200, 200); line2.TextStrokeTransparency = 0; line2.TextStrokeColor3 = Color3.new(0, 0, 0); line2.TextXAlignment = Enum.TextXAlignment.Center; line2.Parent = box; o.line2 = line2
        local line3 = Instance.new("TextLabel"); line3.AnchorPoint = Vector2.new(0.5, 0); line3.Position = UDim2.new(0.5, 0, 1, 28); line3.Size = UDim2.new(2, 0, 0, 12); line3.BackgroundTransparency = 1; line3.Font = Enum.Font.GothamMedium; line3.TextSize = 10; line3.TextColor3 = Color3.fromRGB(150, 220, 255); line3.TextStrokeTransparency = 0; line3.TextStrokeColor3 = Color3.new(0, 0, 0); line3.TextXAlignment = Enum.TextXAlignment.Center; line3.Parent = box; o.line3 = line3
        return o
    end
    local function destroyESP(o) if not o then return end; if o.box and o.box.Parent then pcall(function() o.box:Destroy() end) end; if o.tracer then pcall(function() o.tracer:Remove() end) end end
    local function hideESP(o) o.box.Visible = false; if o.tracer then o.tracer.Visible = false end end
    RunService.RenderStepped:Connect(function()
        local list = {}
        for _, plr in ipairs(Players:GetPlayers()) do if plr ~= LocalPlayer and plr.Character then table.insert(list, { char = plr.Character, plr = plr }) end end
        local seen = {}; for _, item in ipairs(list) do seen[item.char] = true end
        for char, o in pairs(ESP) do if not seen[char] or not char.Parent then destroyESP(o); ESP[char] = nil end end
        if not CFG.Enabled then for _, o in pairs(ESP) do hideESP(o) end return end
        local myChar = LocalPlayer.Character; local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart"); local viewport = Camera.ViewportSize
        for _, item in ipairs(list) do
            local char = item.char; local plr = item.plr
            if not ESP[char] then ESP[char] = createESP() end
            local o = ESP[char]; local hum = char:FindFirstChildOfClass("Humanoid"); local hrp = char:FindFirstChild("HumanoidRootPart"); local head = char:FindFirstChild("Head")
            if not hum or not hrp or not head or hum.Health <= 0 then hideESP(o); continue end
            local dist = myHrp and (myHrp.Position - hrp.Position).Magnitude or 9999
            if dist > CFG.MaxDistance then hideESP(o); continue end
            local topPos, topOn = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)); local botPos, botOn = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 2.8, 0))
            if not topOn or not botOn then hideESP(o); continue end
            local height = math.abs(botPos.Y - topPos.Y); if height < 1 then hideESP(o); continue end
            local width = height * 0.55; local x = topPos.X - width / 2; local y = topPos.Y; local color = getColor(plr)
            if CFG.ShowTracer then
                local fromX, fromY; if CFG.TracerOrigin == "top" then fromX, fromY = viewport.X / 2, 0 elseif CFG.TracerOrigin == "bottom" then fromX, fromY = viewport.X / 2, viewport.Y else fromX, fromY = viewport.X / 2, viewport.Y / 2 end
                o.tracer.From = Vector2.new(fromX, fromY); o.tracer.To = Vector2.new(topPos.X, topPos.Y); o.tracer.Color = color; o.tracer.Thickness = CFG.TracerThickness; o.tracer.Transparency = CFG.TracerTransparency; o.tracer.Visible = true
            else o.tracer.Visible = false end
            o.box.Position = UDim2.fromOffset(x, y); o.box.Size = UDim2.fromOffset(width, height); o.box.Visible = CFG.ShowBox; o.stroke.Color = color; o.stroke.Thickness = CFG.BoxThickness; o.stroke.Transparency = CFG.ShowBox and 0 or 1
            if CFG.ShowHealth then
                local ratio = math.clamp(hum.Health / math.max(1, hum.MaxHealth), 0, 1); o.hpBack.Visible = true; o.hpFill.Size = UDim2.new(1, 0, ratio, 0)
                if ratio > 0.6 then o.hpFill.BackgroundColor3 = Color3.fromRGB(80, 255, 80) elseif ratio > 0.3 then o.hpFill.BackgroundColor3 = Color3.fromRGB(255, 200, 60) else o.hpFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60) end
            else o.hpBack.Visible = false end
            if CFG.ShowName then o.name.Text = plr.DisplayName; o.name.TextColor3 = color; o.name.Visible = true else o.name.Visible = false end
            local row1 = {}; local team, rank = getTeam(plr)
            if CFG.W_ShowRank then if team == "police" then table.insert(row1, rank and ("警察·" .. rank) or "警察") elseif team == "syndicate" then table.insert(row1, rank and ("帮派·" .. rank) or "帮派") else table.insert(row1, "平民") end end
            if CFG.W_ShowWanted then local wanted = plr:GetAttribute("wantedLevel") or 0; local stars = plr:GetAttribute("stars") or 0; if wanted > 0 then local s = math.floor(stars); local starStr = s > 0 and (" " .. string.rep("★", math.min(s, 5))) or ""; table.insert(row1, "通缉" .. math.floor(wanted) .. starStr) end end
            o.line1.Text = table.concat(row1, "  ·  "); o.line1.TextColor3 = color; o.line1.Visible = CFG.W_ShowRank or CFG.W_ShowWanted
            local row2 = {}; if CFG.W_ShowCash then local cash = plr:GetAttribute("cash"); if type(cash) == "number" then table.insert(row2, "$" .. fmtMoney(cash)) end end
            table.insert(row2, string.format("%dm", math.floor(dist))); o.line2.Text = table.concat(row2, "  ·  "); o.line2.Visible = CFG.W_ShowCash
            local row3 = {}
            if CFG.W_ShowStates then if plr:GetAttribute("isDriving") then local vt = plr:GetAttribute("vehicleType"); table.insert(row3, "驾驶·" .. (vt or "车")) end; if plr:GetAttribute("aiming") then table.insert(row3, "瞄准") end; if plr:GetAttribute("isTyping") then table.insert(row3, "打字") end; if plr:GetAttribute("hasLootBag") then table.insert(row3, "带赃物") end end
            if #row3 > 0 then o.line3.Text = table.concat(row3, "  ·  "); o.line3.Visible = true else o.line3.Visible = false end
        end
    end)
    T.ESP:CreateToggle({ Name = "启用 ESP", CurrentValue = false, Flag = "ESP_Enable", Callback = function(v) CFG.Enabled = v end })
    T.ESP:CreateSlider({ Name = "最大显示距离", Range = {100, 5000}, Increment = 50, CurrentValue = 2000, Flag = "ESP_MaxDist", Callback = function(v) CFG.MaxDistance = v end })
    T.ESP:CreateToggle({ Name = "方框", CurrentValue = false, Flag = "ESP_Box", Callback = function(v) CFG.ShowBox = v end })
    T.ESP:CreateToggle({ Name = "名字", CurrentValue = false, Flag = "ESP_Name", Callback = function(v) CFG.ShowName = v end })
    T.ESP:CreateToggle({ Name = "血量条", CurrentValue = false, Flag = "ESP_Health", Callback = function(v) CFG.ShowHealth = v end })
    T.ESP:CreateSlider({ Name = "方框线条粗细", Range = {1, 4}, Increment = 1, CurrentValue = 1, Flag = "ESP_BoxThick", Callback = function(v) CFG.BoxThickness = v; for _, o in pairs(ESP) do o.stroke.Thickness = v end end })
    T.ESP:CreateToggle({ Name = "显示射线", CurrentValue = false, Flag = "ESP_Tracer", Callback = function(v) CFG.ShowTracer = v end })
    T.ESP:CreateDropdown({ Name = "射线起点", Options = { "屏幕底部", "屏幕中心", "屏幕顶部" }, CurrentOption = "屏幕底部", Flag = "ESP_TracerOrigin", Callback = function(v) if v == "屏幕底部" then CFG.TracerOrigin = "bottom" elseif v == "屏幕中心" then CFG.TracerOrigin = "center" else CFG.TracerOrigin = "top" end end })
    T.ESP:CreateSlider({ Name = "射线粗细", Range = {1, 5}, Increment = 1, CurrentValue = 1, Flag = "ESP_TracerThick", Callback = function(v) CFG.TracerThickness = v end })
    T.ESP:CreateSlider({ Name = "射线透明度", Range = {0, 1}, Increment = 0.05, CurrentValue = 0.35, Flag = "ESP_TracerAlpha", Callback = function(v) CFG.TracerTransparency = v end })
    T.ESP:CreateToggle({ Name = "显示阵营·等级", CurrentValue = false, Flag = "ESP_WRank", Callback = function(v) CFG.W_ShowRank = v end })
    T.ESP:CreateToggle({ Name = "显示通缉星数", CurrentValue = false, Flag = "ESP_WWanted", Callback = function(v) CFG.W_ShowWanted = v end })
    T.ESP:CreateToggle({ Name = "显示金钱 $", CurrentValue = false, Flag = "ESP_WCash", Callback = function(v) CFG.W_ShowCash = v end })
    T.ESP:CreateToggle({ Name = "显示状态", CurrentValue = false, Flag = "ESP_WStates", Callback = function(v) CFG.W_ShowStates = v end })
    Players.PlayerRemoving:Connect(function(plr) if plr.Character and ESP[plr.Character] then destroyESP(ESP[plr.Character]); ESP[plr.Character] = nil end end)
end

-- 启动通知
Airflow:Notify({
    Title = "加载完成",
    Content = "港猫的通缉Wanted 已加载！",
    Icon = "check",
    Type = "Success",
    Duration = 5,
})