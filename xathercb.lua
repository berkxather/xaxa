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

-- Variables for cheat states
local aimbotEnabled = false
local espEnabled = false
local bhopEnabled = false
local noRecoilEnabled = false

-- Aimbot (Gerçek İşlevsel)
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
                local screenPosition = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                local distance = (Vector2.new(screenPosition.X, screenPosition.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if distance < closestDistance and distance < fov then
                    closestDistance = distance
                    closestPlayer = v
                end
            end
        end
        if closestPlayer then
            local char = closestPlayer.Character
            local rootPart = char:FindFirstChild("HumanoidRootPart")
            if rootPart then
                game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.Position, rootPart.Position)
            end
        end
    end
end

-- ESP (Wallhack) İşlevi
function createESP(player)
    local espPart = Instance.new("BillboardGui", player.Character)
    espPart.Size = UDim2.new(0, 50, 0, 50)
    espPart.StudsOffset = Vector3.new(0, 3, 0)
    espPart.AlwaysOnTop = true
    espPart.Enabled = espEnabled

    local espText = Instance.new("TextLabel", espPart)
    espText.Size = UDim2.new(1, 0, 1, 0)
    espText.BackgroundTransparency = 1
    espText.TextColor3 = Color3.fromRGB(255, 0, 0)
    espText.Text = player.Name
end

function toggleESP()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character then
            createESP(v)
        end
    end
end

-- Bhop (Otomatik Zıplama)
function bhop()
    while bhopEnabled do
        wait()
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()

        if mouse.KeyDown == Enum.KeyCode.Space then
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
    end
end

-- No Recoil (Geri Tepme Kaldırma)
function noRecoil()
    while noRecoilEnabled do
        wait()
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            humanoid.PlatformStand = true
        end
    end
end

-- Aim Sekmesi
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

-- ESP Sekmesi
Tabs.ESP:AddToggle("WallhackToggle", {
    Title = "Wallhack",
    Description = "Duvarların arkasını gör",
    Default = false,
    Callback = function(state)
        espEnabled = state
        toggleESP()
    end
})

Tabs.ESP:AddColorpicker("ESPColor", {
    Title = "ESP Rengi",
    Description = "ESP için renk seçimi",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("Seçilen renk:", color)
    end
})

-- Gun Sekmesi
Tabs.Gun:AddToggle("NoRecoilToggle", {
    Title = "No Recoil",
    Description = "Geri tepme kaldır",
    Default = false,
    Callback = function(state)
        noRecoilEnabled = state
        if noRecoilEnabled then
            noRecoil()
        end
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

-- Misc Sekmesi
Tabs.Misc:AddToggle("BhopToggle", {
    Title = "Bhop",
    Description = "Otomatik zıplama",
    Default = false,
    Callback = function(state)
        bhopEnabled = state
        if bhopEnabled then
            bhop()
        end
    end
})

Tabs.Misc:AddButton("RejoinButton", {
    Title = "Oyuna Yeniden Katıl",
    Description = "Sunucuya yeniden bağlan",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
})
