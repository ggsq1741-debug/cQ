local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local Players          = game:GetService("Players")
local LocalPlayer      = Players.LocalPlayer

-- ★ 两张图片（想换就改这两行）
local IMAGES = {
    "rbxassetid://85014544918798",          
    "rbxassetid://87937284505348", 
}
local currentIndex = 1

-- ============================================================
-- 容器
-- ============================================================
local gui = Instance.new("ScreenGui")
gui.Name = "DraggableImage"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 9999999

local parented = false
pcall(function()
    if gethui then gui.Parent = gethui() parented = true end
end)
if not parented then
    pcall(function() gui.Parent = game:GetService("CoreGui") parented = true end)
end
if not parented then
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- ============================================================
-- 图片
-- ============================================================
local img = Instance.new("ImageLabel")
img.Name = "Image"
img.BackgroundTransparency = 1
img.ScaleType = Enum.ScaleType.Fit
img.Image = IMAGES[currentIndex]
img.Size = UDim2.fromScale(0.28, 0.20)
img.AnchorPoint = Vector2.new(0.5, 0.5)
img.Position = UDim2.new(0.5, 0, 0.5, 0)
img.Active = true
img.Parent = gui

local BASE_SIZE = img.Size

-- ============================================================
-- 拖动 + 点击切换 + 回弹
-- ============================================================
local dragging  = false
local dragStart = nil
local startPos  = nil
local moved     = false
local MOVE_THRESHOLD = 6

local function switchImage()
    currentIndex = currentIndex == 1 and 2 or 1
    img.Image = IMAGES[currentIndex]
end

img.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging  = true
        moved     = false
        dragStart = Vector2.new(input.Position.X, input.Position.Y)
        startPos  = img.Position

        -- 按下缩小
        TweenService:Create(img, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
            Size = UDim2.fromScale(BASE_SIZE.X.Scale * 0.85, BASE_SIZE.Y.Scale * 0.85)
        }):Play()
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        local cur   = Vector2.new(input.Position.X, input.Position.Y)
        local delta = cur - dragStart

        if delta.Magnitude > MOVE_THRESHOLD then
            moved = true
        end

        img.Position = UDim2.new(
            startPos.X.Scale,  startPos.X.Offset + delta.X,
            startPos.Y.Scale,  startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false

        -- 回弹动画
        TweenService:Create(img, TweenInfo.new(
            0.3,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ), {
            Size = BASE_SIZE
        }):Play()

        -- 没怎么移动 = 点击 → 切换图片
        if not moved then
            switchImage()
        end
    end
end)