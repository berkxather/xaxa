local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/AbstractPoo/Main/main/Fluent/Loader.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Xather Cheat",
    SubTitle = "By Hezli Meymun",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightShift
})

local AimbotTab = Window:AddTab({ Title = "Aimbot", Icon = "Target" })
local FOVTab = Window:AddTab({ Title = "ESP", Icon = "Circle" })
local OtherTab = Window:AddTab({ Title = "Diğer", Icon = "Settings" })

--// Aimbot Ayarları
AimbotTab:AddToggle("enabled", {
    Title = "Aimbot Aktif",
    Default = getgenv().Aimbot.Settings.Enabled,
    Callback = function(v)
        getgenv().Aimbot.Settings.Enabled = v
    end
})

AimbotTab:AddToggle("teamcheck", {
    Title = "Takım Kontrolü",
    Default = getgenv().Aimbot.Settings.TeamCheck,
    Callback = function(v)
        getgenv().Aimbot.Settings.TeamCheck = v
    end
})

AimbotTab:AddToggle("alivecheck", {
    Title = "Canlı Kontrolü",
    Default = getgenv().Aimbot.Settings.AliveCheck,
    Callback = function(v)
        getgenv().Aimbot.Settings.AliveCheck = v
    end
})

AimbotTab:AddToggle("wallcheck", {
    Title = "Duvar Kontrolü",
    Default = getgenv().Aimbot.Settings.WallCheck,
    Callback = function(v)
        getgenv().Aimbot.Settings.WallCheck = v
    end
})

AimbotTab:AddSlider("sensitivity", {
    Title = "Hassasiyet",
    Min = 0,
    Max = 1,
    Default = getgenv().Aimbot.Settings.Sensitivity,
    Decimals = 2,
    Callback = function(v)
        getgenv().Aimbot.Settings.Sensitivity = v
    end
})

AimbotTab:AddToggle("thirdperson", {
    Title = "3. Şahıs Desteği",
    Default = getgenv().Aimbot.Settings.ThirdPerson,
    Callback = function(v)
        getgenv().Aimbot.Settings.ThirdPerson = v
    end
})

AimbotTab:AddSlider("thirdperson_sens", {
    Title = "3. Şahıs Hassasiyeti",
    Min = 0.1,
    Max = 5,
    Default = getgenv().Aimbot.Settings.ThirdPersonSensitivity,
    Decimals = 1,
    Callback = function(v)
        getgenv().Aimbot.Settings.ThirdPersonSensitivity = v
    end
})

AimbotTab:AddInput("triggerkey", {
    Title = "Tetik Tuşu",
    Default = getgenv().Aimbot.Settings.TriggerKey,
    Placeholder = "MouseButton2",
    Callback = function(v)
        getgenv().Aimbot.Settings.TriggerKey = v
    end
})

AimbotTab:AddToggle("toggle_mode", {
    Title = "Toggle Modu",
    Default = getgenv().Aimbot.Settings.Toggle,
    Callback = function(v)
        getgenv().Aimbot.Settings.Toggle = v
    end
})

AimbotTab:AddInput("lockpart", {
    Title = "Kilit Noktası",
    Default = getgenv().Aimbot.Settings.LockPart,
    Placeholder = "Head",
    Callback = function(v)
        getgenv().Aimbot.Settings.LockPart = v
    end
})
