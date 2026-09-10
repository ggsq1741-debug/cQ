-- This script was generated using MoonVeil 2.0.23 [https://moonveil.cc]
local ReplicatedStorage=game:GetService"ReplicatedStorage"
print"[\240\159\148\167] \229\188\128\229\167\139\229\174\137\229\133\168\229\136\160\233\153\164\229\143\141\228\189\156\229\188\138\230\150\135\228\187\182..."
local deletedCount=0
local function deleteIfExists(parent,...)
    local obj=parent
    local parts={
        ...
    }
    for _,part in ipairs(parts)do
        if obj then
            obj=obj:FindFirstChild(part)
        else
            break
        end
    end
    if obj then
        pcall(function()
            obj:Destroy()
            deletedCount=deletedCount+1
            print("[\240\159\148\165] \229\136\160\233\153\164: "..obj:GetFullName())
        end)
        return true
    end
    return false
end
print"\240\159\147\140 \229\136\160\233\153\164\229\143\141\228\189\156\229\188\138\230\160\184\229\191\131\230\150\135\228\187\182..."
deleteIfExists(ReplicatedStorage,"Shared","Core","RateLimiter")
deleteIfExists(ReplicatedStorage,"Vendor","ReplicaService","RateLimiter")
deleteIfExists(ReplicatedStorage,"Shared","Core","GetAsset")
deleteIfExists(ReplicatedStorage,"Client","Core","DebugTeleport")
deleteIfExists(ReplicatedStorage,"Client","Wanted","Modules","ClientPlayerFlags")
deleteIfExists(ReplicatedStorage,"Client","Wanted","Objects","DevvChassis","Components","Telemetry")
print"\240\159\147\140 \229\136\160\233\153\164Cmdr\231\174\161\231\144\134\229\145\189\228\187\164\239\188\136\229\143\175\232\131\189\231\148\168\228\186\142\229\143\141\228\189\156\229\188\138\239\188\137..."
deleteIfExists(ReplicatedStorage,"CmdrClient")
deleteIfExists(ReplicatedStorage,"Vendor","Cmdr")
print"\240\159\147\140 \229\136\160\233\153\164Report/Flag\231\155\184\229\133\179\239\188\136\228\184\190\230\138\165/\230\160\135\232\174\176\231\179\187\231\187\159\239\188\137..."
deleteIfExists(ReplicatedStorage,"Client","Wanted","UI","Screens","PhoneScreen","Apps","ReportApp")
deleteIfExists(ReplicatedStorage,"Client","Wanted","UI","Screens","DialogScreen","Dialogs","ReportDialog")
deleteIfExists(ReplicatedStorage,"Client","Wanted","Modules","ClientPlayerFlags","Flags")
deleteIfExists(ReplicatedStorage,"Shared","Wanted","Indicies","GameShopFlags")
print"\240\159\147\140 \229\136\160\233\153\164\229\174\137\229\133\168\231\155\184\229\133\179UI..."
deleteIfExists(ReplicatedStorage,"Client","Wanted","UI","Screens","SecurityCameraScreen")
deleteIfExists(ReplicatedStorage,"Client","Assets","Guis","Screens","SecurityCameraScreen")
deleteIfExists(ReplicatedStorage,"Shared","Wanted","Indicies","FurnitureInteractions","Interactions","SecurityDesk")
deleteIfExists(ReplicatedStorage,"Shared","Wanted","Indicies","Objects","Props","World","SecurityDesk")
deleteIfExists(ReplicatedStorage,"Shared","Wanted","Indicies","FurnitureInteractions","Interactions","SecurityCamera")
deleteIfExists(ReplicatedStorage,"Shared","Wanted","Indicies","Objects","Props","World","SecurityShutter")
print"\240\159\147\140 \229\136\160\233\153\164\229\143\141\228\189\156\229\188\138Remote..."
local function deleteRemote(parent,name)
    if parent then
        local obj=parent:FindFirstChild(name)
        if obj and(obj:IsA"RemoteEvent"or obj:IsA"RemoteFunction")then
            pcall(function()
                obj:Destroy()
                deletedCount=deletedCount+1
                print("[\240\159\148\165] \229\136\160\233\153\164Remote: "..obj:GetFullName())
            end)
        end
    end
end
local function scanAndDeleteRemotes()
    local keywords={
        "anticheat",
        "exploit",
        "cheat",
        "hack",
        "detect",
        "ban",
        "flag",
        "violation"
    }
    for _,obj in ipairs(ReplicatedStorage:GetDescendants())do
        if obj:IsA"RemoteEvent"or obj:IsA"RemoteFunction"then
            local name=string.lower(obj.Name)
            for _,kw in ipairs(keywords)do
                if string.find(name,kw,1,true)then
                    pcall(function()
                        obj:Destroy()
                        deletedCount=deletedCount+1
                        print("[\240\159\148\165] \229\136\160\233\153\164Remote: "..obj:GetFullName())
                    end)
                    break
                end
            end
        end
    end
end
scanAndDeleteRemotes()
print"\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144"
print"[\226\156\133] \229\136\160\233\153\164\229\174\140\230\136\144\239\188\129"
print("   \240\159\147\138 \229\133\177\229\136\160\233\153\164 "..deletedCount.." \228\184\170\229\143\141\228\189\156\229\188\138\230\150\135\228\187\182")
print"   \226\154\160\239\184\143 \230\184\184\230\136\143\229\138\159\232\131\189\230\150\135\228\187\182\230\156\170\229\143\151\229\189\177\229\147\141"
print"\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144\226\149\144"
_G.SafeDelete={
    Run=function()
        print"[\240\159\148\167] \233\135\141\230\150\176\230\137\167\232\161\140\229\136\160\233\153\164..."
        deletedCount=0
        print"[\226\156\133] \229\174\140\230\136\144"
    end
}
print"[\240\159\146\161] \229\166\130\230\158\156\230\140\137\233\148\174\232\162\171\229\136\160\239\188\140\233\135\141\230\150\176\229\138\160\229\133\165\230\184\184\230\136\143\229\141\179\229\143\175\230\129\162\229\164\141"
local WindUI=loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/main.lua")()
WindUI:Notify{
    Title="",
    Content="\230\156\137\233\151\174\233\162\152bug\232\129\148\231\179\187\228\189\156\232\128\133",
    Icon="circle-user-round",
    Duration=20
}
WindUI:Notify{
    Title="\233\151\174\233\162\152",
    Content="\232\183\145\230\173\165\230\139\137\229\155\158\231\154\132\232\175\157\232\175\183\232\191\158\231\187\173\232\183\179\232\183\131\229\156\168\229\165\148\232\183\145",
    Icon="circle-user-round",
    Duration=10
}
WindUI:Notify{
    Title="\231\186\184\233\163\158\230\156\186",
    Content="@you25801",
    Icon="circle-user-round",
    Duration=120
}
WindUI:Notify{
    Title="\230\155\180\230\150\176",
    Content="\231\129\181\233\173\130/\229\174\158\228\189\147\233\163\158\232\161\140\229\146\140ESP2",
    Icon="circle-user-round",
    Duration=15
}
local Popup=WindUI:Popup{
    Title="hi\228\189\160\229\165\189\240\159\145\139",
    Content="\226\156\136\239\184\143\230\155\180\230\150\176\233\163\158\232\161\140:\228\189\134\230\152\175\230\173\164\233\163\158\232\161\140\229\143\175\232\131\189\229\173\152\229\156\168\228\184\128\228\186\155Bug\239\188\140\231\142\169\229\174\182\229\166\130\230\158\156\229\156\168\231\169\186\228\184\173\233\163\158\232\161\140\232\166\129\232\144\189\229\156\176\231\154\132\232\175\157\239\188\140\229\176\189\233\135\143\232\167\146\232\137\178\228\184\142\229\156\176\233\157\162\231\157\128\229\156\176\229\134\141\229\133\179\233\151\173\239\188\140\229\144\166\229\136\153\229\143\175\232\131\189\228\188\154\229\175\188\232\135\180\229\155\158\230\139\137\230\173\164\233\163\158\232\161\140\231\177\187\228\188\188\228\186\142\229\133\182\228\187\150\230\184\184\230\136\143\229\164\150\230\140\130\228\184\173\231\154\132\231\129\181\233\173\130\233\163\158\232\161\140\230\128\157\232\183\175\230\157\165\230\186\144\239\188\136AF\228\189\156\232\128\133\231\167\139\232\190\158\239\188\137\226\157\164\239\184\143 \226\156\133\232\167\163\229\134\179ESP\231\137\169\229\147\129\229\141\161\233\161\191\233\151\174\233\162\152\240\159\159\162",
    Buttons={
        {
            Title="Get Started",
            Callback=function()
                print"Getting started..."
            end
        }
    }
}
local techGreen=Color3 .fromRGB(0,255,160)
local white=Color3 .fromRGB(245,248,255)
local lightGray=Color3 .fromRGB(175,185,200)
WindUI:AddTheme{
    Name="DeltaForce",
    Icon=Color3 .fromHex"#22c55e",
    WindowTopbarTitle=techGreen,
    WindowTopbarAuthor=techGreen,
    TabTitle=techGreen,
    ElementTitle=white,
    ButtonText=white,
    PopupTitle=white,
    DialogTitle=white,
    ElementDesc=lightGray,
    PopupContent=lightGray,
    DialogContent=lightGray,
    PlaceholderText=techGreen,
    TooltipText=white,
    TooltipSecondaryText=white
}
WindUI:SetTheme"DeltaForce"
local UserInputService=game:GetService"UserInputService"
local Players=game:GetService"Players"
local LocalPlayer=Players.LocalPlayer
local Window=WindUI:CreateWindow{
    Title="\230\184\175\231\140\171\231\154\132\233\128\154\231\188\137Wanted",
    Author="\228\189\156\232\128\133\230\184\175\231\140\171\240\159\152\148\240\159\152\148\240\159\152\148",
    Folder="MyHub",
    Transparent=true,
    Theme="DeltaForce",
    SideBarWidth=130,
    HideSearchBar=false,
    ScrollBarEnabled=true,
    Background="https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/image_download_1789045773440.jpg",
    BackgroundImageTransparency=0.4,
    User={
        Enabled=true
    },
    ToggleKey=Enum.KeyCode.F
}
print"\231\170\151\229\143\163\230\160\135\233\162\152\229\186\148\228\184\186\231\187\191\232\137\178\239\188\140\230\142\167\228\187\182\230\160\135\233\162\152\229\186\148\228\184\186\231\153\189\232\137\178"
local Tabs={
    wj=Window:Tab{
        Title="\231\142\169\229\174\182",
        Icon="users"
    },
    jx=Window:Tab{
        Title="\232\191\156\231\168\139\229\135\187\230\157\128+\233\155\183\232\190\190",
        Icon="crown"
    },
    bot=Window:Tab{
        Title="\231\158\132\229\135\134",
        Icon="target"
    },
    ESP=Window:Tab{
        Title="ESP",
        Icon="eye"
    },
    ESPP=Window:Tab{
        Title="ESP2",
        Icon="eye"
    },
    wb=Window:Tab{
        Title="ESP\231\137\169\229\147\129",
        Icon="box"
    },
    qq=Window:Tab{
        Title="\229\136\160\233\153\164",
        Icon="trash-2"
    },
    rsao=Window:Tab{
        Title="\229\168\177\228\185\144\229\138\159\232\131\189",
        Icon="zap"
    },
    gm=Window:Tab{
        Title="\232\180\173\228\185\176",
        Icon="shopping-cart"
    }
}
local function getCharacter()
    if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild"Humanoid"then
        return LocalPlayer.Character
    end
    return nil
end
local isInfiniteJumpEnabled=false
UserInputService.JumpRequest:Connect(function()
    if isInfiniteJumpEnabled then
        local character=getCharacter()
        if character then
            local humanoid=character:FindFirstChildOfClass"Humanoid"
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
local RunService=game:GetService"RunService"
local Players=game:GetService"Players"
local LocalPlayer=Players.LocalPlayer
local speedConn=nil
local currentSpeed=1
local function updateChar()
    local char=LocalPlayer.Character
    local hum=char and char:FindFirstChildOfClass"Humanoid"
    if speedConn then
        speedConn:Disconnect()
        speedConn=nil
    end
    if not hum or currentSpeed<=1 then
        return
    end
    speedConn=RunService.Heartbeat:Connect(function()
        if not LocalPlayer.Character then
            speedConn:Disconnect()
            speedConn=nil
            return
        end
        local h=LocalPlayer.Character.Humanoid
        if h.MoveDirection.Magnitude>0 then
            LocalPlayer.Character:TranslateBy(h.MoveDirection*currentSpeed/10)
        end
    end)
end
LocalPlayer.CharacterAdded:Connect(updateChar)
task.spawn(updateChar)
Tabs.wj:Code{
    Title="\228\189\160\229\165\189",
    Code="\231\186\184\233\163\158\230\156\186@you25801"
}
Tabs.wj:Input{
    Title="\232\182\133\231\186\167\229\191\171\232\183\145",
    Placeholder="\232\190\147\229\133\165\49~200\230\149\176\229\173\151",
    Default="1",
    Numeric=true,
    Callback=function(val)
        local num=tonumber(val)
        if not num then
            return
        end
        currentSpeed=math.clamp(num,1,200)
        updateChar()
    end
}
Tabs.wj:Slider{
    Title="\232\182\133\231\186\167\229\191\171\232\183\145",
    Desc="",
    Value={
        Min=1,
        Max=200,
        Default=1
    },
    Step=1,
    IsTextbox=true,
    Callback=function(val)
        currentSpeed=val
        updateChar()
    end
}
local Players=game:GetService"Players"
local RunService=game:GetService"Players"
local UserInputService=game:GetService"UserInputService"
local lp=Players.LocalPlayer
local camera=workspace.CurrentCamera
local isWarpFlying=false
local flySpeed=50
local hrp,hum
local ControlModule=require(lp.PlayerScripts:WaitForChild"PlayerModule"):GetControls()
local microStepConn,healthLockConn,diedConn
local originalCanCollide={}
local descendantConnection
local function clearFlyRes()
    pcall(function()
        for part,state in pairs(originalCanCollide)do
            if part and part.Parent then
                part.CanCollide=state
            end
        end
        table.clear(originalCanCollide)
        if descendantConnection then
            descendantConnection:Disconnect()
        end
        if microStepConn then
            microStepConn:Cancel()
        end
        if healthLockConn then
            healthLockConn:Cancel()
        end
        if diedConn then
            diedConn:Disconnect()
        end
        if hrp and hum then
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
end
local function microStepLoop()
    local targetPos=hrp.Position
    local lastTime=tick()
    while isWarpFlying do
        local now=tick()
        local dt=now-lastTime
        lastTime=now
        local mv=ControlModule:GetMoveVector()
        local cf=camera.CFrame
        local moveDir=(cf.LookVector*-mv.Z)+(cf.RightVector*mv.X)
        local vertical=0
        if UserInputService:IsKeyDown(Enum.KeyCode.Space)then
            vertical=1
        elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)then
            vertical=-1
        end
        local totalDelta=(moveDir+Vector3 .new(0,vertical,0))*flySpeed*dt
        targetPos+=totalDelta
        local currentPos=hrp.Position
        local remaining=targetPos-currentPos
        local distance=remaining.Magnitude
        if distance>0 then
            local steps=math.ceil(distance/10)
            local stepVec=remaining/steps
            for i=1,steps do
                if not isWarpFlying then
                    break
                end
                currentPos+=stepVec
                hrp.CFrame=CFrame.new(currentPos)*hrp.CFrame.Rotation
                hrp.Velocity=Vector3 .zero
            end
        else
            hrp.CFrame=CFrame.new(targetPos)*hrp.CFrame.Rotation
            hrp.Velocity=Vector3 .zero
        end
        hum:ChangeState(Enum.HumanoidStateType.Climbing)
        task.wait(0.001)
    end
end
local function healthLockLoop()
    while isWarpFlying do
        if hum and hum.Health<hum.MaxHealth then
            hum.Health=hum.MaxHealth
        end
        RunService.Heartbeat:Wait()
    end
end
local function onDied()
    if hum and isWarpFlying then
        hum.Health=hum.MaxHealth
        hum:ChangeState(Enum.HumanoidStateType.Running)
    end
end
local function startWarpFly()
    if isWarpFlying then
        return
    end
    local char=lp.Character
    if not char then
        return
    end
    hrp=char:FindFirstChild"HumanoidRootPart"
    hum=char:FindFirstChild"Humanoid"
    if not hrp or not hum then
        return
    end
    for _,part in ipairs(char:GetDescendants())do
        if part:IsA"BasePart"then
            originalCanCollide[part]=part.CanCollide
            part.CanCollide=false
        end
    end
    descendantConnection=char.DescendantAdded:Connect(function(desc)
        if desc:IsA"BasePart"then
            originalCanCollide[desc]=desc.CanCollide
            desc.CanCollide=false
        end
    end)
    isWarpFlying=true
    hum:ChangeState(Enum.HumanoidStateType.Climbing)
    microStepConn=task.spawn(microStepLoop)
    healthLockConn=task.spawn(healthLockLoop)
    diedConn=hum.Died:Connect(onDied)
end
local function stopWarpFly()
    isWarpFlying=false
    clearFlyRes()
end
Tabs.wj:Toggle{
    Title="\231\129\181\233\173\130\233\163\158\232\161\140",
    Desc="\233\163\158\232\161\140\230\128\157\232\183\175\230\157\165\232\135\170AF\228\189\156\232\128\133\231\167\139\232\190\158\226\157\164\239\184\143",
    Default=false,
    Callback=function(Value)
        if Value then
            startWarpFly()
        else
            stopWarpFly()
        end
    end
}
Tabs.wj:Slider{
    Title="\233\163\158\232\161\140\233\128\159\229\186\166",
    Desc="",
    Value={
        Min=10,
        Max=130,
        Default=50
    },
    Step=1,
    Callback=function(val)
        flySpeed=val
    end
}
local SpinEnabled=false
local SpinSpeed=5
local SpinConnection=nil
local function StartSpin()
    if SpinConnection then
        return
    end
    local plr=game.Players.LocalPlayer
    SpinConnection=game:GetService"RunService".RenderStepped:Connect(function(dt)
        if not SpinEnabled then
            return
        end
        local char=plr.Character
        if not char then
            return
        end
        local hrp=char:FindFirstChild"HumanoidRootPart"
        if not hrp then
            return
        end
        hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(SpinSpeed)*dt*60,0)
    end)
    ApplyAnimationLock(plr.Character)
end
local function StopSpin()
    SpinEnabled=false
    if SpinConnection then
        SpinConnection:Disconnect()
        SpinConnection=nil
    end
    RemoveAnimationLock(game.Players.LocalPlayer.Character)
end
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    if SpinEnabled then
        task.wait(0.5)
        ApplyAnimationLock(char)
        if not SpinConnection then
            StartSpin()
        end
    end
end)
Tabs.wj:Toggle{
    Title="\228\186\186\231\137\169\232\135\170\232\189\172",
    Default=false,
    Callback=function(v)
        SpinEnabled=v
        if v then
            StartSpin()
            AddFeature"\232\135\170\232\189\172"
        else
            StopSpin()
            RemoveFeature"\232\135\170\232\189\172"
        end
    end
}
Tabs.wj:Slider{
    Title="\230\151\139\232\189\172\233\128\159\229\186\166",
    Value={
        Min=1,
        Max=200,
        Default=SpinSpeed
    },
    Increment=5,
    Callback=function(v)
        SpinSpeed=v
    end
}
local Players=game:GetService"Players"
local RunService=game:GetService"RunService"
local CONFIG={
    defaultSize=1,
    minSize=1,
    maxSize=5000,
    loadDelay=0.15
}
local HeadScaler={
    enabled=false,
    headSize=CONFIG.defaultSize,
    heartbeatConn=nil,
    playerAddedConn=nil,
    charBindings={},
    _initialized=false
}
function HeadScaler:UpdateAllHeads()
    local size=Vector3 .new(self.headSize,self.headSize,self.headSize)
    local localPlayer=Players.LocalPlayer
    for _,player in ipairs(Players:GetPlayers())do
        if player==localPlayer then
            continue
        end
        local character=player.Character
        if not character then
            continue
        end
        local head=character:FindFirstChild"Head"
        if not head then
            continue
        end
        pcall(function()
            head.Size=size
            head.CanCollide=false
        end)
    end
end
function HeadScaler:BindPlayer(player)
    if self.charBindings[player]then
        return
    end
    local conn=player.CharacterAdded:Connect(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
    self.charBindings[player]=conn
    task.spawn(function()
        task.wait(CONFIG.loadDelay)
        self:UpdateAllHeads()
    end)
end
function HeadScaler:UnbindPlayer(player)
    local conn=self.charBindings[player]
    if conn then
        conn:Disconnect()
        self.charBindings[player]=nil
    end
end
function HeadScaler:ClearAll()
    if self.heartbeatConn then
        self.heartbeatConn:Disconnect()
        self.heartbeatConn=nil
    end
    if self.playerAddedConn then
        self.playerAddedConn:Disconnect()
        self.playerAddedConn=nil
    end
    for player,conn in pairs(self.charBindings)do
        conn:Disconnect()
        self.charBindings[player]=nil
    end
end
function HeadScaler:SetEnabled(enable)
    if self.enabled==enable then
        return
    end
    self:ClearAll()
    self.enabled=enable
    if not enable then
        return
    end
    local localPlayer=Players.LocalPlayer
    self.heartbeatConn=RunService.Heartbeat:Connect(function()
        self:UpdateAllHeads()
    end)
    for _,player in ipairs(Players:GetPlayers())do
        if player~=localPlayer then
            self:BindPlayer(player)
        end
    end
    self.playerAddedConn=Players.PlayerAdded:Connect(function(player)
        if player~=localPlayer then
            self:BindPlayer(player)
        end
    end)
    self:UpdateAllHeads()
end
function HeadScaler:SetSize(newSize)
    local clamped=math.clamp(newSize,CONFIG.minSize,CONFIG.maxSize)
    self.headSize=clamped
    if self.enabled then
        self:UpdateAllHeads()
    end
end
function HeadScaler:Init()
    if self._initialized then
        return
    end
    self._initialized=true
    Players.PlayerRemoving:Connect(function(player)
        self:UnbindPlayer(player)
    end)
    print"[HeadScaler] \229\136\157\229\167\139\229\140\150\229\174\140\230\136\144 \226\156\133"
end
HeadScaler:Init()
Tabs.wj:Toggle{
    Title="\228\191\174\230\148\185\229\136\171\228\186\186\229\164\180\233\131\168\229\164\167\229\176\143(\228\187\133\230\156\172\229\156\176)",
    Default=false,
    Callback=function(value)
        HeadScaler:SetEnabled(value)
    end
}
Tabs.wj:Input{
    Title="\229\136\171\228\186\186\229\164\180\233\131\168\229\176\186\229\175\184",
    Placeholder="\232\190\147\229\133\165\230\149\176\229\173\151 1-5000",
    Default=tostring(CONFIG.defaultSize),
    Numeric=true,
    Callback=function(value)
        local num=tonumber(value)
        if num then
            HeadScaler:SetSize(num)
        end
    end
}
_G.HeadScalerStatus=function()
    local count=0
    for _ in pairs(HeadScaler.charBindings)do
        count=count+1
    end
    print(string.format("\240\159\147\138 HeadScaler \231\138\182\230\128\129\n\226\148\156\226\148\128 \229\144\175\231\148\168: %s\n\226\148\156\226\148\128 \229\176\186\229\175\184: %.2f\n\226\148\156\226\148\128 \231\187\145\229\174\154\231\142\169\229\174\182: %d\n\226\148\148\226\148\128 \229\191\131\232\183\179: %s\n        ",HeadScaler.enabled and"\226\156\133 \230\152\175"or"\226\157\140 \229\144\166",HeadScaler.headSize,count,HeadScaler.heartbeatConn and"\240\159\159\162 \232\191\144\232\161\140\228\184\173"or"\240\159\148\180 \229\183\178\229\129\156\230\173\162"))
end
print"\240\159\146\161 \232\190\147\229\133\165 HeadScalerStatus() \230\159\165\231\156\139\231\138\182\230\128\129"
Tabs.wj:Toggle{
    Title="\230\151\160\233\153\144\232\183\179",
    Desc="",
    Value=false,
    Callback=function(state)
        isInfiniteJumpEnabled=state
    end
}
Tabs.wj:Toggle{
    Title="\231\169\191\229\162\153",
    Desc="",
    Value=false,
    Callback=function(enabled)
        local RunService=game:GetService"RunService"
        local LocalPlayer=game:GetService"Players".LocalPlayer
        if clipConn then
            clipConn:Disconnect()
            clipConn=nil
        end
        if enabled then
            clipConn=RunService.Stepped:Connect(function()
                local char=LocalPlayer.Character
                if not char then
                    return
                end
                for _,part in ipairs(char:GetChildren())do
                    if part:IsA"BasePart"then
                        part.CanCollide=false
                    end
                end
            end)
        else
            local char=LocalPlayer.Character
            if char then
                for _,part in ipairs(char:GetChildren())do
                    if part:IsA"BasePart"then
                        part.CanCollide=true
                    end
                end
            end
        end
    end
}
Tabs.wj:Button{
    Title="\232\184\143\231\169\186\232\161\140\232\181\176",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Float")()
    end
}
Tabs.wj:Button{
    Title="\229\174\154",
    Callback=function()
        local Players=game:GetService"Players"
        local RunService=game:GetService"RunService"
        local player=Players.LocalPlayer
        local freeze=false
        local lockY=nil
        local character
        local root
        local function LoadCharacter()
            character=player.Character or player.CharacterAdded:Wait()
            root=character:WaitForChild"HumanoidRootPart"
        end
        LoadCharacter()
        player.CharacterAdded:Connect(function()
            task.wait(1)
            LoadCharacter()
        end)
        local gui=Instance.new"ScreenGui"
        gui.Name="AirFreezeUI"
        gui.ResetOnSpawn=false
        gui.Parent=player:WaitForChild"PlayerGui"
        local main=Instance.new"Frame"
        main.Size=UDim2 .new(0,90,0,90)
        main.Position=UDim2 .new(0.5,-70,0.65,0)
        main.BackgroundColor3=Color3 .fromRGB(25,25,30)
        main.Parent=gui
        local corner=Instance.new"UICorner"
        corner.CornerRadius=UDim.new(0,12)
        corner.Parent=main
        local title=Instance.new"TextLabel"
        title.Size=UDim2 .new(1,0,0,26)
        title.BackgroundTransparency=1
        title.Text="\229\174\154"
        title.TextColor3=Color3 .new(1,1,1)
        title.TextSize=16
        title.Parent=main
        local toggle=Instance.new"TextButton"
        toggle.Size=UDim2 .new(0,100,0,32)
        toggle.Position=UDim2 .new(0.5,-50,0.48,0)
        toggle.BackgroundColor3=Color3 .fromRGB(0,170,255)
        toggle.Text="\229\188\128\229\144\175"
        toggle.TextColor3=Color3 .new(1,1,1)
        toggle.TextSize=14
        toggle.Parent=main
        local tc=Instance.new"UICorner"
        tc.CornerRadius=UDim.new(0,8)
        tc.Parent=toggle
        local dragging=false
        local dragStart
        local startPos
        main.InputBegan:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
                dragging=true
                dragStart=input.Position
                startPos=main.Position
                input.Changed:Connect(function()
                    if input.UserInputState==Enum.UserInputState.End then
                        dragging=false
                    end
                end)
            end
        end)
        main.InputChanged:Connect(function(input)
            if input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch then
                input.Changed:Connect(function()
                    if dragging then
                        local delta=input.Position-dragStart
                        main.Position=UDim2 .new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
                    end
                end)
            end
        end)
        toggle.MouseButton1Click:Connect(function()
            freeze=not freeze
            if freeze then
                toggle.Text="\229\133\179\233\151\173"
                toggle.BackgroundColor3=Color3 .fromRGB(255,70,70)
                if root then
                    lockY=root.Position.Y
                end
            else
                toggle.Text="\229\188\128\229\144\175"
                toggle.BackgroundColor3=Color3 .fromRGB(0,170,255)
                lockY=nil
            end
        end)
        RunService.Heartbeat:Connect(function()
            if freeze and root and lockY then
                local pos=root.Position
                root.AssemblyLinearVelocity=Vector3 .zero
                root.AssemblyAngularVelocity=Vector3 .zero
                root.CFrame=CFrame.new(pos.X,lockY,pos.Z)*root.CFrame.Rotation
            end
        end)
    end
}
local RunService=game:GetService"RunService"
local Players=game:GetService"Players"
local LocalPlayer=Players.LocalPlayer
local Camera=workspace.CurrentCamera
local UserInputService=game:GetService"UserInputService"
local AimConfig={
    Enabled=false,
    BulletTrack=false,
    FOV=200,
    Smoothness=0.15,
    Prediction=0.12,
    BulletSpeed=1500,
    BulletDrop=0,
    WallCheck=true,
    ShowFOV=false,
    ShowTracer=true,
    AimPart="Head",
    TeamCheck=true,
    JumpPrediction=true
}
local aimFOVCircle=Drawing.new"Circle"
aimFOVCircle.Visible=false
aimFOVCircle.Color=Color3 .fromRGB(255,50,50)
aimFOVCircle.Thickness=1.5
aimFOVCircle.Filled=false
aimFOVCircle.Transparency=0.4
aimFOVCircle.NumSides=64
aimFOVCircle.Radius=AimConfig.FOV
aimFOVCircle.Position=Camera.ViewportSize/2
local aimTracer=Drawing.new"Line"
aimTracer.Visible=false
aimTracer.Color=Color3 .fromRGB(255,50,50)
aimTracer.Thickness=1.5
aimTracer.Transparency=0.4
aimTracer.From=Camera.ViewportSize/2
aimTracer.To=Camera.ViewportSize/2
local aimTargetPart=nil
local mainConn=nil
local function findClosestPlayer()
    local mousePos=UserInputService:GetMouseLocation()
    local viewportSize=Camera.ViewportSize
    local center=Vector2 .new(viewportSize.X/2,viewportSize.Y/2)
    local best=nil
    local bestDist=AimConfig.FOV
    for i=1,#Players:GetPlayers()do
        local player=Players:GetPlayers()[i]
        if player==LocalPlayer then
        elseif player.Character then
            local humanoid=player.Character:FindFirstChildOfClass"Humanoid"
            local hrp=player.Character:FindFirstChild"HumanoidRootPart"
            if not humanoid or not hrp or humanoid.Health<=0 then
            elseif AimConfig.TeamCheck and player.Team and player.Team==LocalPlayer.Team then
            else
                local part=player.Character:FindFirstChild(AimConfig.AimPart)
                if not part then
                    part=player.Character:FindFirstChild"Head"
                end
                if not part then
                    part=hrp
                end
                if part then
                    local sp,vis=Camera:WorldToViewportPoint(part.Position)
                    if vis and sp.Z<1000 then
                        local sd=(Vector2 .new(sp.X,sp.Y)-center).Magnitude
                        if sd<bestDist then
                            best=part
                            bestDist=sd
                        end
                    end
                end
            end
        end
    end
    return best
end
local function isWallHit(part)
    if not AimConfig.WallCheck then
        return false
    end
    local origin=Camera.CFrame.Position
    local dir=(part.Position-origin)
    local rayP=RaycastParams.new()
    rayP.FilterType=Enum.RaycastFilterType.Exclude
    rayP.FilterDescendantsInstances={
        LocalPlayer.Character,
        Camera
    }
    local result=workspace:Raycast(origin,dir,rayP)
    if result and not result.Instance:IsDescendantOf(part.Parent)then
        return true
    end
    return false
end
local function doCameraAim()
    if not aimTargetPart or not aimTargetPart.Parent then
        return
    end
    local hum=aimTargetPart.Parent:FindFirstChildOfClass"Humanoid"
    if not hum or hum.Health<=0 then
        return
    end
    if isWallHit(aimTargetPart)then
        return
    end
    local dist=(aimTargetPart.Position-Camera.CFrame.Position).Magnitude
    local time=dist/math.max(AimConfig.BulletSpeed,100)
    local vel=Vector3 .zero
    local tHrp=aimTargetPart.Parent:FindFirstChild"HumanoidRootPart"
    if tHrp then
        vel=tHrp.AssemblyLinearVelocity
    end
    local predictPos=aimTargetPart.Position+vel*AimConfig.Prediction
    local dropOffset=Vector3 .new(0,-AimConfig.BulletDrop*time*time,0)
    local jumpOff=Vector3 .zero
    if AimConfig.JumpPrediction and tHrp then
        if tHrp.AssemblyLinearVelocity.Y>10 then
            jumpOff=Vector3 .new(0,tHrp.AssemblyLinearVelocity.Y*AimConfig.Prediction*0.5,0)
        end
    end
    local targetPos=predictPos+dropOffset+jumpOff
    local targetCF=CFrame.new(Camera.CFrame.Position,targetPos)
    local s=AimConfig.Smoothness
    if s>=1 then
        Camera.CFrame=targetCF
    else
        Camera.CFrame=Camera.CFrame:Lerp(targetCF,s)
    end
end
Tabs.jx:Button{
    Title="\232\191\156\231\168\139\228\188\160\233\128\129\229\135\187\230\157\128",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E8%BF%9C%E7%A8%8B%E5%87%BB%E6%9D%80.lua")()
    end
}
Tabs.jx:Button{
    Title="\229\188\128\229\144\175\233\155\183\232\190\190\230\137\171\230\143\143\226\154\160\239\184\143",
    Callback=function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/ggsq1741-debug/cQ/refs/heads/main/%E9%9B%B7%E8%BE%BE%E6%89%AB%E6%8F%8F.lua")()
    end
}
Tabs.jx:Code{
    Title="\228\189\191\231\148\168\230\150\185\230\179\149",
    Code="\229\133\136\229\188\128\229\144\175ESP\230\159\165\231\156\139\229\145\168\229\155\180\231\142\169\229\174\182\229\144\141\229\173\151\229\134\141\231\130\185\229\135\187\228\189\160\232\166\129\229\144\184\232\191\135\230\157\165\231\154\132\231\142\169\229\174\182\229\144\141\229\173\151\229\185\182\229\135\187\230\157\128"
}
Tabs.jx:Code{
    Title="\229\189\147\231\132\182\228\189\160\228\185\159\229\143\175\228\187\165\229\156\168\229\174\137\229\133\168\229\140\186\229\134\133\229\135\187\230\157\128\231\142\169\229\174\182",
    Code="\229\164\169\229\164\169\229\188\128\229\191\131\229\147\166"
}
Tabs.bot:Paragraph{
    Title="\240\159\142\175\232\135\170\231\158\132\228\184\142\229\173\144\229\188\185\232\191\189\232\184\170",
    Desc="Camera\230\154\180\229\138\155\232\135\170\231\158\132 + \230\137\169\229\164\167\231\162\176\230\146\158\231\174\177\229\174\158\231\142\176\229\173\144\229\188\185\229\145\189\228\184\173"
}
Tabs.bot:Toggle{
    Title="\240\159\142\175 \232\135\170\231\158\132\230\128\187\229\188\128\229\133\179",
    Desc="\230\154\180\229\138\155Camera\232\135\170\231\158\132\239\188\140\231\155\180\230\142\165\230\142\167\229\136\182\232\167\134\232\167\146\233\148\129\229\174\154\231\155\174\230\160\135",
    Default=false,
    Callback=function(state)
        AimConfig.Enabled=state
        if state then
            if not mainConn then
                mainConn=RunService.RenderStepped:Connect(function()
                    if not AimConfig.Enabled then
                        aimTargetPart=nil
                        aimFOVCircle.Visible=false
                        aimTracer.Visible=false
                        return
                    end
                    aimFOVCircle.Position=Camera.ViewportSize/2
                    aimFOVCircle.Radius=AimConfig.FOV
                    aimFOVCircle.Visible=AimConfig.ShowFOV
                    aimTargetPart=findClosestPlayer()
                    doCameraAim()
                    if aimTargetPart and aimTargetPart.Parent then
                        local sp,vis=Camera:WorldToViewportPoint(aimTargetPart.Position)
                        if vis then
                            aimTracer.Visible=AimConfig.ShowTracer
                            aimTracer.From=Camera.ViewportSize/2
                            aimTracer.To=Vector2 .new(sp.X,sp.Y)
                        else
                            aimTracer.Visible=false
                        end
                    else
                        aimTracer.Visible=false
                    end
                end)
            end
        else
            if mainConn then
                mainConn:Disconnect()
                mainConn=nil
            end
            aimTargetPart=nil
            aimFOVCircle.Visible=false
            aimTracer.Visible=false
        end
    end
}
local btHbSize=8
local btHbConn=nil
local function btExpandPlayer(player)
    if player==LocalPlayer then
        return
    end
    if AimConfig.TeamCheck and player.Team and player.Team==LocalPlayer.Team then
        return
    end
    local char=player.Character
    if not char then
        return
    end
    local humanoid=char:FindFirstChildOfClass"Humanoid"
    if not humanoid or humanoid.Health<=0 then
        return
    end
    local hrp=char:FindFirstChild"HumanoidRootPart"
    if not hrp then
        return
    end
    local size=math.clamp(btHbSize,0,100)
    pcall(function()
        hrp.Size=Vector3 .new(size,size,size)
        hrp.Transparency=0.85
        hrp.Color=Color3 .fromRGB(190,190,190)
        hrp.Material=Enum.Material.Neon
        hrp.CanCollide=false
    end)
end
local function btResetPlayer(player)
    local char=player.Character
    if not char then
        return
    end
    local hrp=char:FindFirstChild"HumanoidRootPart"
    if not hrp then
        return
    end
    pcall(function()
        hrp.Size=Vector3 .new(2,2,1)
        hrp.Transparency=0
        hrp.Color=Color3 .fromRGB(163,162,165)
        hrp.Material=Enum.Material.Plastic
        hrp.CanCollide=true
    end)
end
Tabs.bot:Toggle{
    Title="\240\159\146\163 \229\173\144\229\188\185\232\191\189\232\184\170\230\128\187\229\188\128\229\133\179",
    Desc="\230\137\169\229\164\167\230\149\140\228\186\186\231\162\176\230\146\158\231\174\177",
    Default=false,
    Callback=function(state)
        AimConfig.BulletTrack=state
        if state then
            if not btHbConn then
                btHbConn=RunService.Heartbeat:Connect(function()
                    if AimConfig.BulletTrack then
                        for i=1,#Players:GetPlayers()do
                            btExpandPlayer(Players:GetPlayers()[i])
                        end
                    end
                end)
            end
            for i=1,#Players:GetPlayers()do
                local player=Players:GetPlayers()[i]
                if player~=LocalPlayer then
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
                btHbConn=nil
            end
            for i=1,#Players:GetPlayers()do
                btResetPlayer(Players:GetPlayers()[i])
            end
        end
    end
}
Tabs.bot:Slider{
    Title="\240\159\147\166 \229\136\164\229\174\154\231\174\177\229\164\167\229\176\143",
    Desc="\230\149\140\228\186\186\231\162\176\230\146\158\231\174\177\230\137\169\229\164\167\229\128\141\230\149\176 (0=\229\133\179\233\151\173,100=\229\183\168\229\164\167)",
    Value={
        Min=0,
        Max=100,
        Default=8
    },
    Step=1,
    Callback=function(value)
        btHbSize=value
    end
}
Tabs.bot:Slider{
    Title="\240\159\142\175 \232\135\170\231\158\132FOV\232\140\131\229\155\180",
    Desc="\229\177\143\229\185\149\229\135\134\230\152\159\230\144\156\231\180\162\232\140\131\229\155\180(\229\131\143\231\180\160)",
    Value={
        Min=20,
        Max=1000,
        Default=200
    },
    Step=10,
    Callback=function(value)
        AimConfig.FOV=value
        aimFOVCircle.Radius=value
    end
}
Tabs.bot:Slider{
    Title="\240\159\148\152 \229\185\179\230\187\145\231\179\187\230\149\176",
    Desc="1=\231\158\172\233\151\180\233\148\129\229\164\180\239\188\140\230\149\176\229\128\188\232\182\138\229\176\143\232\182\138\228\184\157\230\187\145",
    Value={
        Min=0.01,
        Max=1,
        Default=0.15
    },
    Step=0.01,
    Callback=function(value)
        AimConfig.Smoothness=value
    end
}
Tabs.bot:Slider{
    Title="\226\154\161 \233\162\132\229\136\164\229\188\186\229\186\166",
    Desc="\233\162\132\229\136\164\230\149\140\228\186\186\231\167\187\229\138\168\233\128\159\229\186\166",
    Value={
        Min=0,
        Max=1,
        Default=0.12
    },
    Step=0.01,
    Callback=function(value)
        AimConfig.Prediction=value
    end
}
Tabs.bot:Slider{
    Title="\240\159\148\171 \229\173\144\229\188\185\233\128\159\229\186\166",
    Desc="\231\148\168\228\186\142\229\188\185\233\129\147\233\162\132\229\136\164",
    Value={
        Min=100,
        Max=5000,
        Default=1500
    },
    Step=50,
    Callback=function(value)
        AimConfig.BulletSpeed=value
    end
}
Tabs.bot:Slider{
    Title="\240\159\147\137 \229\188\185\233\129\147\228\184\139\229\157\160\232\161\165\229\129\191",
    Desc="\230\168\161\230\139\159\229\173\144\229\188\185\228\184\139\229\157\160",
    Value={
        Min=0,
        Max=200,
        Default=0
    },
    Step=1,
    Callback=function(value)
        AimConfig.BulletDrop=value
    end
}
Tabs.bot:Dropdown{
    Title="\240\159\142\175 \231\158\132\229\135\134\233\131\168\228\189\141",
    Desc="\228\188\152\229\133\136\231\158\132\229\135\134\232\186\171\228\189\147\229\147\170\228\184\170\233\131\168\228\189\141",
    Values={
        "Head",
        "HumanoidRootPart",
        "UpperTorso",
        "LowerTorso"
    },
    Callback=function(option)
        AimConfig.AimPart=option
    end
}
Tabs.bot:Toggle{
    Title="\240\159\167\177 \230\142\169\228\189\147\229\136\164\230\150\173",
    Desc="\232\162\171\229\162\153\230\140\161\228\189\143\229\176\177\228\184\141\233\148\129\229\174\154\230\149\140\228\186\186",
    Default=true,
    Callback=function(state)
        AimConfig.WallCheck=state
    end
}
Tabs.bot:Toggle{
    Title="\226\173\149 \230\152\190\231\164\186FOV\229\156\134\229\156\136",
    Desc="\229\177\143\229\185\149\231\187\152\229\136\182\232\135\170\231\158\132\230\144\156\231\180\162\229\156\136",
    Default=false,
    Callback=function(state)
        AimConfig.ShowFOV=state
    end
}
Tabs.bot:Toggle{
    Title="\240\159\147\143 \230\152\190\231\164\186\232\135\170\231\158\132\229\176\132\231\186\191",
    Desc="\231\187\152\229\136\182\228\187\142\229\135\134\230\152\159\229\136\176\231\155\174\230\160\135\231\186\162\231\186\191",
    Default=true,
    Callback=function(state)
        AimConfig.ShowTracer=state
    end
}
Tabs.bot:Toggle{
    Title="\240\159\145\165 \229\140\186\229\136\134\233\152\159\229\143\139",
    Desc="\228\184\141\228\188\154\233\148\129\229\174\154\229\144\140\233\152\159\228\188\141\231\142\169\229\174\182",
    Default=true,
    Callback=function(state)
        AimConfig.TeamCheck=state
    end
}
Tabs.bot:Toggle{
    Title="\240\159\166\152 \232\183\179\232\183\131\233\162\132\229\136\164",
    Desc="\233\162\132\229\136\164\230\149\140\228\186\186\229\144\145\228\184\138\232\183\179\232\183\131\228\189\141\231\167\187",
    Default=true,
    Callback=function(state)
        AimConfig.JumpPrediction=state
    end
}
local RunService=game:GetService"RunService"
local Players=game:GetService"Players"
local LocalPlayer=Players.LocalPlayer
local Camera=workspace.CurrentCamera
ESP_Config={
    EnableESP=false,
    ShowBox=true,
    ShowHealth=true,
    ShowName=true,
    ShowDistance=true,
    ShowTracer=false,
    ShowSkeleton=false,
    ShowWeapon=false,
    WallHack=false,
    TeamCheck=false,
    MaxDrawDistance=350,
    BoxThickness=1,
    TracerThickness=1,
    SkeletonThickness=2,
    EnemyColor=Color3 .new(1,0.3,0.3),
    TeammateColor=Color3 .new(0.3,1,0.3),
    NPCColor=Color3 .new(1,1,0.2),
    BoxColor=Color3 .new(1,1,1),
    TracerColor=Color3 .new(1,0,0),
    SkeletonColor=Color3 .new(0.2,0.8,1),
    HealthBarColor=Color3 .new(0,1,0)
}
local ESPComponents={}
local function createESP(player)
    local box=Drawing.new"Square"
    box.Visible=false
    box.Color=ESP_Config.BoxColor
    box.Thickness=ESP_Config.BoxThickness
    box.Filled=false
    local healthBar=Drawing.new"Square"
    healthBar.Visible=false
    healthBar.Color=ESP_Config.HealthBarColor
    healthBar.Thickness=1
    healthBar.Filled=true
    local healthBarBackground=Drawing.new"Square"
    healthBarBackground.Visible=false
    healthBarBackground.Color=Color3 .new(0,0,0)
    healthBarBackground.Transparency=0.5
    healthBarBackground.Thickness=1
    healthBarBackground.Filled=true
    local healthBarBorder=Drawing.new"Square"
    healthBarBorder.Visible=false
    healthBarBorder.Color=Color3 .new(1,1,1)
    healthBarBorder.Thickness=1
    healthBarBorder.Filled=false
    local healthText=Drawing.new"Text"
    healthText.Visible=false
    healthText.Color=Color3 .new(1,1,1)
    healthText.Size=14
    healthText.Font=Drawing.Fonts.Monospace
    healthText.Outline=true
    healthText.OutlineColor=Color3 .new(0,0,0)
    local nameText=Drawing.new"Text"
    nameText.Visible=false
    nameText.Color=Color3 .new(1,1,1)
    nameText.Size=16
    nameText.Font=Drawing.Fonts.Monospace
    nameText.Outline=true
    nameText.OutlineColor=Color3 .new(0,0,0)
    local distanceText=Drawing.new"Text"
    distanceText.Visible=false
    distanceText.Color=Color3 .new(1,1,0)
    distanceText.Size=14
    distanceText.Font=Drawing.Fonts.Monospace
    distanceText.Outline=true
    distanceText.OutlineColor=Color3 .new(0,0,0)
    local weaponText=Drawing.new"Text"
    weaponText.Visible=false
    weaponText.Color=Color3 .new(1,0.5,0)
    weaponText.Size=14
    weaponText.Font=Drawing.Fonts.Monospace
    weaponText.Outline=true
    weaponText.OutlineColor=Color3 .new(0,0,0)
    local tracer=Drawing.new"Line"
    tracer.Visible=false
    tracer.Color=ESP_Config.TracerColor
    tracer.Thickness=ESP_Config.TracerThickness
    local skeletonLines={}
    local skeletonPoints={}
    for i=1,15 do
        skeletonLines[i]=Drawing.new"Line"
        skeletonLines[i].Visible=false
        skeletonLines[i].Color=ESP_Config.SkeletonColor
        skeletonLines[i].Thickness=ESP_Config.SkeletonThickness
    end
    skeletonPoints.Head=Drawing.new"Circle"
    skeletonPoints.Head.Visible=false
    skeletonPoints.Head.Color=Color3 .new(1,0.5,0)
    skeletonPoints.Head.Thickness=2
    skeletonPoints.Head.Filled=true
    skeletonPoints.Head.Radius=4
    local lastHealth=100
    local healthChangeTime=0
    local smoothHealth=100
    ESPComponents[player]={
        box=box,
        healthBar=healthBar,
        healthBarBackground=healthBarBackground,
        healthBarBorder=healthBarBorder,
        healthText=healthText,
        nameText=nameText,
        distanceText=distanceText,
        weaponText=weaponText,
        tracer=tracer,
        skeletonLines=skeletonLines,
        skeletonPoints=skeletonPoints
    }
    local function hideAll()
        box.Visible=false
        healthBar.Visible=false
        healthBarBackground.Visible=false
        healthBarBorder.Visible=false
        healthText.Visible=false
        nameText.Visible=false
        distanceText.Visible=false
        weaponText.Visible=false
        tracer.Visible=false
        for _,line in pairs(skeletonLines)do
            line.Visible=false
        end
        for _,point in pairs(skeletonPoints)do
            point.Visible=false
        end
    end
    RunService.RenderStepped:Connect(function()
        if not ESP_Config.EnableESP then
            hideAll()
            return
        end
        if not player.Character or not player.Character:FindFirstChild"HumanoidRootPart"or not player.Character:FindFirstChild"Humanoid"or player==LocalPlayer then
            hideAll()
            return
        end
        if ESP_Config.TeamCheck and player.Team and player.Team==LocalPlayer.Team then
            hideAll()
            return
        end
        local character=player.Character
        local rootPart=character:FindFirstChild"HumanoidRootPart"
        local humanoid=character:FindFirstChild"Humanoid"
        if not rootPart or not humanoid or humanoid.Health<=0 then
            hideAll()
            return
        end
        local dist=(rootPart.Position-Camera.CFrame.Position).Magnitude
        if dist>ESP_Config.MaxDrawDistance then
            hideAll()
            return
        end
        local rootPos,onScreen=Camera:WorldToViewportPoint(rootPart.Position)
        local headPos,_=Camera:WorldToViewportPoint(rootPart.Position+Vector3 .new(0,3,0))
        local legPos,_=Camera:WorldToViewportPoint(rootPart.Position-Vector3 .new(0,3,0))
        local color=ESP_Config.EnemyColor
        if ESP_Config.TeamCheck and player.Team and player.Team==LocalPlayer.Team then
            color=ESP_Config.TeammateColor
        end
        local weaponName="\230\151\160\230\173\166\229\153\168"
        for _,tool in ipairs(character:GetChildren())do
            if tool:IsA"Tool"then
                weaponName=tool.Name
                break
            end
        end
        if ESP_Config.ShowBox and onScreen then
            box.Size=Vector2 .new(1000/rootPos.Z,headPos.Y-legPos.Y)
            box.Position=Vector2 .new(rootPos.X-box.Size.X/2,rootPos.Y-box.Size.Y/2)
            box.Visible=true
            box.Color=ESP_Config.BoxColor
            box.Thickness=ESP_Config.BoxThickness
        else
            box.Visible=false
        end
        if ESP_Config.ShowHealth and onScreen then
            local healthPercentage=humanoid.Health/humanoid.MaxHealth
            local barX=headPos.X-25
            local barY=headPos.Y-20
            healthBarBackground.Size=Vector2 .new(50,5)
            healthBarBackground.Position=Vector2 .new(barX,barY)
            healthBarBackground.Visible=true
            healthBarBorder.Size=Vector2 .new(50,5)
            healthBarBorder.Position=Vector2 .new(barX,barY)
            healthBarBorder.Visible=true
            smoothHealth=smoothHealth+(humanoid.Health-smoothHealth)*0.1
            local smoothHP=smoothHealth/humanoid.MaxHealth
            healthBar.Size=Vector2 .new(50*smoothHP,5)
            healthBar.Position=Vector2 .new(barX,barY)
            if smoothHP>=0.8 then
                healthBar.Color=Color3 .new(0,1,0)
            elseif smoothHP>=0.5 then
                healthBar.Color=Color3 .new(1,1,0)
            elseif smoothHP>=0.2 then
                healthBar.Color=Color3 .new(1,0.5,0)
            else
                healthBar.Color=Color3 .new(1,0,0)
            end
            if humanoid.Health~=lastHealth then
                healthChangeTime=tick()
                lastHealth=humanoid.Health
            end
            if tick()-healthChangeTime<0.5 then
                healthBar.Color=Color3 .new(1,0,0)
            end
            healthBar.Visible=true
            healthText.Position=Vector2 .new(barX+50+5,barY-5)
            healthText.Text=math.floor(humanoid.Health).."/"..math.floor(humanoid.MaxHealth)
            healthText.Color=color
            healthText.Visible=true
        else
            healthBar.Visible=false
            healthBarBackground.Visible=false
            healthBarBorder.Visible=false
            healthText.Visible=false
        end
        if ESP_Config.ShowName and onScreen then
            nameText.Position=Vector2 .new(headPos.X,headPos.Y-35)
            nameText.Text=player.Name
            nameText.Color=color
            nameText.Visible=true
            if ESP_Config.ShowDistance then
                distanceText.Position=Vector2 .new(headPos.X,headPos.Y+10)
                distanceText.Text=math.floor(dist).."m"
                distanceText.Visible=true
            else
                distanceText.Visible=false
            end
            if ESP_Config.ShowWeapon then
                weaponText.Position=Vector2 .new(headPos.X,headPos.Y-50)
                weaponText.Text=weaponName
                weaponText.Visible=true
            else
                weaponText.Visible=false
            end
        else
            nameText.Visible=false
            distanceText.Visible=false
            weaponText.Visible=false
        end
        if ESP_Config.ShowTracer then
            local head=character:FindFirstChild"Head"
            if head then
                local hPos,hOnScreen=Camera:WorldToViewportPoint(head.Position)
                if hOnScreen then
                    tracer.From=Vector2 .new(Camera.ViewportSize.X/2,0)
                    tracer.To=Vector2 .new(hPos.X,hPos.Y)
                    tracer.Visible=true
                    tracer.Color=ESP_Config.TracerColor
                    tracer.Thickness=ESP_Config.TracerThickness
                    if dist<20 then
                        tracer.Color=Color3 .new(0,1,0)
                    elseif dist<50 then
                        tracer.Color=Color3 .new(1,1,0)
                    else
                        tracer.Color=ESP_Config.TracerColor
                    end
                else
                    tracer.Visible=false
                end
            else
                tracer.Visible=false
            end
        else
            tracer.Visible=false
        end
        if ESP_Config.ShowSkeleton and onScreen then
            local head=character:FindFirstChild"Head"
            local torso=character:FindFirstChild"Torso"or character:FindFirstChild"UpperTorso"
            local leftArm=character:FindFirstChild"Left Arm"or character:FindFirstChild"LeftUpperArm"
            local rightArm=character:FindFirstChild"Right Arm"or character:FindFirstChild"RightUpperArm"
            local leftLeg=character:FindFirstChild"Left Leg"or character:FindFirstChild"LeftUpperLeg"
            local rightLeg=character:FindFirstChild"Right Leg"or character:FindFirstChild"RightUpperLeg"
            if head and torso and leftArm and rightArm and leftLeg and rightLeg then
                local hP=Camera:WorldToViewportPoint(head.Position)
                local tP=Camera:WorldToViewportPoint(torso.Position)
                local laP=Camera:WorldToViewportPoint(leftArm.Position)
                local raP=Camera:WorldToViewportPoint(rightArm.Position)
                local llP=Camera:WorldToViewportPoint(leftLeg.Position)
                local rlP=Camera:WorldToViewportPoint(rightLeg.Position)
                skeletonPoints.Head.Position=Vector2 .new(hP.X,hP.Y)
                skeletonPoints.Head.Visible=true
                skeletonLines[1].From=Vector2 .new(hP.X,hP.Y)
                skeletonLines[1].To=Vector2 .new(tP.X,tP.Y)
                skeletonLines[1].Visible=true
                skeletonLines[2].From=Vector2 .new(tP.X,tP.Y)
                skeletonLines[2].To=Vector2 .new(laP.X,laP.Y)
                skeletonLines[2].Visible=true
                skeletonLines[3].From=Vector2 .new(tP.X,tP.Y)
                skeletonLines[3].To=Vector2 .new(raP.X,raP.Y)
                skeletonLines[3].Visible=true
                skeletonLines[4].From=Vector2 .new(tP.X,tP.Y)
                skeletonLines[4].To=Vector2 .new(llP.X,llP.Y)
                skeletonLines[4].Visible=true
                skeletonLines[5].From=Vector2 .new(tP.X,tP.Y)
                skeletonLines[5].To=Vector2 .new(rlP.X,rlP.Y)
                skeletonLines[5].Visible=true
                if character:FindFirstChild"LeftLowerArm"then
                    local pos=Camera:WorldToViewportPoint(character.LeftLowerArm.Position)
                    skeletonLines[6].From=Vector2 .new(laP.X,laP.Y)
                    skeletonLines[6].To=Vector2 .new(pos.X,pos.Y)
                    skeletonLines[6].Visible=true
                end
                if character:FindFirstChild"RightLowerArm"then
                    local pos=Camera:WorldToViewportPoint(character.RightLowerArm.Position)
                    skeletonLines[7].From=Vector2 .new(raP.X,raP.Y)
                    skeletonLines[7].To=Vector2 .new(pos.X,pos.Y)
                    skeletonLines[7].Visible=true
                end
                if character:FindFirstChild"LeftLowerLeg"then
                    local pos=Camera:WorldToViewportPoint(character.LeftLowerLeg.Position)
                    skeletonLines[8].From=Vector2 .new(llP.X,llP.Y)
                    skeletonLines[8].To=Vector2 .new(pos.X,pos.Y)
                    skeletonLines[8].Visible=true
                end
                if character:FindFirstChild"RightLowerLeg"then
                    local pos=Camera:WorldToViewportPoint(character.RightLowerLeg.Position)
                    skeletonLines[9].From=Vector2 .new(rlP.X,rlP.Y)
                    skeletonLines[9].To=Vector2 .new(pos.X,pos.Y)
                    skeletonLines[9].Visible=true
                end
            else
                for _,line in pairs(skeletonLines)do
                    line.Visible=false
                end
                for _,point in pairs(skeletonPoints)do
                    point.Visible=false
                end
            end
        else
            for _,line in pairs(skeletonLines)do
                line.Visible=false
            end
            for _,point in pairs(skeletonPoints)do
                point.Visible=false
            end
        end
    end)
end
local function cleanupESP(player)
    if ESPComponents[player]then
        local comps=ESPComponents[player]
        for key,component in pairs(comps)do
            if typeof(component)=="table"then
                for _,drawing in pairs(component)do
                    if typeof(drawing)=="userdata"then
                        pcall(function()
                            drawing:Remove()
                        end)
                    end
                end
            else
                if typeof(component)=="userdata"then
                    pcall(function()
                        component:Remove()
                    end)
                end
            end
        end
        ESPComponents[player]=nil
    end
end
for _,player in ipairs(Players:GetPlayers())do
    if player~=LocalPlayer then
        createESP(player)
    end
end
Players.PlayerAdded:Connect(function(player)
    if player~=LocalPlayer then
        createESP(player)
    end
end)
Players.PlayerRemoving:Connect(function(player)
    cleanupESP(player)
end)
Tabs.ESP:Paragraph{
    Title="ESP\233\128\143\232\167\134\232\174\190\231\189\174",
    Desc="Drawing API\233\171\152\230\128\167\232\131\189\233\128\143\232\167\134",
    ImageSize=22,
    ThumbnailSize=0
}
Tabs.ESP:Toggle{
    Title="\229\188\128\229\144\175ESP\230\128\187\229\188\128\229\133\179",
    Desc="\229\133\168\229\177\128\229\144\175\231\148\168\233\128\143\232\167\134",
    Default=false,
    Callback=function(state)
        ESP_Config.EnableESP=state
        if not state then
            for _,player in ipairs(Players:GetPlayers())do
                if player~=LocalPlayer then
                    if ESPComponents[player]then
                        for key,component in pairs(ESPComponents[player])do
                            if typeof(component)=="table"then
                                for _,drawing in pairs(component)do
                                    if typeof(drawing)=="userdata"then
                                        pcall(function()
                                            drawing.Visible=false
                                        end)
                                    end
                                end
                            else
                                if typeof(component)=="userdata"then
                                    pcall(function()
                                        component.Visible=false
                                    end)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
}
Tabs.ESP:Toggle{
    Title="\230\152\190\231\164\186\229\164\180\233\161\182\229\144\141\231\167\176",
    Desc="\231\142\169\229\174\182ID",
    Default=true,
    Callback=function(v)
        ESP_Config.ShowName=v
    end
}
Tabs.ESP:Toggle{
    Title="\230\152\190\231\164\186\232\161\128\233\135\143",
    Default=true,
    Callback=function(v)
        ESP_Config.ShowHealth=v
    end
}
Tabs.ESP:Toggle{
    Title="\230\152\190\231\164\186\232\183\157\231\166\187",
    Default=true,
    Callback=function(v)
        ESP_Config.ShowDistance=v
    end
}
Tabs.ESP:Toggle{
    Title="\230\150\185\230\161\134\233\128\143\232\167\134",
    Desc="2D\230\150\185\230\161\134",
    Default=true,
    Callback=function(v)
        ESP_Config.ShowBox=v
    end
}
Tabs.ESP:Toggle{
    Title="\229\176\132\231\186\191\233\128\143\232\167\134",
    Desc="\228\187\142\229\177\143\229\185\149\233\161\182\233\131\168",
    Default=false,
    Callback=function(v)
        ESP_Config.ShowTracer=v
    end
}
Tabs.ESP:Toggle{
    Title="\233\170\168\230\158\182\233\128\143\232\167\134",
    Desc="\233\170\168\233\170\188\231\186\191\230\157\161",
    Default=false,
    Callback=function(v)
        ESP_Config.ShowSkeleton=v
    end
}
Tabs.ESP:Toggle{
    Title="\230\173\166\229\153\168\230\152\190\231\164\186",
    Desc="\230\152\190\231\164\186\230\137\139\230\140\129\230\173\166\229\153\168\229\144\141",
    Default=false,
    Callback=function(v)
        ESP_Config.ShowWeapon=v
    end
}
Tabs.ESP:Toggle{
    Title="\231\169\191\229\162\153ESP",
    Desc="\229\162\153\228\189\147\233\129\174\230\140\161\228\190\157\230\151\167\230\152\190\231\164\186",
    Default=false,
    Callback=function(v)
        ESP_Config.WallHack=v
    end
}
Tabs.ESP:Toggle{
    Title="\229\140\186\229\136\134\233\152\159\229\143\139\233\162\156\232\137\178",
    Desc="\233\152\159\229\143\139\231\187\191/\230\149\140\228\186\186\231\186\162/NPC\233\187\132",
    Default=false,
    Callback=function(v)
        ESP_Config.TeamCheck=v
    end
}
Tabs.ESP:Slider{
    Title="ESP\230\156\128\229\164\167\229\143\175\232\167\134\232\183\157\231\166\187",
    Desc="\232\182\133\229\135\186\232\183\157\231\166\187\228\184\141\230\184\178\230\159\147",
    Value={
        Min=50,
        Max=1000,
        Default=350
    },
    Step=10,
    IsTextbox=true,
    Callback=function(val)
        ESP_Config.MaxDrawDistance=val
    end
}
local FONT_NAME=Drawing.Fonts.Monospace
local MAX_DISTANCE=1500
local BOX_THICKNESS=1
local BOX_SCALE=2.2
local Players=game:GetService"Players"
local RunService=game:GetService"RunService"
local LocalPlayer=Players.LocalPlayer
local Camera=workspace.CurrentCamera
local ESPEnabled=false
local DrawBox=false
local DrawDistance=false
local DrawName=false
local DrawTracer=false
local DrawHealth=false
local ESPObjects={}
local ESP_RenderConn=nil
local ESP_Initialized=false
local function WorldToScreen(worldPos)
    local screenPos,onScreen=Camera:WorldToViewportPoint(worldPos)
    if not onScreen then
        return nil
    end
    return Vector2 .new(screenPos.X,screenPos.Y)
end
local function GetCharacterData(player)
    local char=player.Character
    if not char then
        return nil
    end
    local humanoid=char:FindFirstChildOfClass"Humanoid"
    local root=char:FindFirstChild"HumanoidRootPart"or char:FindFirstChild"UpperTorso"or char:FindFirstChild"Torso"
    local head=char:FindFirstChild"Head"
    if not humanoid or not root or not head then
        return nil
    end
    return char,humanoid,root,head
end
local function CreateDrawingObjects()
    local objs={}
    objs.Box=Drawing.new"Square"
    objs.Box.Filled=false
    objs.Box.Transparency=1
    objs.Name=Drawing.new"Text"
    objs.Name.Size=16
    objs.Name.Center=true
    objs.Name.Outline=true
    objs.Name.Font=FONT_NAME
    objs.Distance=Drawing.new"Text"
    objs.Distance.Size=14
    objs.Distance.Center=true
    objs.Distance.Outline=true
    objs.Distance.Font=FONT_NAME
    objs.Health=Drawing.new"Text"
    objs.Health.Size=14
    objs.Health.Center=true
    objs.Health.Outline=true
    objs.Health.Font=FONT_NAME
    objs.Tracer=Drawing.new"Line"
    objs.Tracer.Thickness=1
    objs.Tracer.Transparency=0.5
    return objs
end
local function DestroyDrawingObjects(objs)
    if not objs then
        return
    end
    for _,obj in pairs(objs)do
        if obj and obj.Remove then
            pcall(function()
                obj:Remove()
            end)
        end
    end
end
local function UpdatePlayerESP(player,objs)
    if player==LocalPlayer then
        return
    end
    local char,humanoid,root,head=GetCharacterData(player)
    if not char or not humanoid or humanoid.Health<=0 then
        for _,obj in pairs(objs)do
            obj.Visible=false
        end
        return
    end
    local distance=(Camera.CFrame.Position-root.Position).Magnitude
    if distance>MAX_DISTANCE then
        for _,obj in pairs(objs)do
            obj.Visible=false
        end
        return
    end
    local headScreen=WorldToScreen(head.Position+Vector3 .new(0,0.5,0))
    local rootScreen=WorldToScreen(root.Position)
    if not headScreen or not rootScreen then
        for _,obj in pairs(objs)do
            obj.Visible=false
        end
        return
    end
    local height=math.abs(headScreen.Y-rootScreen.Y)*BOX_SCALE
    local width=height*0.65
    height=math.max(height,15)
    width=math.max(width,10)
    local topLeft=Vector2 .new(headScreen.X-width/2,headScreen.Y-height*0.2)
    local bottomRight=Vector2 .new(headScreen.X+width/2,topLeft.Y+height)
    if DrawBox then
        objs.Box.Visible=true
        objs.Box.Size=bottomRight-topLeft
        objs.Box.Position=topLeft
        objs.Box.Thickness=BOX_THICKNESS
        local healthPercent=humanoid.Health/humanoid.MaxHealth
        if healthPercent>0.5 then
            objs.Box.Color=Color3 .fromRGB(0,255,0)
        elseif healthPercent>0.25 then
            objs.Box.Color=Color3 .fromRGB(255,165,0)
        else
            objs.Box.Color=Color3 .fromRGB(255,0,0)
        end
    else
        objs.Box.Visible=false
    end
    if DrawName then
        objs.Name.Visible=true
        objs.Name.Text=player.Name
        objs.Name.Color=Color3 .fromRGB(255,255,255)
        objs.Name.Position=Vector2 .new(headScreen.X,topLeft.Y-16-2)
    else
        objs.Name.Visible=false
    end
    if DrawDistance then
        objs.Distance.Visible=true
        objs.Distance.Text=string.format("[%d m]",math.floor(distance))
        objs.Distance.Color=Color3 .fromRGB(200,200,200)
        objs.Distance.Position=Vector2 .new(headScreen.X,bottomRight.Y+2)
    else
        objs.Distance.Visible=false
    end
    if DrawHealth then
        objs.Health.Visible=true
        objs.Health.Text=string.format("HP: %d/%d",math.floor(humanoid.Health),math.floor(humanoid.MaxHealth))
        objs.Health.Color=Color3 .fromRGB(0,255,0)
        objs.Health.Position=Vector2 .new(headScreen.X,bottomRight.Y+16+2)
    else
        objs.Health.Visible=false
    end
    if DrawTracer then
        objs.Tracer.Visible=true
        objs.Tracer.From=Vector2 .new(Camera.ViewportSize.X/2,0)
        objs.Tracer.To=Vector2 .new(headScreen.X,bottomRight.Y)
        objs.Tracer.Color=Color3 .fromRGB(255,255,255)
    else
        objs.Tracer.Visible=false
    end
end
local function InitPlayer(player)
    if player==LocalPlayer then
        return
    end
    if ESPObjects[player]then
        DestroyDrawingObjects(ESPObjects[player])
    end
    ESPObjects[player]=CreateDrawingObjects()
end
Tabs.ESPP:Button{
    Title="\229\136\157\229\167\139\229\140\150ESP",
    Callback=function()
        if ESP_Initialized then
            print"\226\154\160\239\184\143 ESP\229\183\178\231\187\143\229\136\157\229\167\139\229\140\150\239\188\140\230\151\160\233\156\128\233\135\141\229\164\141\231\130\185\229\135\187"
            return
        end
        ESP_Initialized=true
        for _,player in ipairs(Players:GetPlayers())do
            InitPlayer(player)
        end
        Players.PlayerAdded:Connect(InitPlayer)
        Players.PlayerRemoving:Connect(function(player)
            if ESPObjects[player]then
                DestroyDrawingObjects(ESPObjects[player])
                ESPObjects[player]=nil
            end
        end)
        ESP_RenderConn=RunService.RenderStepped:Connect(function()
            if not ESPEnabled then
                return
            end
            for player,objs in pairs(ESPObjects)do
                if player.Parent then
                    pcall(UpdatePlayerESP,player,objs)
                else
                    DestroyDrawingObjects(objs)
                    ESPObjects[player]=nil
                end
            end
        end)
        print"\226\156\133 ESP\229\136\157\229\167\139\229\140\150\229\174\140\230\136\144\239\188\140\232\175\183\228\189\191\231\148\168\228\184\139\230\150\185Toggle\229\188\128\229\133\179\230\142\167\229\136\182\229\138\159\232\131\189"
    end
}
Tabs.ESPP:Toggle{
    Title="ESP\230\128\187\229\188\128\229\133\179",
    Value=false,
    Callback=function(s)
        ESPEnabled=s
        print("ESP\230\128\187\229\188\128\229\133\179\239\188\154",s and"\226\156\133\229\188\128\229\144\175"or"\226\157\140\229\133\179\233\151\173")
        if not s then
            for _,objs in pairs(ESPObjects)do
                for _,obj in pairs(objs)do
                    obj.Visible=false
                end
            end
        end
    end
}
Tabs.ESPP:Toggle{
    Title="\231\142\169\229\174\182\230\150\185\230\161\134",
    Value=false,
    Callback=function(s)
        DrawBox=s
        print("\231\142\169\229\174\182\230\150\185\230\161\134\239\188\154",s and"\226\156\133\229\188\128\229\144\175"or"\226\157\140\229\133\179\233\151\173")
    end
}
Tabs.ESPP:Toggle{
    Title="\231\142\169\229\174\182\229\144\141\229\173\151",
    Value=false,
    Callback=function(s)
        DrawName=s
        print("\231\142\169\229\174\182\229\144\141\229\173\151\239\188\154",s and"\226\156\133\229\188\128\229\144\175"or"\226\157\140\229\133\179\233\151\173")
    end
}
Tabs.ESPP:Toggle{
    Title="\231\142\169\229\174\182\232\183\157\231\166\187",
    Value=false,
    Callback=function(s)
        DrawDistance=s
        print("\231\142\169\229\174\182\232\183\157\231\166\187\239\188\154",s and"\226\156\133\229\188\128\229\144\175"or"\226\157\140\229\133\179\233\151\173")
    end
}
Tabs.ESPP:Toggle{
    Title="\231\148\159\229\145\189\229\128\188",
    Value=false,
    Callback=function(s)
        DrawHealth=s
        print("\231\148\159\229\145\189\229\128\188\239\188\154",s and"\226\156\133\229\188\128\229\144\175"or"\226\157\140\229\133\179\233\151\173")
    end
}
Tabs.ESPP:Toggle{
    Title="\229\176\132\231\186\191",
    Value=false,
    Callback=function(s)
        DrawTracer=s
        print("\229\176\132\231\186\191\239\188\154",s and"\226\156\133\229\188\128\229\144\175"or"\226\157\140\229\133\179\233\151\173")
    end
}
Tabs.ESPP:Slider{
    Title="\230\156\128\229\164\167\230\184\178\230\159\147\232\183\157\231\166\187",
    Desc="\232\182\133\232\191\135\232\191\153\228\184\170\232\183\157\231\166\187\231\154\132\231\142\169\229\174\182\229\176\134\228\184\141\231\187\152\229\136\182",
    Value={
        Min=500,
        Max=5000,
        Default=1500
    },
    Step=100,
    IsTextbox=true,
    Callback=function(value)
        MAX_DISTANCE=value
    end
}
Tabs.ESPP:Slider{
    Title="\230\150\185\230\161\134\229\164\167\229\176\143\229\128\141\230\149\176",
    Desc="\230\149\176\229\128\188\232\182\138\229\164\167\230\150\185\230\161\134\232\182\138\229\164\167",
    Value={
        Min=1.5,
        Max=3,
        Default=2.2
    },
    Step=0.1,
    IsTextbox=true,
    Callback=function(value)
        BOX_SCALE=value
    end
}
Tabs.ESPP:Slider{
    Title="\230\150\185\230\161\134\231\186\191\230\157\161\231\178\151\231\187\134",
    Desc="\230\149\176\229\173\151\232\182\138\229\164\167\231\186\191\230\157\161\232\182\138\231\178\151",
    Value={
        Min=1,
        Max=5,
        Default=1
    },
    Step=1,
    IsTextbox=true,
    Callback=function(value)
        BOX_THICKNESS=value
    end
}
Tabs.wb:Button{
    Title="\230\163\128\230\159\165\229\133\168\229\177\128\231\156\139\230\156\137\228\186\186\229\129\183\229\144\131\229\141\176\233\146\158\230\156\186\230\178\161\230\156\137",
    Callback=function()
        local function createMoneyPrinterESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0,0.8,0.2)
            highlight.FillTransparency=0.15
            highlight.OutlineColor=Color3 .new(0.3,1,0.3)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,180,0,40)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\230\156\137\228\186\186\229\156\168\229\129\183\229\144\131\229\141\176\233\146\158\230\156\186 MoneyPrinter"
            textLabel.TextColor3=Color3 .new(0.3,1,0.3)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\146\176 MoneyPrinter \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllMoneyPrinters()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="MoneyPrinter"then
                    createMoneyPrinterESP(obj)
                    count=count+1
                end
            end
            return count
        end
        local total=searchAllMoneyPrinters()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 MoneyPrinter")
        print"\226\156\133 MoneyPrinter \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\231\187\191\232\137\178)"
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="MoneyPrinter"then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createMoneyPrinterESP(obj)
                            count=count+1
                        end
                    end
                end
                if count>0 then
                    print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 MoneyPrinter")
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(0.1)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="MoneyPrinter"then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createMoneyPrinterESP(newObj)
                    print"\240\159\146\176 \230\163\128\230\181\139\229\136\176\230\150\176\231\154\132 MoneyPrinter!"
                end
            end
        end)
        print"\226\156\133 \229\133\168\229\155\190 MoneyPrinter\239\188\136\229\141\176\233\146\158\230\156\186\239\188\137\233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\135\170\229\138\168\229\136\183\230\150\176)"
    end
}
local wbSec1=Tabs.wb:Section{
    Title="\229\143\152\229\141\150\231\137\169"
}
wbSec1:Button{
    Title="\233\135\145\229\157\151",
    Callback=function()
        local gizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
        if not gizmos then
            warn"Gizmos\228\184\141\229\173\152\229\156\168"
            return
        end
        local function isGoldBar(obj)
            return obj.Name=="Gold Bar"
        end
        local function createGoldBarESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(1,0.8,0)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(1,1,0)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,160,0,50)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=1000
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\233\135\145\229\157\151 "..obj.Name
            textLabel.TextColor3=Color3 .new(1,0.8,0)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root and obj:IsA"BasePart"then
                        local dist=(root.Position-obj.Position).Magnitude
                        distLabel.Text=string.format(" %.1fm",dist)
                    elseif root and obj:IsA"Model"and obj.PrimaryPart then
                        local dist=(root.Position-obj.PrimaryPart.Position).Magnitude
                        distLabel.Text=string.format(" %.1fm",dist)
                    end
                end)
            end
            print"\226\173\144 Gold Bar \229\183\178\230\160\135\232\174\176!"
        end
        local function searchGoldBar(parent)
            local count=0
            for _,obj in ipairs(parent:GetChildren())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and isGoldBar(obj)then
                    createGoldBarESP(obj)
                    count=count+1
                end
                if obj:IsA"Folder"or obj:IsA"Model"then
                    count=count+searchGoldBar(obj)
                end
            end
            return count
        end
        local total=searchGoldBar(gizmos)
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 Gold Bar")
        gizmos.DescendantAdded:Connect(function(newObj)
            task.wait(0.1)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and isGoldBar(newObj)then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createGoldBarESP(newObj)
                    print"\226\173\144 \230\150\176\229\162\158 Gold Bar"
                end
            end
        end)
        print"\226\156\133 Gold Bar \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168\239\188\136\228\187\133\231\178\190\231\161\174\229\140\185\233\133\141\239\188\137"
    end
}
wbSec1:Button{
    Title="BTCESP",
    Callback=function()
        local function createBitcoinESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(1,0.6,0)
            highlight.FillTransparency=0.15
            highlight.OutlineColor=Color3 .new(1,0.8,0.2)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,160,0,40)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\230\175\148\231\137\185\229\184\129 Bitcoin"
            textLabel.TextColor3=Color3 .new(1,0.7,0.1)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\226\130\191 Bitcoin \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllBitcoin()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="Bitcoin"then
                    createBitcoinESP(obj)
                    count=count+1
                end
            end
            return count
        end
        local total=searchAllBitcoin()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 Bitcoin")
        print"\226\156\133 Bitcoin \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\230\169\153\232\137\178)"
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="Bitcoin"then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createBitcoinESP(obj)
                            count=count+1
                        end
                    end
                end
                if count>0 then
                    print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 Bitcoin")
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(5)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="Bitcoin"then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createBitcoinESP(newObj)
                    print"\226\130\191 \230\163\128\230\181\139\229\136\176\230\150\176\231\154\132 Bitcoin!"
                end
            end
        end)
        print"\226\156\133 \229\133\168\229\155\190 Bitcoin \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\135\170\229\138\168\229\136\183\230\150\176)"
    end
}
wbSec1:Button{
    Title="\231\180\171\229\174\157\231\159\179",
    Callback=function()
        local function createGemESP(obj,color,icon)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=color
            highlight.FillTransparency=0.2
            highlight.OutlineColor=color
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,200,0,55)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=0
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text=icon.." "..obj.Name
            textLabel.TextColor3=color
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print("\240\159\146\142\231\180\171\229\174\157\231\159\179 "..obj.Name.." \229\183\178\230\160\135\232\174\176!")
        end
        local gizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
        if not gizmos then
            warn"Gizmos\228\184\141\229\173\152\229\156\168"
            return
        end
        local gemColors={
            ["Sapphire"]={
                color=Color3 .new(0.6,0,1),
                icon="\240\159\146\142"
            }
        }
        local function scanAllGems()
            local count=0
            for _,obj in ipairs(gizmos:GetChildren())do
                local gemInfo=gemColors[obj.Name]
                if gemInfo and(obj:IsA"Model"or obj:IsA"BasePart")then
                    createGemESP(obj,gemInfo.color,gemInfo.icon)
                    count=count+1
                end
            end
            print("\226\156\133 \229\183\178\230\160\135\232\174\176 "..count.." \228\184\170\229\174\157\231\159\179")
        end
        scanAllGems()
        spawn(function()
            while true do
                wait(5)
                for _,obj in ipairs(gizmos:GetChildren())do
                    local gemInfo=gemColors[obj.Name]
                    if gemInfo and(obj:IsA"Model"or obj:IsA"BasePart")then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createGemESP(obj,gemInfo.color,gemInfo.icon)
                        end
                    end
                end
            end
        end)
        print"\226\156\133 \230\137\128\230\156\137\229\174\157\231\159\179\233\128\143\232\167\134\229\183\178\229\144\175\229\138\168"
    end
}
wbSec1:Button{
    Title="\228\191\157\233\153\169\231\174\177",
    Callback=function()
        local function createSafeDoorESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(1,0.7,0)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(1,0.9,0.3)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,160,0,40)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\228\191\157\233\153\169\231\174\177 SafeDoor"
            textLabel.TextColor3=Color3 .new(1,0.8,0)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\148\144 SafeDoor \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllSafeDoors()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="SafeDoor"then
                    createSafeDoorESP(obj)
                    count=count+1
                end
            end
            return count
        end
        local total=searchAllSafeDoors()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 SafeDoor")
        print"\226\156\133 SafeDoor \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\233\135\145\232\137\178)"
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="SafeDoor"then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createSafeDoorESP(obj)
                            count=count+1
                        end
                    end
                end
                if count>0 then
                    print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 SafeDoor")
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(5)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="SafeDoor"then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createSafeDoorESP(newObj)
                    print" \230\163\128\230\181\139\229\136\176\230\150\176\231\154\132 SafeDoor!"
                end
            end
        end)
        print"\226\156\133 SafeDoor \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\229\133\168\229\177\128\230\144\156\231\180\162 + \232\135\170\229\138\168\229\136\183\230\150\176)"
    end
}
wbSec1:Button{
    Title="\231\180\171\230\176\180\230\153\182",
    Callback=function()
        local gizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
        local amethystRing=gizmos and gizmos:FindFirstChild"Amethyst Ring"
        if not amethystRing then
            warn"Amethyst Ring \228\184\141\229\173\152\229\156\168"
            return
        end
        local function createAmethystRingESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0.7,0.2,1)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(0.9,0.4,1)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,200,0,55)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=0
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text=" \231\180\171\230\176\180\230\153\182"
            textLabel.TextColor3=Color3 .new(0.8,0.3,1)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\146\141 Amethyst Ring \229\183\178\230\160\135\232\174\176!"
        end
        createAmethystRingESP(amethystRing)
        print"\226\156\133 Amethyst Ring \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168"
    end
}
local wbSec2=Tabs.wb:Section{
    Title="\230\158\170\230\162\176\230\152\190\231\164\186"
}
wbSec2:Button{
    Title="AK47",
    Callback=function()
        local gizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
        local pelicanCase=gizmos and gizmos:FindFirstChild"PelicanCase"
        local ak47=pelicanCase and pelicanCase:FindFirstChild"AK-47"
        if not ak47 then
            warn"AK-47 \228\184\141\229\173\152\229\156\168\239\188\140\232\175\183\230\163\128\230\159\165\232\183\175\229\190\132"
            return
        end
        local function createAK47ESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(1,0.2,0)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(1,0,0)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,200,0,35)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=0
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="AK-47"
            textLabel.TextColor3=Color3 .new(1,0.3,0)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print" AK-47 \229\183\178\230\160\135\232\174\176!"
        end
        createAK47ESP(ak47)
        print"\226\156\133 AK-47 \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168"
    end
}
wbSec2:Button{
    Title="AUG A1",
    Callback=function()
        local function createAUGESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0.6,0.2,1)
            highlight.FillTransparency=0.15
            highlight.OutlineColor=Color3 .new(0.8,0.4,1)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,160,0,28)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="AUG A1"
            textLabel.TextColor3=Color3 .new(0.7,0.3,1)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\148\171 AUG A1 \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllAUG()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="AUG A1"then
                    createAUGESP(obj)
                    count=count+1
                end
            end
            return count
        end
        local total=searchAllAUG()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 AUG A1")
        print"\226\156\133 AUG A1 \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\231\180\171\232\137\178)"
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="AUG A1"then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createAUGESP(obj)
                            count=count+1
                        end
                    end
                end
                if count>0 then
                    print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 AUG A1")
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(5)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="AUG A1"then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createAUGESP(newObj)
                    print"\240\159\148\171 \230\163\128\230\181\139\229\136\176\230\150\176\231\154\132 AUG A1!"
                end
            end
        end)
        print"\226\156\133 \229\133\168\229\155\190 AUG A1 \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\135\170\229\138\168\229\136\183\230\150\176)"
    end
}
wbSec2:Button{
    Title="\231\177\179\230\139\137\231\142\155\231\139\153\231\165\158AWM",
    Callback=function()
        local function isInteractable(obj)
            if obj:FindFirstChild"ClickDetector"then
                return true
            end
            if obj:FindFirstChild"ProximityPrompt"then
                return true
            end
            if obj:FindFirstChild"TouchInterest"then
                return true
            end
            if obj:IsA"Tool"then
                return true
            end
            if obj:FindFirstChild"Handle"then
                return true
            end
            if obj.Parent then
                if obj.Parent:FindFirstChild"ClickDetector"then
                    return true
                end
                if obj.Parent:FindFirstChild"ProximityPrompt"then
                    return true
                end
                if obj.Parent:FindFirstChild"TouchInterest"then
                    return true
                end
                if obj.Parent:IsA"Tool"then
                    return true
                end
                if obj.Parent:FindFirstChild"Handle"then
                    return true
                end
            end
            for _,child in ipairs(obj:GetChildren())do
                if child:IsA"ClickDetector"or child:IsA"ProximityPrompt"or child:IsA"TouchInterest"then
                    return true
                end
                if child.Name=="Handle"then
                    return true
                end
            end
            return false
        end
        local function createAWMESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0.3,0.3,0.3)
            highlight.FillTransparency=0.15
            highlight.OutlineColor=Color3 .new(1,0.2,0.2)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,140,0,25)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text=" AWM"
            textLabel.TextColor3=Color3 .new(1,0.3,0.3)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text="\240\159\147\143 --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\142\175 AWM \229\183\178\230\160\135\232\174\176 (\229\143\175\228\186\164\228\186\146)"
        end
        local function searchAndDrawAWM()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="AWM"then
                    if isInteractable(obj)then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createAWMESP(obj)
                            count=count+1
                        end
                    end
                end
            end
            return count
        end
        local total=searchAndDrawAWM()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170\229\143\175\228\186\164\228\186\146\231\154\132 AWM")
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="AWM"then
                        if isInteractable(obj)and not obj:FindFirstChild"ESP_Highlight"then
                            createAWMESP(obj)
                            count=count+1
                        end
                    end
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(0.1)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="AWM"then
                if isInteractable(newObj)and not newObj:FindFirstChild"ESP_Highlight"then
                    createAWMESP(newObj)
                end
            end
        end)
        print"\226\156\133 AWM \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\228\187\133\229\143\175\228\186\164\228\186\146, \229\173\151\228\189\147\229\183\178\232\176\131\229\176\143)"
    end
}
wbSec2:Button{
    Title="M4A1",
    Callback=function()
        local function getM4A1()
            local gizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
            local pelicanCase=gizmos and gizmos:FindFirstChild"PelicanCase"
            return pelicanCase and pelicanCase:FindFirstChild"M4A1"
        end
        local function createM4A1ESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0,0.5,1)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(0,1,1)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,200,0,55)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=0
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text=" M4A1"
            textLabel.TextColor3=Color3 .new(0,0.6,1)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\148\171 M4A1 \229\183\178\230\160\135\232\174\176!"
        end
        local function startLoopESP()
            local lastM4A1=nil
            game:GetService"RunService".Heartbeat:Connect(function()
                local currentM4A1=getM4A1()
                if currentM4A1 and currentM4A1~=lastM4A1 then
                    if lastM4A1 then
                        local oldHighlight=lastM4A1:FindFirstChild"ESP_Highlight"
                        if oldHighlight then
                            oldHighlight:Destroy()
                        end
                        local oldTag=lastM4A1:FindFirstChild"ESP_Tag"
                        if oldTag then
                            oldTag:Destroy()
                        end
                    end
                    createM4A1ESP(currentM4A1)
                    lastM4A1=currentM4A1
                end
                if not currentM4A1 then
                    lastM4A1=nil
                end
            end)
        end
        startLoopESP()
        print"\226\156\133 M4A1 \229\190\170\231\142\175\233\128\143\232\167\134\229\183\178\229\144\175\229\138\168\239\188\136\232\135\170\229\138\168\233\135\141\232\191\158\239\188\137"
    end
}
wbSec2:Button{
    Title="RPG",
    Callback=function()
        local function createRPG7ESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(1,0.5,0)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(1,0.2,0)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,200,0,55)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text=" RPG-7"
            textLabel.TextColor3=Color3 .new(1,0.5,0)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print" RPG-7 \229\183\178\230\160\135\232\174\176!"
        end
        local gizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
        local pelicanCase=gizmos and gizmos:FindFirstChild"PelicanCase"
        if not pelicanCase then
            warn"PelicanCase \228\184\141\229\173\152\229\156\168"
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="RPG-7"then
                    createRPG7ESP(obj)
                    count=count+1
                end
            end
            print("\226\156\133 \229\133\168\229\177\128\230\144\156\231\180\162\230\137\190\229\136\176 "..count.." \228\184\170 RPG-7")
        else
            local count=0
            for _,obj in ipairs(pelicanCase:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="RPG-7"then
                    createRPG7ESP(obj)
                    count=count+1
                end
            end
            print("\226\156\133 PelicanCase \228\184\173\230\137\190\229\136\176 "..count.." \228\184\170 RPG-7")
        end
        print"\226\156\133 RPG-7 \231\129\171\231\174\173\231\173\146\233\128\143\232\167\134\229\183\178\229\144\175\229\138\168"
        local function rescanRPG7()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="RPG-7"then
                    if not obj:FindFirstChild"ESP_Highlight"then
                        createRPG7ESP(obj)
                        count=count+1
                    end
                end
            end
            if count>0 then
                print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 RPG-7")
            end
        end
        game:GetService"RunService".Heartbeat:Connect(function()
            if not _G.lastRescanTime then
                _G.lastRescanTime=tick()
            end
            if tick()-_G.lastRescanTime>=5 then
                _G.lastRescanTime=tick()
                rescanRPG7()
            end
        end)
        print"\226\156\133 \230\175\143\53\231\167\146\232\135\170\229\138\168\233\135\141\230\150\176\230\144\156\231\180\162\229\183\178\229\144\175\229\138\168"
    end
}
wbSec2:Button{
    Title="ARX-160",
    Callback=function()
        local function createARX160ESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0.2,0.5,1)
            highlight.FillTransparency=0.15
            highlight.OutlineColor=Color3 .new(0.4,0.7,1)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,160,0,40)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text=" ARX-160"
            textLabel.TextColor3=Color3 .new(0.3,0.6,1)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\148\171 ARX-160 \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllARX160()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="ARX-160"then
                    createARX160ESP(obj)
                    count=count+1
                end
            end
            return count
        end
        local total=searchAllARX160()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 ARX-160")
        print"\226\156\133 ARX-160 \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\147\157\232\137\178)"
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="ARX-160"then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createARX160ESP(obj)
                            count=count+1
                        end
                    end
                end
                if count>0 then
                    print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 ARX-160")
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(0.1)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="ARX-160"then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createARX160ESP(newObj)
                    print"\240\159\148\171 \230\163\128\230\181\139\229\136\176\230\150\176\231\154\132 ARX-160!"
                end
            end
        end)
        print"\226\156\133 \229\133\168\229\155\190 ARX-160 \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\135\170\229\138\168\229\136\183\230\150\176)"
    end
}
wbSec1:Button{
    Title="\232\180\167\231\137\169\229\141\161",
    Callback=function()
        local localContainer=workspace:FindFirstChild"Local"
        local tools=localContainer and localContainer:FindFirstChild"Tools"
        local cargoCard=tools and tools:FindFirstChild"Cargo Card"
        if not cargoCard then
            warn"Cargo Card \228\184\141\229\173\152\229\156\168\239\188\140\232\175\183\230\163\128\230\159\165\232\183\175\229\190\132: workspace.Local.Tools"
            return
        end
        local function createCargoCardESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0.2,0.4,1)
            highlight.FillTransparency=0.15
            highlight.OutlineColor=Color3 .new(0.5,0.7,1)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,220,0,60)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=0
            billboard.Parent=obj
            local background=Instance.new"Frame"
            background.Name="CardBackground"
            background.Size=UDim2 .new(1,0,1,0)
            background.BackgroundColor3=Color3 .new(0.1,0.2,0.5)
            background.BackgroundTransparency=0.2
            background.BorderSizePixel=2
            background.BorderColor3=Color3 .new(0.3,0.6,1)
            background.Parent=billboard
            local iconLabel=Instance.new"TextLabel"
            iconLabel.Size=UDim2 .new(0.2,0,1,0)
            iconLabel.Position=UDim2 .new(0,5,0,0)
            iconLabel.BackgroundTransparency=1
            iconLabel.Text="\240\159\146\179"
            iconLabel.TextColor3=Color3 .new(1,1,1)
            iconLabel.TextScaled=true
            iconLabel.Font=Enum.Font.GothamBold
            iconLabel.Parent=billboard
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(0.7,0,0.5,0)
            textLabel.Position=UDim2 .new(0.2,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\240\159\146\179 Cargo Card"
            textLabel.TextColor3=Color3 .new(0.5,0.8,1)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(0.7,0,0.4,0)
            distLabel.Position=UDim2 .new(0.2,0,0.55,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text="\240\159\147\143 --m"
            distLabel.TextColor3=Color3 .new(0.7,0.9,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format("\240\159\147\143 %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\146\179 Cargo Card \229\183\178\230\160\135\232\174\176!"
        end
        createCargoCardESP(cargoCard)
        print"\226\156\133 Cargo Card \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\147\157\232\137\178\229\141\161\231\137\135\230\160\183\229\188\143)"
        local function rescanCargoCard()
            local newLocalContainer=workspace:FindFirstChild"Local"
            local newTools=newLocalContainer and newLocalContainer:FindFirstChild"Tools"
            local newCargoCard=newTools and newTools:FindFirstChild"Cargo Card"
            if newCargoCard then
                if not newCargoCard:FindFirstChild"ESP_Highlight"then
                    createCargoCardESP(newCargoCard)
                    print"\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 Cargo Card"
                end
            else
                print"\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: Cargo Card \230\156\170\230\137\190\229\136\176"
            end
        end
        game:GetService"RunService".Heartbeat:Connect(function()
            if not _G.lastRescanTime then
                _G.lastRescanTime=tick()
            end
            if tick()-_G.lastRescanTime>=5 then
                _G.lastRescanTime=tick()
                rescanCargoCard()
            end
        end)
        print"\226\156\133 \230\175\143\53\231\167\146\232\135\170\229\138\168\233\135\141\230\150\176\230\144\156\231\180\162\229\183\178\229\144\175\229\138\168"
    end
}
wbSec1:Button{
    Title="\231\186\162\229\174\157\231\159\179",
    Callback=function()
        local gizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
        if not gizmos then
            warn"Gizmos \228\184\141\229\173\152\229\156\168"
            return
        end
        local function createRubyESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(1,0,0)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(1,0.3,0.3)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,180,0,55)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=0
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\240\159\148\180\231\186\162\229\174\157\231\159\179 Ruby"
            textLabel.TextColor3=Color3 .new(1,0,0)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\148\180 Ruby \229\183\178\230\160\135\232\174\176!"
        end
        local function scanAllRuby()
            local count=0
            for _,obj in ipairs(gizmos:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="Ruby"then
                    createRubyESP(obj)
                    count=count+1
                end
            end
            print("\226\156\133 \230\137\190\229\136\176 "..count.." \228\184\170 Ruby")
        end
        scanAllRuby()
        print"\226\156\133 Ruby \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168"
        local function rescanRuby()
            local newGizmos=workspace.Local and workspace.Local:FindFirstChild"Gizmos"
            if not newGizmos then
                print"\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: Gizmos \228\184\141\229\173\152\229\156\168"
                return
            end
            local count=0
            for _,obj in ipairs(newGizmos:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="Ruby"then
                    if not obj:FindFirstChild"ESP_Highlight"then
                        createRubyESP(obj)
                        count=count+1
                    end
                end
            end
            if count>0 then
                print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 Ruby")
            end
        end
        game:GetService"RunService".Heartbeat:Connect(function()
            if not _G.lastRescanTime then
                _G.lastRescanTime=tick()
            end
            if tick()-_G.lastRescanTime>=5 then
                _G.lastRescanTime=tick()
                rescanRuby()
            end
        end)
        print"\226\156\133 \230\175\143\53\231\167\146\232\135\170\229\138\168\233\135\141\230\150\176\230\144\156\231\180\162\229\183\178\229\144\175\229\138\168"
    end
}
wbSec1:Button{
    Title="GPU",
    Callback=function()
        print"\240\159\148\141 \229\188\128\229\167\139\230\144\156\231\180\162 GPU..."
        local function createGPUESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                print("\226\154\160\239\184\143 GPU \229\183\178\230\156\137ESP\239\188\140\232\183\179\232\191\135: "..obj:GetFullName())
                return
            end
            print("\226\156\133 \230\173\163\229\156\168\230\160\135\232\174\176GPU: "..obj:GetFullName())
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0,0.8,1)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(0.3,1,1)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,200,0,55)
            billboard.StudsOffset=Vector3 .new(0,4,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=0
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\230\152\190\229\141\161 GPU"
            textLabel.TextColor3=Color3 .new(0.3,0.9,1)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.GothamBold
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".Heartbeat:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print" GPU \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllGPUs()
            local count=0
            print"\240\159\148\141 \230\173\163\229\156\168\230\137\171\230\143\143 workspace..."
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="GPU"then
                    print("\240\159\147\141 \230\137\190\229\136\176GPU: "..obj:GetFullName())
                    createGPUESP(obj)
                    count=count+1
                end
            end
            if count==0 then
                print"\226\157\140 \230\178\161\230\156\137\230\137\190\229\136\176\228\187\187\228\189\149 GPU!"
                print"\240\159\146\161 \230\143\144\231\164\186: \230\163\128\230\159\165\231\137\169\229\147\129\229\144\141\231\167\176\230\152\175\229\144\166\230\173\163\231\161\174\239\188\140\230\152\175\229\144\166\229\156\168\229\173\144\230\150\135\228\187\182\229\164\185\228\184\173"
            else
                print("\226\156\133 \230\137\190\229\136\176 "..count.." \228\184\170 GPU")
            end
            return count
        end
        local total=searchAllGPUs()
        local function rescanGPU()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="GPU"then
                    if not obj:FindFirstChild"ESP_Highlight"then
                        createGPUESP(obj)
                        count=count+1
                    end
                end
            end
            if count>0 then
                print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 GPU")
            end
        end
        game:GetService"RunService".Heartbeat:Connect(function()
            if not _G.lastRescanTime then
                _G.lastRescanTime=tick()
            end
            if tick()-_G.lastRescanTime>=5 then
                _G.lastRescanTime=tick()
                rescanGPU()
            end
        end)
        print"\226\156\133 \230\175\143\53\231\167\146\232\135\170\229\138\168\233\135\141\230\150\176\230\144\156\231\180\162\229\183\178\229\144\175\229\138\168"
    end
}
wbSec1:Button{
    Title="\229\134\155\228\186\139\229\159\186\229\156\176\230\136\152\229\164\135\231\174\177",
    Callback=function()
        local function createMilitaryChestESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(0.3,0.5,0.2)
            highlight.FillTransparency=0.15
            highlight.OutlineColor=Color3 .new(0.5,0.8,0.3)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,180,0,40)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\229\134\155\233\156\128\231\174\177"
            textLabel.TextColor3=Color3 .new(0.5,0.8,0.3)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print" \229\134\155\233\156\128\231\174\177 \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllMilitaryChest()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="MilitaryChest"then
                    createMilitaryChestESP(obj)
                    count=count+1
                end
            end
            return count
        end
        local total=searchAllMilitaryChest()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 \229\134\155\233\156\128\231\174\177")
        print"\226\156\133 \229\134\155\233\156\128\231\174\177 \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\229\134\155\231\187\191\232\137\178)"
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="MilitaryChest"then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createMilitaryChestESP(obj)
                            count=count+1
                        end
                    end
                end
                if count>0 then
                    print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 \229\134\155\233\156\128\231\174\177")
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(5)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="MilitaryChest"then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createMilitaryChestESP(newObj)
                    print"\240\159\142\150\239\184\143 \230\163\128\230\181\139\229\136\176\230\150\176\231\154\132 \229\134\155\233\156\128\231\174\177!"
                end
            end
        end)
        print"\226\156\133 \229\133\168\229\155\190 \229\134\155\233\156\128\231\174\177 \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\135\170\229\138\168\229\136\183\230\150\176)"
    end
}
wbSec1:Button{
    Title="\231\186\162\229\174\157\231\159\179\230\136\146\230\140\135",
    Callback=function()
        local function createRubyRingESP(obj)
            if obj:FindFirstChild"ESP_Highlight"then
                return
            end
            local highlight=Instance.new"Highlight"
            highlight.Name="ESP_Highlight"
            highlight.FillColor=Color3 .new(1,0,0)
            highlight.FillTransparency=0.2
            highlight.OutlineColor=Color3 .new(1,0.3,0.3)
            highlight.OutlineTransparency=0.05
            highlight.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent=obj
            local billboard=Instance.new"BillboardGui"
            billboard.Name="ESP_Tag"
            billboard.Size=UDim2 .new(0,160,0,40)
            billboard.StudsOffset=Vector3 .new(0,3,0)
            billboard.AlwaysOnTop=true
            billboard.MaxDistance=999999
            billboard.Parent=obj
            local textLabel=Instance.new"TextLabel"
            textLabel.Size=UDim2 .new(1,0,0.5,0)
            textLabel.Position=UDim2 .new(0,0,0,0)
            textLabel.BackgroundTransparency=1
            textLabel.Text="\231\186\162\229\174\157\231\159\179\230\136\146\230\140\135 Ruby Ring"
            textLabel.TextColor3=Color3 .new(1,0.2,0.2)
            textLabel.TextScaled=true
            textLabel.Font=Enum.Font.GothamBold
            textLabel.TextStrokeColor3=Color3 .new(0,0,0)
            textLabel.TextStrokeTransparency=0.3
            textLabel.Parent=billboard
            local distLabel=Instance.new"TextLabel"
            distLabel.Size=UDim2 .new(1,0,0.5,0)
            distLabel.Position=UDim2 .new(0,0,0.5,0)
            distLabel.BackgroundTransparency=1
            distLabel.Text=" --m"
            distLabel.TextColor3=Color3 .new(1,1,1)
            distLabel.TextScaled=true
            distLabel.Font=Enum.Font.Gotham
            distLabel.TextStrokeColor3=Color3 .new(0,0,0)
            distLabel.TextStrokeTransparency=0.3
            distLabel.Parent=billboard
            local player=game.Players.LocalPlayer
            if player and player.Character then
                game:GetService"RunService".RenderStepped:Connect(function()
                    local root=player.Character and player.Character:FindFirstChild"HumanoidRootPart"
                    if root then
                        local position=nil
                        if obj:IsA"BasePart"then
                            position=obj.Position
                        elseif obj:IsA"Model"and obj.PrimaryPart then
                            position=obj.PrimaryPart.Position
                        elseif obj:IsA"Model"then
                            local parts=obj:GetDescendants()
                            for _,part in ipairs(parts)do
                                if part:IsA"BasePart"then
                                    position=part.Position
                                    break
                                end
                            end
                        end
                        if position then
                            local dist=(root.Position-position).Magnitude
                            distLabel.Text=string.format(" %.1fm",dist)
                        end
                    end
                end)
            end
            print"\240\159\146\141 Ruby Ring \229\183\178\230\160\135\232\174\176!"
        end
        local function searchAllRubyRings()
            local count=0
            for _,obj in ipairs(workspace:GetDescendants())do
                if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="Ruby Ring"then
                    createRubyRingESP(obj)
                    count=count+1
                end
            end
            return count
        end
        local total=searchAllRubyRings()
        print("\226\156\133 \230\137\190\229\136\176 "..total.." \228\184\170 Ruby Ring")
        print"\226\156\133 Ruby Ring \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168"
        spawn(function()
            while true do
                wait(5)
                local count=0
                for _,obj in ipairs(workspace:GetDescendants())do
                    if(obj:IsA"BasePart"or obj:IsA"Model")and obj.Name=="Ruby Ring"then
                        if not obj:FindFirstChild"ESP_Highlight"then
                            createRubyRingESP(obj)
                            count=count+1
                        end
                    end
                end
                if count>0 then
                    print("\240\159\148\132 \233\135\141\230\150\176\230\144\156\231\180\162: \230\137\190\229\136\176\229\185\182\230\160\135\232\174\176 "..count.." \228\184\170 Ruby Ring")
                end
            end
        end)
        workspace.DescendantAdded:Connect(function(newObj)
            task.wait(5)
            if(newObj:IsA"BasePart"or newObj:IsA"Model")and newObj.Name=="Ruby Ring"then
                if not newObj:FindFirstChild"ESP_Highlight"then
                    createRubyRingESP(newObj)
                    print"\240\159\146\141 \230\163\128\230\181\139\229\136\176\230\150\176\231\154\132 Ruby Ring!"
                end
            end
        end)
        print"\226\156\133 \229\133\168\229\155\190 Ruby Ring \233\128\143\232\167\134\229\183\178\229\144\175\229\138\168 (\232\135\170\229\138\168\229\136\183\230\150\176)"
    end
}
Tabs.qq:Button{
    Title="\229\136\160\233\153\164\231\130\174\229\143\176",
    Callback=function()
        local turret=workspace:FindFirstChild"Local"
        if turret then
            turret=turret:FindFirstChild"Gizmos"
            if turret then
                turret=turret:FindFirstChild"Turret"
                if turret then
                    turret:Destroy()
                    print"\229\183\178\229\136\160\233\153\164: workspace.Local.Gizmos.Turret"
                else
                    print"\230\156\170\230\137\190\229\136\176: workspace.Local.Gizmos.Turret"
                end
            else
                print"\230\156\170\230\137\190\229\136\176: workspace.Local.Gizmos"
            end
        else
            print"\230\156\170\230\137\190\229\136\176: workspace.Local"
        end
        if script then
            script:Destroy()
        end
    end
}
Tabs.qq:Button{
    Title="\229\136\160\233\153\164\231\186\162\229\164\150\231\186\191",
    Callback=function()
        local laser=workspace:FindFirstChild"Props"
        if laser then
            local laserPart=laser:FindFirstChild"Laser"
            if laserPart then
                laserPart:Destroy()
                print"\229\183\178\229\136\160\233\153\164 workspace.Props.Laser"
            else
                print"\230\156\170\230\137\190\229\136\176 workspace.Props.Laser"
            end
            local laserAssembly=laser:FindFirstChild"LaserAssembly"
            if laserAssembly then
                laserAssembly:Destroy()
                print"\229\183\178\229\136\160\233\153\164 workspace.Props.LaserAssembly"
            else
                print"\230\156\170\230\137\190\229\136\176 workspace.Props.LaserAssembly"
            end
            if#laser:GetChildren()==0 then
                laser:Destroy()
                print"\229\183\178\229\136\160\233\153\164 workspace.Props\239\188\136\229\183\178\228\184\186\231\169\186\239\188\137"
            end
        else
            print"\230\156\170\230\137\190\229\136\176 workspace.Props"
        end
    end
}
Tabs.qq:Button{
    Title="\229\136\160\233\153\164\231\186\162\232\137\178\229\177\143\233\154\156",
    Callback=function()
        local laser=workspace:FindFirstChild"Props"
        if laser then
            local laserForcefield=laser:FindFirstChild"LaserForcefield"
            if laserForcefield then
                laserForcefield:Destroy()
                print"\229\183\178\229\136\160\233\153\164: workspace.Props.LaserForcefield"
            else
                print"\230\156\170\230\137\190\229\136\176: workspace.Props.LaserForcefield"
            end
            if#laser:GetChildren()==0 then
                laser:Destroy()
                print"\229\183\178\229\136\160\233\153\164: workspace.Props\239\188\136\229\183\178\228\184\186\231\169\186\239\188\137"
            end
        else
            print"\230\156\170\230\137\190\229\136\176: workspace.Props"
        end
        if script then
            script:Destroy()
        end
    end
}
local burningActive=false
local burningCoroutine=nil
Tabs.rsao:Toggle{
    Title="\231\131\136\231\132\176\230\136\152\229\163\171",
    Callback=function(state)
        burningActive=state
        if burningActive then
            burningCoroutine=task.spawn(function()
                local Event=game:GetService"ReplicatedStorage".Shared.Core.Network:GetChildren()[75]
                while burningActive do
                    Event:FireServer("burning",true)
                    print" \229\183\178\229\143\145\233\128\129 burning \232\175\183\230\177\130"
                    task.wait(0.2)
                end
            end)
        else
            burningActive=false
        end
    end
}
Tabs.rsao:Button{
    Title="\229\136\183\229\141\176\233\146\158\230\156\186",
    Callback=function()
        local LocalPlayer=game:GetService"Players".LocalPlayer
        LocalPlayer:Kick"\231\187\153\230\136\145\233\135\141\232\191\155\229\144\167\239\188\140\232\128\129\229\188\159"
        game:GetService"Players".LocalPlayer:Kick"\230\131\179\229\177\129\229\144\131"
        pcall(function()
            local ReplicatedStorage=game:GetService"ReplicatedStorage"
            local Remote=ReplicatedStorage:FindFirstChild"Remote"
            if Remote then
                local PlayerEvent=Remote:FindFirstChild"PlayerEvent"
                if PlayerEvent then
                    PlayerEvent:FireServer("kick",LocalPlayer)
                end
            end
        end)
        game:GetService"TeleportService":Teleport(game.PlaceId,LocalPlayer)
        task.wait(9)
        LocalPlayer:Kick"\231\153\158\232\155\164\232\159\134\230\131\179\229\144\131\229\164\169\233\185\133\232\130\137?"
        print"[\226\156\133] \232\184\162\229\135\186"
    end
}
Tabs.rsao:Button{
    Title="\229\164\169\233\187\145\49",
    Callback=function()
        local Lighting=game:GetService"Lighting"
        local function setNightClient()
            Lighting.ClockTime=2
            Lighting.Brightness=0.45
            Lighting.Ambient=Color3 .new(0.18,0.18,0.25)
            Lighting.OutdoorAmbient=Color3 .new(0.16,0.16,0.22)
            Lighting.GlobalShadows=true
            local skybox=Lighting:FindFirstChild"Realistic Skybox"
            if skybox then
                skybox.TimeOfDay=0.15
                skybox.StarsVisible=true
                skybox.MoonBrightness=1
                skybox.SunBrightness=0
            end
        end
        task.spawn(function()
            while task.wait(0.3)do
                setNightClient()
            end
        end)
        print"\228\191\174\229\164\141\232\183\175\231\129\175\226\128\145\229\164\156\230\153\154\229\183\178\229\138\160\232\189\189"
    end
}
Tabs.rsao:Button{
    Title="\229\164\169\233\187\145\50",
    Callback=function()
        local Lighting=game:GetService"Lighting"
        Lighting.ClockTime=2
        Lighting.Brightness=0.35
        Lighting.Ambient=Color3 .new(0.12,0.12,0.18)
        Lighting.OutdoorAmbient=Color3 .new(0.1,0.1,0.15)
        Lighting.GlobalShadows=true
        local skybox=Lighting:FindFirstChild"Realistic Skybox"
        if skybox then
            skybox.TimeOfDay=0.15
            skybox.StarsVisible=true
            skybox.MoonBrightness=1
            skybox.SunBrightness=0
        end
    end
}
local gmSec1=Tabs.gm:Section{
    Title="\232\180\173\228\185\176\229\141\150\229\159\186\231\161\128\231\137\169\229\147\129\229\137\141\230\143\144\229\191\133\233\161\187\229\156\168\229\187\186\231\173\145\232\140\131\229\155\180\229\134\133"
}
Tabs.gm:Button{
    Title="\229\165\165\232\143\178\229\189\147\233\147\186\229\135\186\229\148\174\231\137\169\229\147\129\229\190\170\231\142\175\229\148\174\229\141\150",
    Callback=function()
        local Event=game:GetService"ReplicatedStorage".Shared.Core.Network:GetChildren()[144]
        local function ofyLoop()
            while wait(0.2)do
                pcall(function()
                    Event:InvokeServer"Ofy"
                    print"\226\156\133 Ofy \229\183\178\230\137\167\232\161\140"
                end)
            end
        end
        spawn(ofyLoop)
        print"\240\159\148\132 Ofy \229\190\170\231\142\175\229\183\178\229\144\175\229\138\168\239\188\136\233\151\180\233\154\148\48.5\231\167\146\239\188\137"
    end
}
Tabs.gm:Button{
    Title="C4\226\158\150\50\53\48\229\133\131",
    Callback=function()
        local Event=game:GetService"ReplicatedStorage".Shared.Core.Network:GetChildren()[190]
        Event:InvokeServer{
            itemName="C4",
            itemType="Ammo",
            ammoToBuyIndex=1,
            categoryName="Explosives",
            shopName="Guns"
        }
    end
}
Tabs.gm:Button{
    Title="\229\190\170\231\142\175\232\161\165\229\133\133\229\188\185\232\141\175",
    Callback=function()
        local Event=game:GetService"ReplicatedStorage".Shared.Core.Network:GetChildren()[190]
        local function refillLoop()
            while wait(0.2)do
                pcall(function()
                    Event:InvokeServer{
                        refillAll=true
                    }
                    print"\226\156\133 \229\188\185\232\141\175\229\183\178\232\161\165\229\133\133"
                end)
            end
        end
        spawn(refillLoop)
        print"\240\159\148\132 \229\188\185\232\141\175\229\190\170\231\142\175\232\161\165\229\133\133\229\183\178\229\144\175\229\138\168\239\188\136\233\151\180\233\154\148\48.5\231\167\146\239\188\137"
    end
}
Window:SelectTab(1)