-- Pepsi UI kütüphanesi yükleniyor
local PepsiUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/PepsiDeezNuts/PepsiUI/main/UI.lua"))()

-- Menü penceresi
local win = PepsiUI:Window("CBL Menu", "by ChatGPT", Color3.fromRGB(255, 255, 255), Enum.KeyCode.RightControl)

-- Aim Sekmesi
local aim = win:Tab("Aim")
aim:Toggle("Aimbot", false, function(val)
    print("Aimbot:", val)
end)
aim:Slider("FOV", 1, 200, 100, function(val)
    print("FOV:", val)
end)

-- ESP Sekmesi
local esp = win:Tab("ESP")
esp:Toggle("Wallhack", false, function(val)
    print("Wallhack:", val)
end)
esp:Colorpicker("ESP Color", Color3.fromRGB(255, 0, 0), function(color)
    print("ESP Color:", color)
end)

-- Gun Sekmesi
local gun = win:Tab("Gun")
gun:Toggle("No Recoil", false, function(val)
    print("No Recoil:", val)
end)
gun:Toggle("No Spread", false, function(val)
    print("No Spread:", val)
end)

-- Misc Sekmesi
local misc = win:Tab("Misc")
misc:Toggle("Bhop", false, function(val)
    print("Bhop:", val)
end)
misc:Button("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)
