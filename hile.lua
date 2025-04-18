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

-- *** AIM Sekmesi ***
local aimbotEnabled = false
local lockOnPoint = "Head" -- Baş, Göğüs, Bacak
local lockKey = Enum.KeyCode.F -- Kilitlenme tuşu

Tabs.Aim:AddToggle("AimbotToggle", {
    Title = "Aimbot",
    Description = "Aimbot'u etkinleştir",
    Default = false,
    Callback = function(state)
        aimbotEnabled = state
        print("Aimbot durumu:", state)
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
        print("FOV değeri:", value)
        -- FOV ayarlarını burada güncelle
    end
})

Tabs.Aim:AddDropdown("LockOnPoint", {
    Title = "Kilitlenme Noktası",
    Default = "Head",
    Options = {"Head", "Chest", "Legs"},
    Callback = function(value)
        print("Kilitlenme noktası:", value)
        lockOnPoint = value
    end
})

Tabs.Aim:AddTextbox("LockOnKey", {
    Title = "Kilitlenme Düğmesi",
    Default = "Shift",
    Callback = function(value)
        lockKey = Enum.KeyCode[value] or Enum.KeyCode.F
        print("Kilitlenme tuşu:", value)
    end
})

local function Aimbot()
    if aimbotEnabled then
        local closestTarget = nil
        local closestDistance = math.huge
        for _, target in pairs(game.Players:GetPlayers()) do
            if target ~= game.Players.LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (workspace.CurrentCamera.CFrame.Position - target.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestTarget = target
                end
            end
        end
        if closestTarget then
            local targetPosition = closestTarget.Character.HumanoidRootPart.Position
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPosition)
        end
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == lockKey then
        Aimbot()
    end
end)

-- *** ESP Sekmesi ***
local boxESPEnabled = false
local nameESPEnabled = false

Tabs.ESP:AddToggle("BoxESP", {
    Title = "Box ESP",
    Description = "Düşmanları kutu şeklinde göster",
    Default = false,
    Callback = function(state)
        boxESPEnabled = state
        print("Box ESP durumu:", state)
    end
})

Tabs.ESP:AddToggle("NameESP", {
    Title = "Name ESP",
    Description = "Düşmanların isimlerini göster",
    Default = false,
    Callback = function(state)
        nameESPEnabled = state
        print("Name ESP durumu:", state)
    end
})

local function DrawESP(target)
    if boxESPEnabled then
        -- Box ESP kodları
        local box = Instance.new("Frame")
        box.Size = UDim2.new(0, 100, 0, 100) -- 100x100 kutu
        box.Position = UDim2.new(0, target.HumanoidRootPart.Position.X, 0, target.HumanoidRootPart.Position.Y)
        box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Kırmızı kutu
        box.Parent = game.CoreGui
    end

    if nameESPEnabled then
        -- Name ESP kodları
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Text = target.Name
        nameLabel.Position = UDim2.new(0, target.HumanoidRootPart.Position.X, 0, target.HumanoidRootPart.Position.Y)
        nameLabel.Parent = game.CoreGui
    end
end

-- *** GUN Sekmesi ***
local noRecoilEnabled = false

Tabs.Gun:AddToggle("NoRecoil", {
    Title = "No Recoil",
    Description = "Silah geri tepmesini kaldır",
    Default = false,
    Callback = function(state)
        noRecoilEnabled = state
        print("No Recoil durumu:", state)
    end
})

local function NoRecoil()
    if noRecoilEnabled then
        -- Geri tepme engelleme kodları buraya yazılacak
    end
end

-- *** MISC Sekmesi ***
local bhopEnabled = false

Tabs.Misc:AddToggle("Bhop", {
    Title = "Bunny Hop",
    Description = "Otomatik zıplama",
    Default = false,
    Callback = function(state)
        bhopEnabled = state
        print("Bhop durumu:", state)
    end
})

local godModeEnabled = false

Tabs.Misc:AddToggle("GodMode", {
    Title = "God Mode",
    Description = "Ölümsüzlük",
    Default = false,
    Callback = function(state)
        godModeEnabled = state
        print("God Mode durumu:", state)
    end
})

local function GodMode()
    if godModeEnabled then
        -- God mode fonksiyonu buraya yazılacak
    end
end

-- *** TriggerBot ve Diğer Fonksiyonlar ***
local triggerBotEnabled = false

Tabs.Gun:AddToggle("TriggerBot", {
    Title = "TriggerBot",
    Description = "Hedefi gördüğünde otomatik ateş et",
    Default = false,
    Callback = function(state)
        triggerBotEnabled = state
        print("TriggerBot durumu:", state)
    end
})

local function TriggerBot()
    if triggerBotEnabled then
        -- TriggerBot fonksiyonu buraya yazılacak
    end
end

-- *** Otomatik Güncellemeler ve Diğer Ayarlar ***
game:GetService("RunService").Heartbeat:Connect(function()
    if aimbotEnabled then
        Aimbot()
    end
    if boxESPEnabled or nameESPEnabled then
        for _, target in pairs(game.Players:GetPlayers()) do
            if target.Character then
                DrawESP(target.Character)
            end
        end
    end
    if noRecoilEnabled then
        NoRecoil()
    end
    if bhopEnabled then
        -- Bunny Hop kodları burada çalışacak
    end
    if godModeEnabled then
        GodMode()
    end
    if triggerBotEnabled then
        TriggerBot()
    end
end)
