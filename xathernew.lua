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

-- AIMBOT SEKME
Tabs.Aim:AddToggle("AimbotToggle", {
    Title = "Aimbot",
    Description = "Aimbot'u etkinleştir",
    Default = false,
    Callback = function(state)
        print("Aimbot durumu:", state)
        -- Aimbot işlevi eklenmeli
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
        -- FOV çizimi yapılmalı
    end
})

Tabs.Aim:AddDropdown("LockTarget", {
    Title = "Kilitlenme Noktası",
    Description = "Hangi vücut parçasına kilitleneceğini seçin",
    Options = {"Head", "Chest", "Legs"},
    Default = "Head",
    Callback = function(selected)
        print("Kilitlenme noktası:", selected)
        -- Kilitlenme noktası seçildiğinde işlev eklenmeli
    end
})

Tabs.Aim:AddToggle("IgnoreTeammateToggle", {
    Title = "Takım Arkadaşlarını Yok Say",
    Description = "Takım arkadaşlarına kilitlenmesin",
    Default = false,
    Callback = function(state)
        print("Takım arkadaşları durumu:", state)
        -- Takım arkadaşı yok sayma işlevi eklenmeli
    end
})

Tabs.Aim:AddTextbox("LockKey", {
    Title = "Kilitlenme Tuşu",
    Description = "Kilitlenmek için hangi tuşa basılacak?",
    Default = "Shift",
    Callback = function(key)
        print("Kilitlenme tuşu:", key)
        -- Kilitlenme tuşu işlevi eklenmeli
    end
})

Tabs.Aim:AddToggle("LockKeyEnable", {
    Title = "Kilitlenme Tuşunu Etkinleştir",
    Description = "Kilitlenme tuşunu etkinleştir",
    Default = true,
    Callback = function(state)
        print("Kilitlenme düğmesi durumu:", state)
        -- Kilitlenme tuşu etkinleştiriliyor
    end
})

Tabs.Aim:AddToggle("DrawFOVToggle", {
    Title = "Draw FOV",
    Description = "FOV'yi ekranda göster",
    Default = false,
    Callback = function(state)
        print("FOV çizimi durumu:", state)
        -- FOV çizecek işlev eklenmeli
    end
})

-- ESP SEKME
Tabs.ESP:AddToggle("WallhackToggle", {
    Title = "Wallhack",
    Description = "Duvarların arkasını gör",
    Default = false,
    Callback = function(state)
        print("Wallhack durumu:", state)
        -- Wallhack işlevi eklenmeli
    end
})

Tabs.ESP:AddToggle("EnableESPToggle", {
    Title = "Enable ESP",
    Description = "Bütün ESP işlevlerini aç/kapat",
    Default = false,
    Callback = function(state)
        print("ESP aktifliği:", state)
        -- ESP işlevlerinin aktif edilmesi sağlanmalı
    end
})

Tabs.ESP:AddToggle("BoxESP", {
    Title = "Box ESP",
    Description = "Düşmanları kutu olarak göster",
    Default = false,
    Callback = function(state)
        print("Box ESP durumu:", state)
        -- Box ESP gösterimi buraya eklenmeli
    end
})

Tabs.ESP:AddToggle("HealthESP", {
    Title = "Health ESP",
    Description = "Düşmanların canını göster",
    Default = false,
    Callback = function(state)
        print("Health ESP durumu:", state)
        -- Health ESP işlevi eklenmeli
    end
})

Tabs.ESP:AddToggle("DistanceESP", {
    Title = "Distance ESP",
    Description = "Düşmanların bize olan mesafesini göster",
    Default = false,
    Callback = function(state)
        print("Distance ESP durumu:", state)
        -- Mesafe ESP işlevi eklenmeli
    end
})

-- GUN SEKME
Tabs.Gun:AddToggle("NoRecoilToggle", {
    Title = "No Recoil",
    Description = "Geri tepme yok",
    Default = false,
    Callback = function(state)
        print("No Recoil durumu:", state)
        -- No Recoil işlevi eklenmeli
    end
})

Tabs.Gun:AddToggle("NoSpreadToggle", {
    Title = "No Spread",
    Description = "Mermi saçılmasını kaldır",
    Default = false,
    Callback = function(state)
        print("No Spread durumu:", state)
        -- Mermi saçılmasını engelleyen kod eklenmeli
    end
})

Tabs.Gun:AddToggle("NoSwayToggle", {
    Title = "No Sway",
    Description = "Silah sarsıntısını engelle",
    Default = false,
    Callback = function(state)
        print("No Sway durumu:", state)
        -- Silah sarsıntısını engelleyen işlev eklenmeli
    end
})

Tabs.Gun:AddToggle("RapidFireToggle", {
    Title = "Rapid Fire",
    Description = "Hızlı ateş etme",
    Default = false,
    Callback = function(state)
        print("Rapid Fire durumu:", state)
        -- Rapid Fire işlevi eklenmeli
    end
})

-- MISC SEKME
Tabs.Misc:AddToggle("BhopToggle", {
    Title = "Bhop",
    Description = "Otomatik zıplama",
    Default = false,
    Callback = function(state)
        print("Bhop durumu:", state)
        -- Bhop işlevi eklenmeli
    end
})

Tabs.Misc:AddToggle("NoClipToggle", {
    Title = "No Clip",
    Description = "Duvarların içinden geç",
    Default = false,
    Callback = function(state)
        print("No Clip durumu:", state)
        -- No Clip işlevi eklenmeli
    end
})

Tabs.Misc:AddToggle("GodModeToggle", {
    Title = "God Mode",
    Description = "Ölümsüzlük",
    Default = false,
    Callback = function(state)
        print("God Mode durumu:", state)
        -- God Mode işlevi eklenmeli
    end
})

Tabs.Misc:AddToggle("InfiniteAmmoToggle", {
    Title = "Infinite Ammo",
    Description = "Sonsuz mermi",
    Default = false,
    Callback = function(state)
        print("Infinite Ammo durumu:", state)
        -- Sonsuz mermi işlevi eklenmeli
    end
})

Tabs.Misc:AddToggle("RadarHackToggle", {
    Title = "Radar Hack",
    Description = "Düşmanları haritada göster",
    Default = false,
    Callback = function(state)
        print("Radar Hack durumu:", state)
        -- Radar Hack işlevi eklenmeli
    end
})

Tabs.Misc:AddToggle("JumpPowerToggle", {
    Title = "Jump Power",
    Description = "Zıplama gücünü artır",
    Default = false,
    Callback = function(state)
        print("Jump Power durumu:", state)
        -- Jump Power işlevi eklenmeli
    end
})

Tabs.Misc:AddToggle("WalkSpeedToggle", {
    Title = "Walk Speed",
    Description = "Yürüme hızını artır",
    Default = false,
    Callback = function(state)
        print("Walk Speed durumu:", state)
        -- Walk Speed işlevi eklenmeli
    end
})

-- Menü sonu
print("Hile menüsü başarıyla yüklendi.")
