--// Setup Dababy Menu
local Dababy = loadstring(game:HttpGet("https://raw.githubusercontent.com/Dababy-Menu/Dababy/main/Dababy.lua"))()

--// Menu Title and Options
local Menu = Dababy.CreateMenu("Exunys Aimbot")

local AimbotTab = Menu:AddTab("Aimbot")

--// Aimbot Settings
local EnableAimbot = AimbotTab:AddToggle("Enable Aimbot", false, function(value)
    getgenv().Aimbot.Settings.Enabled = value
end)

local LockPart = AimbotTab:AddDropdown("Lock Part", {"Head", "Torso", "Legs"}, function(value)
    getgenv().Aimbot.Settings.LockPart = value
end)

local TeamCheck = AimbotTab:AddToggle("Enable Team Check", false, function(value)
    getgenv().Aimbot.Settings.TeamCheck = value
end)

local FOVCircleEnabled = AimbotTab:AddToggle("Enable FOV Circle", true, function(value)
    getgenv().Aimbot.FOVSettings.Enabled = value
end)

local FOVAmount = AimbotTab:AddSlider("FOV Amount", 90, 0, 180, function(value)
    getgenv().Aimbot.FOVSettings.Amount = value
end)

local FOVColor = AimbotTab:AddColorPicker("FOV Color", Color3.fromRGB(255, 255, 255), function(value)
    getgenv().Aimbot.FOVSettings.Color = value
end)

local Sensitivity = AimbotTab:AddSlider("Sensitivity", 0, 0, 10, function(value)
    getgenv().Aimbot.Settings.Sensitivity = value
end)

--// Main Loop for Aimbot
local function AimbotLoop()
    while wait() do
        if getgenv().Aimbot.Settings.Enabled then
            local closestPlayer = GetClosestPlayer()  -- Function to get closest player (as defined earlier)
            if closestPlayer then
                local part = closestPlayer.Character:FindFirstChild(getgenv().Aimbot.Settings.LockPart)
                if part then
                    -- Lock the aim to the target part
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
                end
            end
        end
    end
end

--// Start Aimbot
spawn(AimbotLoop)

--// Function to Update FOV Circle
RunService.RenderStepped:Connect(function()
    if getgenv().Aimbot.FOVSettings.Enabled then
        getgenv().Aimbot.FOVCircle.Radius = getgenv().Aimbot.FOVSettings.Amount
        getgenv().Aimbot.FOVCircle.Color = getgenv().Aimbot.FOVSettings.Color
        getgenv().Aimbot.FOVCircle.Visible = true
        getgenv().Aimbot.FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    else
        getgenv().Aimbot.FOVCircle.Visible = false
    end
end)

--// Additional Functionality: Notifications
function SendNotification(Title, Text, Duration)
    StarterGui:SetCore("SendNotification", {
        Title = Title,
        Text = Text,
        Duration = Duration
    })
end

--// Saving Settings
function SaveSettings()
    -- Here you can write code to save user settings, like toggle states
end

--// Reset All Settings Button
local ResetButton = AimbotTab:AddButton("Reset Settings", function()
    getgenv().Aimbot.Functions:ResetSettings()
    SendNotification("Settings", "Aimbot settings have been reset!", 5)
end)

--// Exit Button
local ExitButton = AimbotTab:AddButton("Exit", function()
    getgenv().Aimbot.Functions:Exit()
    SendNotification("Aimbot", "Exiting the script.", 5)
end)

--// Start the Menu
Menu:Open()
