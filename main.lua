-- [[ ADOPT ME PC MASTER FARM ENGINE — NO-UI BACKEND ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- Clear prior runtime threads to prevent crashes
if _G.CancelActiveFarm then _G.CancelActiveFarm() end
local runtimeActive = true
_G.CancelActiveFarm = function() runtimeActive = false end

-- Active Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

-- API Remote Framework Path
local API = ReplicatedStorage:WaitForChild("API", 10)
local ClientModules = ReplicatedStorage:WaitForChild("ClientModules", 10)

if not API or not ClientModules then
    warn("[ERROR] Could not load game directory pathways. Re-execute inside the main server.")
    return
end

-- MASTER CONFIGURATION SWITCHES (Set to true or false right here)
local Config = {
    AutoPetTasks = true,
    AutoBabyTasks = true,
    HauntletFarm = true,
    GhostGalleryFarm = true,
    StitchesSpotlightFarm = true,
    TweenSpeed = 55 -- Faster speed optimized for PC processing environments
}

-- Precise internal task network names mapping to system states
local TaskRemotes = {
    ["sleep"] = API:WaitForChild("HousingAPI/ActivateFurniture", 5),
    ["bored"] = API:WaitForChild("MechanismAPI/PlayMinigame", 5),
    ["dirty"] = API:WaitForChild("HousingAPI/ActivateFurniture", 5),
    ["hungry"] = API:WaitForChild("PetAPI/ConsumeFoodItem", 5),
    ["thirsty"] = API:WaitForChild("PetAPI/ConsumeFoodItem", 5),
    ["school"] = API:WaitForChild("SchoolAPI/AttendSchool", 5)
}

-- PC Anti-AFK Routine
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(0.5)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Safe Pro-PC Evasion Tween Engine
local function executeTween(targetCFrame, velocity)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = distance / (velocity or Config.TweenSpeed)
    
    local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tween:Play()
    return tween
end

-- ============================================================================
-- MODULE 1: PET & BABY CORE AUTOMATION LOOP
-- ============================================================================
task.spawn(function()
    print("[FARM] Routine Pet/Baby systems operational.")
    while runtimeActive do
        pcall(function()
            local dataData = ClientModules:FindFirstChild("DataModule")
            if dataData then
                local playerData = require(dataData).GetLocalData()
                
                -- Pet Task Traversal Configuration
                if Config.AutoPetTasks and playerData and playerData.pets then
                    for _, pet in pairs(playerData.pets) do
                        if pet.is_equipped and pet.ailments then
                            for ailmentId, _ in pairs(pet.ailments) do
                                if TaskRemotes[ailmentId] then
                                    TaskRemotes[ailmentId]:FireServer(ailmentId)
                                end
                            end
                        end
                    end
                end
                
                -- Baby Task Parallel Configuration
                if Config.AutoBabyTasks and playerData and playerData.baby_ailments then
                    for ailmentId, _ in pairs(playerData.baby_ailments) do
                        if TaskRemotes[ailmentId] then
                            TaskRemotes[ailmentId]:FireServer(ailmentId)
                        end
                    end
                end
            end
        end)
        task.wait(3.0)
    end
end)

-- ============================================================================
-- MODULE 2: THE HAUNTLET GATEWAY CHECKER
-- ============================================================================
task.spawn(function()
    while runtimeActive do
        if Config.HauntletFarm then
            pcall(function()
                local hauntlet = workspace:FindFirstChild("HauntletMinigame") or workspace:FindFirstChild("Minigames")
                if hauntlet then
                    for _, zone in ipairs(hauntlet:GetChildren()) do
                        local doorSet = zone:FindFirstChild("Doors") or zone:FindFirstChild("Gates")
                        if doorSet then
                            for _, door in ipairs(doorSet:GetChildren()) do
                                local isTrap = door:GetAttribute("Trap") or door:GetAttribute("IsFake")
                                if isTrap == false or door.Transparency > 0 then
                                    local targetTween = executeTween(door.CFrame)
                                    if targetTween then targetTween.Completed:Wait() end
                                    task.wait(0.2)
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(1)
    end
end)

-- ============================================================================
-- MODULE 3: GHOST GALLERY FAST-CLICK ENGINE
-- ============================================================================
task.spawn(function()
    while runtimeActive do
        if Config.GhostGalleryFarm then
            pcall(function()
                local ghostContainer = workspace:FindFirstChild("GhostGallery") or workspace:FindFirstChild("ActiveGhosts")
                if ghostContainer then
                    local shootRemote = API:FindFirstChild("MinigameAPI/ShootGhost") or API:FindFirstChild("MinigameAPI/ClickGhost")
                    if shootRemote then
                        for _, ghost in ipairs(ghostContainer:GetChildren()) do
                            if ghost:IsA("BasePart") or ghost:FindFirstChild("HumanoidRootPart") then
                                shootRemote:FireServer(ghost.Name)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.05) -- Hyper-fast tracking script execution interval
    end
end)

-- ============================================================================
-- MODULE 4: STITCHES' SPOTLIGHT EVASIVE AUTOMATION
-- ============================================================================
task.spawn(function()
    while runtimeActive do
        if Config.StitchesSpotlightFarm then
            pcall(function()
                local eventMap = workspace:FindFirstChild("StitchesSpotlight") or workspace:FindFirstChild("SpotlightGame")
                if eventMap then
                    local candyDrops = eventMap:FindFirstChild("CandyCornDrops") or eventMap:FindFirstChild("Drops")
                    local lights = eventMap:FindFirstChild("ActiveSpotlights") or workspace:FindFirstChild("Spotlights")
                    
                    if candyDrops then
                        for _, candy in ipairs(candyDrops:GetChildren()) do
                            if candy:IsA("BasePart") and Config.StitchesSpotlightFarm then
                                local pathSecure = true
                                
                                if lights then
                                    for _, beam in ipairs(lights:GetChildren()) do
                                        if beam:IsA("BasePart") and (candy.Position - beam.Position).Magnitude < 15 then
                                            pathSecure = false
                                            break
                                        end
                                    end
                                end
                                
                                if pathSecure then
                                    local candyTween = executeTween(candy.CFrame + Vector3.new(0, 1.5, 0), 60)
                                    if candyTween then candyTween.Completed:Wait() end
                                    task.wait(0.02)
                                end
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.3)
    end
end)

print("[SUCCESS] PC Script loaded successfully. Press F9 in-game to review status reports.")
