-- VapeV4 Kütüphanesi yükleme
local VapeV4 = loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeV4/VapeV4/master/Source/Loader.lua"))()

-- Kamera, oyuncu, servisleri tanımla
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Ayarlar
_G.AimbotEnabled = true
_G.TeamCheck = false
_G.AimPart = "Head"
_G.Sensitivity = 0.1 -- 0.1 saniyede kilitlenme
_G.CircleRadius = 80
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 0.7
_G.CircleVisible = true
_G.CircleThickness = 1

local Holding = false

-- FOV Circle tanımlaması
local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = false
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.Thickness = _G.CircleThickness

-- En yakın düşmanı bulma fonksiyonu
local function GetClosestPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target = nil

    for _, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name then
            if _G.TeamCheck and v.Team ~= LocalPlayer.Team then
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                        local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                        if VectorDistance < MaximumDistance then
                            Target = v
                        end
                    end
                end
            elseif not _G.TeamCheck then
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    if v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                        local ScreenPoint = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                        local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
                        if VectorDistance < MaximumDistance then
                            Target = v
                        end
                    end
                end
            end
        end
    end

    return Target
end

-- Mouse tuşuna basıldığında hedefe kilitlenme
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

-- Menü ve Aimbot ayarları için VapeV4 menüsünü oluşturma
local MainMenu = VapeV4.NewMenu("Aimbot Menu")

-- Aimbot sekmesi
local AimbotTab = MainMenu:AddTab("Aimbot")
AimbotTab:AddToggle("Aimbot Enabled", function(value)
    _G.AimbotEnabled = value
end, _G.AimbotEnabled)

AimbotTab:AddToggle("Team Check", function(value)
    _G.TeamCheck = value
end, _G.TeamCheck)

AimbotTab:AddDropdown("Aim Part", {"Head", "Torso", "HumanoidRootPart"}, function(value)
    _G.AimPart = value
end, _G.AimPart)

AimbotTab:AddSlider("Sensitivity", 0, 1, function(value)
    _G.Sensitivity = value
end, _G.Sensitivity)

AimbotTab:AddColorPicker("FOV Circle Color", function(color)
    _G.CircleColor = color
    FOVCircle.Color = color
end, _G.CircleColor)

-- FOV Circle sekmesi
local VisualTab = MainMenu:AddTab("Visuals")
VisualTab:AddSlider("FOV Circle Radius", 20, 200, function(value)
    _G.CircleRadius = value
    FOVCircle.Radius = value
end, _G.CircleRadius)

VisualTab:AddToggle("FOV Circle Visible", function(value)
    _G.CircleVisible = value
    FOVCircle.Visible = value
end, _G.CircleVisible)

-- Render işlemi
RunService.RenderStepped:Connect(function()
    if _G.AimbotEnabled and Holding then
        local Target = GetClosestPlayer()
        if Target then
            TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, Target.Character[_G.AimPart].Position)}):Play()
        end
    end
end)

-- Menü açma
MainMenu:Show()
