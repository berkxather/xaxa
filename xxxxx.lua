local Venus = loadstring(game:HttpGet("https://raw.githubusercontent.com/venoscripts/venus/master/venoscript.lua"))()

-- Menü Tasarımı
local window = Venus:CreateWindow("Exunys Aimbot Settings", 500, 400)

-- Aimbot Sekmesi
local aimbotTab = window:CreateTab("Aimbot")

-- Aimbot Açma/Kapama Butonu
aimbotTab:CreateToggle("Enable Aimbot", function(value)
    getgenv().Aimbot.Enabled = value
end)

-- Hedef kilitli parça seçici (Baş/Chest)
aimbotTab:CreateDropdown("Lock Part", {"Head", "Torso", "Legs"}, function(selected)
    getgenv().Aimbot.Settings.LockPart = selected
end)

-- Hassasiyet Ayarı
aimbotTab:CreateSlider("Sensitivity", 0, 10, 0, function(value)
    getgenv().Aimbot.Settings.Sensitivity = value
end)

-- FOV Sekmesi
local fovTab = window:CreateTab("FOV Settings")

-- FOV Görünürlük Butonu
fovTab:CreateToggle("Enable FOV", function(value)
    getgenv().Aimbot.FOVSettings.Enabled = value
end)

-- FOV Miktarı Ayarı
fovTab:CreateSlider("FOV Amount", 0, 200, 90, function(value)
    getgenv().Aimbot.FOVSettings.Amount = value
end)

-- FOV Renk Seçici
fovTab:CreateColorPicker("FOV Color", Color3.fromRGB(255, 255, 255), function(color)
    getgenv().Aimbot.FOVSettings.Color = color
end)

-- FOV Şeffaflık Ayarı
fovTab:CreateSlider("FOV Transparency", 0, 1, 0.5, function(value)
    getgenv().Aimbot.FOVSettings.Transparency = value
end)

-- Kaydet ve Çıkış Butonları
local functionsTab = window:CreateTab("Functions")

-- Ayarları Kaydet Butonu
functionsTab:CreateButton("Save Settings", function()
    SaveSettings() -- Önceden tanımlı SaveSettings fonksiyonu kullanılacak
end)

-- Çıkış Butonu
functionsTab:CreateButton("Exit", function()
    getgenv().Aimbot.Functions:Exit()
end)

-- Menü Göster
window:Show()
