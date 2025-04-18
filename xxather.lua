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

-- Değişkenler
local aimbotEnabled = false
local lockOnPoint = "Head"
local ignoreTeam = false
local lockKey = Enum.KeyCode.F
local lockOnKeyEnabled = false
local noRecoilEnabled = false
local noSpreadEnabled = false
local boxESPEnabled = false
local skeletonESPEnabled = false
local healthESPEnabled = false
local nameESPEnabled = false
local distanceESPEnabled = false
local radarHackEnabled = false
local bhopEnabled = false
local godModeEnabled = false

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local mouse = player:GetMouse()

-- Aimbot Fonksiyonu
local function Aimbot()
    if aimbotEnabled then
        local closestTarget = nil
        local closestDistance = math.huge

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

        if closestTarget then
            local targetPosition
            if lockOnPoint == "Head" then
                targetPosition = closestTarget.Character.Head
            elseif lockOnPoint == "Chest" then
                targetPosition = closestTarget.Character.Torso
            elseif lockOnPoint == "Legs" then
                targetPosition = closestTarget.Character.LowerTorso
            end
            if targetPosition then
                local screenPos = camera:WorldToScreenPoint(targetPosition.Position)
                mouse.X = screenPos.X
                mouse.Y = screenPos.Y
            end
        end
    end
end

-- Aimbot'un kontrolü
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == lockKey and lockOnKeyEnabled then
        aimbotEnabled = true
        Aimbot()
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.KeyCode == lockKey then
        aimbotEnabled = false
    end
end)

-- ESP Fonksiyonları
local function DrawESP(target)
    if boxESPEnabled then
        local box = Instance.new("Frame")
        box.Size = UDim2.new(0, 100, 0, 100)
        box.Position = UDim2.new(0, target.HumanoidRootPart.Position.X, 0, target.HumanoidRootPart.Position.Y)
        box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        box.Parent = game.CoreGui
    end

    if skeletonESPEnabled then
        -- Skeleton ESP işlevselliği buraya eklenebilir
    end

    if healthESPEnabled then
        local healthBar = Instance.new("Frame")
        healthBar.Size = UDim2.new(0, 100, 0, 10)
        healthBar.Position = UDim2.new(0, target.HumanoidRootPart.Position.X, 0, target.HumanoidRootPart.Position.Y)
        healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        healthBar.Parent = game.CoreGui
    end

    if nameESPEnabled then
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Text = target.Name
        nameLabel.Position = UDim2.new(0, target.HumanoidRootPart.Position.X, 0, target.HumanoidRootPart.Position.Y)
        nameLabel.Parent = game.CoreGui
    end

    if distanceESPEnabled then
        local distanceLabel = Instance.new("TextLabel")
        local distance = (game.Workspace.CurrentCamera.CFrame.Position - target.HumanoidRootPart.Position).Magnitude
        distanceLabel.Text = math.floor(distance) .. "m"
        distanceLabel.Position = UDim2.new(0, target.HumanoidRootPart.Position.X, 0, target.HumanoidRootPart.Position.Y)
        distanceLabel.Parent = game.CoreGui
    end
end

-- ESP Aktifleştirme
function SetESP(state)
    if state then
        for _, target in pairs(game.Players:GetPlayers()) do
            if target.Character then
                DrawESP(target.Character)
            end
        end
    end
end

-- No Recoil Fonksiyonu
function NoRecoil()
    if noRecoilEnabled then
        -- Geri tepme sıfırlama işlevselliği burada olmalı
    end
end

-- No Spread Fonksiyonu
function NoSpread()
    if noSpreadEnabled then
        -- Mermi yayılmasını engelleme işlevselliği burada olmalı
    end
end

-- Bhop Fonksiyonu
function Bhop()
    if bhopEnabled then
        -- Bunny hop fonksiyonu burada olmalı
    end
end

-- God Mode Fonksiyonu
function GodMode()
    if godModeEnabled then
        -- God mode fonksiyonu burada olmalı
    end
end

-- Menüye Aimbot Toggle Ekleme
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
        -- FOV ayarını burada yapabilirsiniz
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

Tabs.Aim:AddToggle("WallProtection", {
    Title = "Wall Protection",
    Description = "Duvar arkasında kilitlenmeyi engelle",
    Default = false,
    Callback = function(state)
        -- Wall protection fonksiyonunu burada etkinleştirebilirsiniz
    end
})

Tabs.Aim:AddToggle("IgnoreTeam", {
    Title = "Takım Arkadaşlarını Görmezden Gel",
    Description = "Takım arkadaşlarına kilitlenmeyi engelle",
    Default = false,
    Callback = function(state)
        ignoreTeam = state
    end
})

Tabs.Aim:AddToggle("DrawFOV", {
    Title = "FOV Çizimini Göster",
    Description = "FOV çizimi ekranda görünür olacak",
    Default = false,
    Callback = function(state)
        -- FOV çizimini burada gösterebilirsiniz
    end
})

Tabs.Aim:AddTextbox("LockOnKey", {
    Title = "Kilitlenme Düğmesi",
    Default = "Shift",
    Callback = function(value)
        lockKey = Enum.KeyCode[value] or Enum.KeyCode.F
    end
})

-- ESP Sekmesi
Tabs.ESP:AddToggle("BoxESP", {
    Title = "Box ESP",
    Description = "Düşmanları kutu şeklinde göster",
    Default = false,
    Callback = function(state)
        boxESPEnabled = state
        SetESP(state)
    end
})

Tabs.ESP:AddToggle("SkeletonESP", {
    Title = "Skeleton ESP",
    Description = "Düşmanların iskeletini göster",
    Default = false,
    Callback = function(state)
        skeletonESPEnabled = state
        SetESP(state)
    end
})

Tabs.ESP:AddToggle("HealthESP", {
    Title = "Health ESP",
    Description = "Düşmanların canını göster",
    Default = false,
    Callback = function(state)
        healthESPEnabled = state
        SetESP(state)
    end
})

Tabs.ESP:AddToggle("NameESP", {
    Title = "Name ESP",
    Description = "Düşmanların isimlerini göster",
    Default = false,
    Callback = function(state)
        nameESPEnabled = state
        SetESP(state)
    end
})

Tabs.ESP:AddToggle("EnableESP", {
    Title = "Enable ESP",
    Description = "Tüm ESP'yi etkinleştir/etkisizleştir",
    Default = false,
    Callback = function(state)
        boxESPEnabled = state
        skeletonESPEnabled = state
        healthESPEnabled = state
        nameESPEnabled = state
        SetESP(state)
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

-- Misc Sekmesi
Tabs.Misc:AddToggle("Bhop", {
    Title = "Bunny Hop",
    Description = "Bunny hop'u etkinleştir",
    Default = false,
    Callback = function(state)
        bhopEnabled = state
    end
})

Tabs.Misc:AddToggle("GodMode", {
    Title = "God Mode",
    Description = "Ölümsüzlük etkinleştir",
    Default = false,
    Callback = function(state)
        godModeEnabled = state
    end
})
