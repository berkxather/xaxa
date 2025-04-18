-- Fluent Library Setup
local Fluent = loadstring(game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

local Window = Fluent:CreateWindow({
    Title = "Xather Cheat",
    SubTitle = "by Hezli Meymun",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftAlt
})

local Tabs = {
    Aim = Window:AddTab({ Title = "Aim", Icon = "target" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
    Gun = Window:AddTab({ Title = "Gun", Icon = "crosshair" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

-- Variables
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Holding = false

_G.AimbotEnabled = false
_G.TeamCheck = false
_G.AimPart = "Head"
_G.Sensitivity = 0.1
_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 0.7
_G.CircleRadius = 80
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 0

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

-- Aimbot Settings Menu
Tabs.Aim:AddToggle("AimbotToggle", {
    Title = "Aimbot",
    Description = "Aimbot'u etkinleştir",
    Default = _G.AimbotEnabled,
    Callback = function(state)
        _G.AimbotEnabled = state
    end
})

Tabs.Aim:AddToggle("TeamCheck", {
    Title = "Takım Kontrolü",
    Description = "Sadece düşman oyuncularına kilitlen",
    Default = _G.TeamCheck,
    Callback = function(state)
        _G.TeamCheck = state
    end
})

-- AimPart Dropdown (Parçayı Seçme)
Tabs.Aim:AddDropdown("AimPart", {
    Title = "Kilitlenme Noktası",
    Default = _G.AimPart,
    Options = {"Head", "Torso", "LeftLeg", "RightLeg", "LeftArm", "RightArm", "HumanoidRootPart"},
    Callback = function(value)
        _G.AimPart = value
    end
})

Tabs.Aim:AddSlider("Sensitivity", {
    Title = "Hassasiyet",
    Description = "Aimbot hassasiyetini ayarlayın",
    Default = _G.Sensitivity,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(value)
        _G.Sensitivity = value
    end
})

Tabs.Aim:AddSlider("CircleRadius", {
    Title = "FOV Çevresi",
    Description = "FOV çemberinin çapını ayarlayın",
    Default = _G.CircleRadius,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Callback = function(value)
        _G.CircleRadius = value
    end
})

-- Get Closest Player
local function GetClosestPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target = nil

    for _, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name then
            if _G.TeamCheck == true then
                if v.Team ~= LocalPlayer.Team then
                    if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                        local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                        if VectorDistance < MaximumDistance then
                            Target = v
                        end
                    end
                end
            else
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local ScreenPoint = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                    local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                    if VectorDistance < MaximumDistance then
                        Target = v
                    end
                end
            end
        end
    end
    return Target
end

-- Aimbot Implementation
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    if Holding and _G.AimbotEnabled then
        local closestPlayer = GetClosestPlayer()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild(_G.AimPart) then
            local targetPosition = closestPlayer.Character[_G.AimPart].Position
            local cameraToTarget = CFrame.new(Camera.CFrame.Position, targetPosition)
            TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = cameraToTarget}):Play()
        end
    end
end)

-- Input Handling for Aimbot (Right Click)
UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)
