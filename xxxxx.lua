local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/1v4n-dev/fluent/main/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Exunys Aimbot V2",
    SubTitle = "fluent.dev",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Aimbot Sekmesi
local AimbotTab = Window:AddTab({ Title = "Aimbot", Icon = "target" })

AimbotTab:AddToggle("aimbot_enabled", {
    Title = "Aimbot Aktif",
    Default = getgenv().Aimbot.Settings.Enabled
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.Enabled = val
end)

AimbotTab:AddToggle("team_check", {
    Title = "Takım Kontrolü",
    Default = getgenv().Aimbot.Settings.TeamCheck
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.TeamCheck = val
end)

AimbotTab:AddToggle("alive_check", {
    Title = "Canlı Kontrolü",
    Default = getgenv().Aimbot.Settings.AliveCheck
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.AliveCheck = val
end)

AimbotTab:AddToggle("wall_check", {
    Title = "Duvar Kontrolü",
    Default = getgenv().Aimbot.Settings.WallCheck
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.WallCheck = val
end)

AimbotTab:AddToggle("third_person", {
    Title = "Third Person Modu",
    Default = getgenv().Aimbot.Settings.ThirdPerson
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.ThirdPerson = val
end)

AimbotTab:AddSlider("sensitivity", {
    Title = "Hassasiyet",
    Min = 0,
    Max = 1,
    Default = getgenv().Aimbot.Settings.Sensitivity,
    Decimals = 2
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.Sensitivity = val
end)

AimbotTab:AddSlider("thirdperson_sens", {
    Title = "3rd Person Hassasiyet",
    Min = 0.1,
    Max = 5,
    Default = getgenv().Aimbot.Settings.ThirdPersonSensitivity,
    Decimals = 1
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.ThirdPersonSensitivity = val
end)

AimbotTab:AddInput("trigger_key", {
    Title = "Tetik Tuşu (örn: MouseButton2)",
    Default = getgenv().Aimbot.Settings.TriggerKey,
    Placeholder = "TriggerKey"
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.TriggerKey = val
end)

AimbotTab:AddInput("lock_part", {
    Title = "Vurulacak Nokta (örn: Head)",
    Default = getgenv().Aimbot.Settings.LockPart,
    Placeholder = "LockPart"
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.LockPart = val
end)

AimbotTab:AddToggle("toggle", {
    Title = "Aç/Kapa Modu",
    Default = getgenv().Aimbot.Settings.Toggle
}):OnChanged(function(val)
    getgenv().Aimbot.Settings.Toggle = val
end)

-- ESP Sekmesi
local ESPTab = Window:AddTab({ Title = "ESP", Icon = "eye" })

ESPTab:AddToggle("esp_enabled", {
    Title = "ESP Açık",
    Default = getgenv().Aimbot.FOVSettings.Enabled
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Enabled = val
end)

ESPTab:AddToggle("esp_visible", {
    Title = "ESP Görünür",
    Default = getgenv().Aimbot.FOVSettings.Visible
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Visible = val
end)

ESPTab:AddSlider("fov_amount", {
    Title = "FOV Boyutu",
    Min = 0,
    Max = 300,
    Default = getgenv().Aimbot.FOVSettings.Amount,
    Decimals = 0
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Amount = val
end)

ESPTab:AddInput("fov_color", {
    Title = "FOV Rengi (R, G, B)",
    Default = getgenv().Aimbot.FOVSettings.Color,
    Placeholder = "255, 255, 255"
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Color = val
end)

ESPTab:AddInput("fov_locked_color", {
    Title = "Hedefteki Renk (R, G, B)",
    Default = getgenv().Aimbot.FOVSettings.LockedColor,
    Placeholder = "255, 70, 70"
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.LockedColor = val
end)

ESPTab:AddSlider("fov_transparency", {
    Title = "Şeffaflık",
    Min = 0,
    Max = 1,
    Default = getgenv().Aimbot.FOVSettings.Transparency,
    Decimals = 2
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Transparency = val
end)

ESPTab:AddSlider("fov_sides", {
    Title = "Kenar Sayısı",
    Min = 3,
    Max = 100,
    Default = getgenv().Aimbot.FOVSettings.Sides,
    Decimals = 0
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Sides = val
end)

ESPTab:AddSlider("fov_thickness", {
    Title = "Çizgi Kalınlığı",
    Min = 1,
    Max = 10,
    Default = getgenv().Aimbot.FOVSettings.Thickness,
    Decimals = 0
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Thickness = val
end)

ESPTab:AddToggle("fov_filled", {
    Title = "FOV Dolu",
    Default = getgenv().Aimbot.FOVSettings.Filled
}):OnChanged(function(val)
    getgenv().Aimbot.FOVSettings.Filled = val
end)

-- Diğer Sekmesi
local OtherTab = Window:AddTab({ Title = "Diğer", Icon = "settings" })

OtherTab:AddButton({
    Title = "Ayarları Sıfırla",
    Description = "Varsayılan ayarlara döner",
    Callback = function()
        getgenv().Aimbot.Functions:ResetSettings()
    end
})

OtherTab:AddButton({
    Title = "Yeniden Başlat",
    Description = "Scripti yeniden başlatır",
    Callback = function()
        getgenv().Aimbot.Functions:Restart()
    end
})

OtherTab:AddButton({
    Title = "Kapat",
    Description = "Scripti tamamen durdurur",
    Callback = function()
        getgenv().Aimbot.Functions:Exit()
    end
})
