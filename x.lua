local Fluent = loadstring(game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()

-- Ana pencere oluşturma
local Window = Fluent:CreateWindow({
    Title = "Xather Cheat",
    SubTitle = "by Hezli Meymun",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- Arka plan bulanıklığı
    Theme = "Dark", -- Tema: "Dark", "Light", "Amethyst", "Aqua", "Rose"
    MinimizeKey = Enum.KeyCode.LeftAlt -- Menü aç/kapa tuşu
})

-- Sekmeler oluşturma
local Tabs = {
    Aim = Window:AddTab({ Title = "Aim", Icon = "target" }),
    ESP = Window:AddTab({ Title = "ESP", Icon = "eye" }),
    Gun = Window:AddTab({ Title = "Gun", Icon = "crosshair" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

-- Aimbot ayarları
local aimbotEnabled = false
local targetPart = "Head"  -- Başlangıçta başa kilitlenme
local wallProtectionEnabled = false
local drawFOVEnabled = false
local lockKey = Enum.KeyCode.LeftShift -- Varsayılan olarak Shift
local lockButtonEnabled = false
local ignoreTeammates = false  -- Takım arkadaşlarını görmeme
local enableESP = true         -- ESP aktif / devre dışı

-- ESP ayarları
local boxESPEnabled = true
local healthESPEnabled = true
local distanceESPEnabled = true

-- Bhop ayarları
local bhopEnabled = false

-- Aimbot işlevi
function aimbot()
    while aimbotEnabled do
        wait()
        local closestPlayer = nil
        local closestDistance = math.huge
        local fov = 90
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()

        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                -- Takım arkadaşı durumu
                if ignoreTeammates and v.Team == player.Team then
                    continue
                end
                
                local target = v.Character:FindFirstChild(targetPart)  -- Hedef vücut parçası
                if target then
                    local screenPosition = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(target.Position)
                    local distance = (Vector2.new(screenPosition.X, screenPosition.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                    if distance < closestDistance and distance < fov then
                        closestDistance = distance
                        closestPlayer = v
                    end
                end
            end
        end

        if closestPlayer then
            local char = closestPlayer.Character
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if rootPart then
                -- Duvar koruması kontrolü
                if wallProtectionEnabled then
                    local ray = Ray.new(game:GetService("Workspace").CurrentCamera.CFrame.Position, rootPart.Position - game:GetService("Workspace").CurrentCamera.CFrame.Position)
                    local hitPart = game:GetService("Workspace"):FindPartOnRay(ray, game.Players.LocalPlayer.Character)
                    if hitPart then
                        -- Eğer ray bir şeyle çarpıyorsa, kilitlenme yapma
                        continue
                    end
                end
                -- Kilitlenme işlemi
                game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.Position, rootPart.Position)
            end
        end
    end
end

-- FOV çizimi
function drawFOV()
    local camera = game:GetService("Workspace").CurrentCamera
    local fovCircle = Instance.new("Frame", game.CoreGui)
    fovCircle.Size = UDim2.new(0, 200, 0, 200)
    fovCircle.Position = UDim2.new(0.5, -100, 0.5, -100)
    fovCircle.BorderSizePixel = 2
    fovCircle.BorderColor3 = Color3.fromRGB(255, 0, 0)
    fovCircle.BackgroundTransparency = 0.5
    while drawFOVEnabled do
        wait(0.1)
        fovCircle.Position = UDim2.new(0.5, -fovCircle.Size.X.Offset / 2, 0.5, -fovCircle.Size.Y.Offset / 2)
    end
    fovCircle:Destroy()
end

-- Kilitlenme düğmesi
local lockButtonPressed = false
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then
        if lockButtonEnabled and input.KeyCode == lockKey then
            lockButtonPressed = true
        end
    end
end)

-- Sekmelerdeki ayarlar
Tabs.Aim:AddToggle("AimbotToggle", {
    Title = "Aimbot",
    Description = "Aimbot'u etkinleştir",
    Default = false,
    Callback = function(state)
        aimbotEnabled = state
        if aimbotEnabled then
            aimbot()
        end
    end
})

Tabs.Aim:AddDropdown("TargetPartDropdown", {
    Title = "Kilitleme Parçası",
    Description = "Vücut parçasını seç",
    Default = "Head",
    Options = {"Head", "Chest", "Legs"},
    Callback = function(selected)
        targetPart = selected
    end
})

Tabs.Aim:AddToggle("IgnoreTeammatesToggle", {
    Title = "Ignore Teammates",
    Description = "Takım arkadaşlarına kilitlenmesin",
    Default = false,
    Callback = function(state)
        ignoreTeammates = state
    end
})

Tabs.Aim:AddToggle("WallProtectionToggle", {
    Title = "Wall Protection",
    Description = "Duvarın arkasındaki hedefe kilitlenme",
    Default = false,
    Callback = function(state)
        wallProtectionEnabled = state
    end
})

Tabs.Aim:AddToggle("DrawFOVToggle", {
    Title = "Draw FOV",
    Description = "FOV'yi ekranda göster",
    Default = false,
    Callback = function(state)
        drawFOVEnabled = state
        if drawFOVEnabled then
            drawFOV()
        end
    end
})

Tabs.Aim:AddTextBox("LockButtonTextBox", {
    Title = "Kilitlenme Düğmesi",
    Description = "Hangi tuşa kilitleneceğinizi girin (örneğin: LeftShift)",
    Default = "LeftShift",
    Callback = function(text)
        lockKey = Enum.KeyCode[text]
    end
})

Tabs.Aim:AddToggle("LockButtonEnabledToggle", {
    Title = "Kilitlenme Düğmesi Aktif",
    Description = "Kilitlenmek için düğmeyi etkinleştir",
    Default = false,
    Callback = function(state)
        lockButtonEnabled = state
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
    end
})

-- ESP ayarları
Tabs.ESP:AddToggle("EnableESPToggle", {
    Title = "Enable ESP",
    Description = "ESP'yi aktif hale getir",
    Default = true,
    Callback = function(state)
        enableESP = state
        boxESPEnabled = state
        healthESPEnabled = state
        distanceESPEnabled = state
    end
})

Tabs.ESP:AddToggle("BoxESPToggle", {
    Title = "Box ESP",
    Description = "Box ESP'yi aç",
    Default = true,
    Callback = function(state)
        boxESPEnabled = state
    end
})

Tabs.ESP:AddToggle("HealthESPToggle", {
    Title = "Health ESP",
    Description = "Can ESP'yi aç",
    Default = true,
    Callback = function(state)
        healthESPEnabled = state
    end
})

Tabs.ESP:AddToggle("DistanceESPToggle", {
    Title = "Distance ESP",
    Description = "Mesafe ESP'yi aç",
    Default = true,
    Callback = function(state)
        distanceESPEnabled = state
    end
})

Tabs.Gun:AddToggle("NoRecoilToggle", {
    Title = "No Recoil",
    Description = "Geri tepme kaldır",
    Default = false,
    Callback = function(state)
        print("No Recoil durumu:", state)
    end
})

Tabs.Gun:AddToggle("NoSpreadToggle", {
    Title = "No Spread",
    Description = "Mermi saçılmasını kaldır",
    Default = false,
    Callback = function(state)
        print("No Spread durumu:", state)
    end
})

-- Bhop ayarı
Tabs.Misc:AddToggle("BhopToggle", {
    Title = "Bhop",
    Description = "Otomatik zıplama",
    Default = false,
    Callback = function(state)
        bhopEnabled = state
        -- Bhop fonksiyonunu aktif hale getir
    end
})

Tabs.Misc:AddButton("RejoinButton", {
    Title = "Oyuna Yeniden Katıl",
    Description = "Sunucuya yeniden bağlan",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})
