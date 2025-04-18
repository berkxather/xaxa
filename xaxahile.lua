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

-- Hileleri Tanımlama

-- Aimbot
local aimbotEnabled = false
local lockOnPoint = "Head"  -- Baş, Göğüs, Bacak
local lockKey = Enum.KeyCode.F -- Kilitlenme tuşu

-- FOV Çizimi
local drawFOV = false
local FOVRadius = 90

-- ESP
local boxESPEnabled = false
local nameESPEnabled = false
local healthESPEnabled = false

-- Silah
local noRecoilEnabled = false
local noSpreadEnabled = false
local noSmokeEnabled = false
local infiniteAmmoEnabled = false

-- Misc
local radarHackEnabled = false
local bhopEnabled = false
local godModeEnabled = false

-- Aimbot Sekmesi
Tabs.Aim:AddToggle("AimbotToggle", {
    Title = "Aimbot",
    Description = "Aimbot'u etkinleştir",
    Default = false,
    Callback = function(state)
        aimbotEnabled = state
    end
})

Tabs.Aim:AddSlider("FOVSlider", {
    Title = "FOV",
    Description = "Aimbot görüş açısı",
    Default = 90,
    Min = 10,
    Max = 180,
    Rounding = 0,
    Callback = function(value)
        FOVRadius = value
    end
})

Tabs.Aim:AddDropdown("LockOnPoint", {
    Title = "Kilitlenme Noktası",
    Default = "Head",
    Options = {"Head", "Chest", "Legs"},
    Callback = function(value)
        lockOnPoint = value
    end
})

-- ESP Sekmesi
Tabs.ESP:AddToggle("BoxESP", {
    Title = "Box ESP",
    Description = "Düşmanları kutu şeklinde göster",
    Default = false,
    Callback = function(state)
        boxESPEnabled = state
    end
})

Tabs.ESP:AddToggle("NameESP", {
    Title = "Name ESP",
    Description = "Düşmanların isimlerini göster",
    Default = false,
    Callback = function(state)
        nameESPEnabled = state
    end
})

Tabs.ESP:AddToggle("HealthESP", {
    Title = "Health ESP",
    Description = "Düşmanların canını göster",
    Default = false,
    Callback = function(state)
        healthESPEnabled = state
    end
})

-- Gun Sekmesi
Tabs.Gun:AddToggle("NoRecoil", {
    Title = "No Recoil",
    Description = "Silah geri tepmesini kaldır",
    Default = false,
    Callback = function(state)
        noRecoilEnabled = state
    end
})

Tabs.Gun:AddToggle("NoSpread", {
    Title = "No Spread",
    Description = "Mermi yayılmasını engelle",
    Default = false,
    Callback = function(state)
        noSpreadEnabled = state
    end
})

Tabs.Gun:AddToggle("NoSmoke", {
    Title = "No Smoke",
    Description = "Dumanı engelle",
    Default = false,
    Callback = function(state)
        noSmokeEnabled = state
    end
})

Tabs.Gun:AddToggle("InfiniteAmmo", {
    Title = "Infinite Ammo",
    Description = "Sonsuz Mermi",
    Default = false,
    Callback = function(state)
        infiniteAmmoEnabled = state
    end
})

-- Misc Sekmesi
Tabs.Misc:AddToggle("RadarHack", {
    Title = "Radar Hack",
    Description = "Düşmanları haritada göster",
    Default = false,
    Callback = function(state)
        radarHackEnabled = state
    end
})

Tabs.Misc:AddToggle("Bhop", {
    Title = "Bhop",
    Description = "Otomatik Zıplama",
    Default = false,
    Callback = function(state)
        bhopEnabled = state
    end
})

Tabs.Misc:AddToggle("GodMode", {
    Title = "God Mode",
    Description = "Ölümsüzlük",
    Default = false,
    Callback = function(state)
        godModeEnabled = state
    end
})

-- Hilelerin Fonksiyonları

-- Aimbot İşlevi
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local mouse = player:GetMouse()

local function AimAt(target)
    local targetPosition = target:FindFirstChild("HumanoidRootPart")
    if targetPosition then
        local screenPos = camera:WorldToScreenPoint(targetPosition.Position)
        mouse.X = screenPos.X
        mouse.Y = screenPos.Y
    end
end

local function Aimbot()
    if aimbotEnabled then
        local closestTarget = nil
        local closestDistance = math.huge

        -- En yakın hedefi bulma
        for _, target in pairs(game.Players:GetPlayers()) do
            if target ~= player and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local targetPosition = target.Character.HumanoidRootPart.Position
                local distance = (camera.CFrame.Position - targetPosition).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestTarget = target
                end
            end
        end

        -- Hedefe kilitlenme
        if closestTarget then
            AimAt(closestTarget)
        end
    end
end

-- ESP İşlevi
local function DrawESP(target)
    if boxESPEnabled then
        -- Box ESP kodları
    end

    if nameESPEnabled then
        -- Name ESP kodları
    end

    if healthESPEnabled then
        -- Health ESP kodları
    end
end

-- No Recoil
local function NoRecoil()
    if noRecoilEnabled then
        -- No recoil işlemi
    end
end

-- No Spread
local function NoSpread()
    if noSpreadEnabled then
        -- No spread işlemi
    end
end

-- Infinite Ammo
local function InfiniteAmmo()
    if infiniteAmmoEnabled then
        -- Sonsuz mermi işlemi
    end
end

-- God Mode
local function GodMode()
    if godModeEnabled then
        -- God mode işlemi
    end
end

-- Bunny Hop
local function Bhop()
    if bhopEnabled then
        -- Otomatik zıplama işlevi
    end
end

-- Radar Hack
local function RadarHack()
    if radarHackEnabled then
        -- Radar hack işlemi
    end
end

-- Oyuncu etkileşimleri
game:GetService("RunService").Heartbeat:Connect(function()
    Aimbot()
    NoRecoil()
    NoSpread()
    InfiniteAmmo()
    GodMode()
    Bhop()
    RadarHack()
end)
