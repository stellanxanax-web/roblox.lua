-- [[ ADVANCED ADOPT ME MULTI-FARM ENGINE — DELTA MOBILE OPTIMIZED ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- Clear prior runtime threads to avoid severe memory leaks on mobile
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
local API = ReplicatedStorage:WaitForChild("API")
local ClientModules = ReplicatedStorage:WaitForChild("ClientModules")

-- Precise internal task network names mapping to system states
local TaskRemotes = {
    ["sleep"] = API:WaitForChild("HousingAPI/ActivateFurniture"),
    ["bored"] = API:WaitForChild("MechanismAPI/PlayMinigame"),
    ["dirty"] = API:WaitForChild("HousingAPI/ActivateFurniture"),
    ["hungry"] = API:WaitForChild("PetAPI/ConsumeFoodItem"),
    ["thirsty"] = API:WaitForChild("PetAPI/ConsumeFoodItem"),
    ["school"] = API:WaitForChild("SchoolAPI/AttendSchool")
}

-- Anti-AFK Crash Mitigation
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(0.5)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- Safe Mobile Evasion Tween
local function executeTween(targetCFrame, velocity)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = LocalPlayer.Character.HumanoidRootPart
    local distance = (hrp.Position - targetCFrame.Position).Magnitude
    local duration = distance / (velocity or 45)
    
    local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
    tween:Play()
    return tween
end

-- ============================================================================
-- MODULE 1: GLOBAL PET & BABY TASK LOOP
-- ============================================================================
task.spawn(function()
    while runtimeActive do
        pcall(function()
            -- Get Active Pet Client Data Structure
            local dataData = ClientModules:FindFirstChild("DataModule")
            if dataData then
                local playerData = require(dataData).GetLocalData()
                if playerData and playerData.pets then
                    -- Track active status ailments assigned by server
                    for _, pet in pairs(playerData.pets) do
                        if pet.is_equipped and pet.ailments then
                            for ailmentId, _ in pairs(pet.ailments) do
                                if TaskRemotes[ailmentId] then
                                    -- Target specific internal functional subroutines
                                    TaskRemotes[ailmentId]:FireServer(ailmentId)
                                end
                            end
                        end
                    end
                end
                -- Baby task parallel processing mapping
                if playerData and playerData.baby_ailments then
                    for ailmentId, _ in pairs(playerData.baby_ailments) do
                        if TaskRemotes[ailmentId] then
                            TaskRemotes[ailmentId]:FireServer(ailmentId)
                        end
                    end
                end
            end
        end)
        task.wait(3.5)
    end
end)

-- ============================================================================
-- MODULE 2: HAUNTLET SAFE-DOOR CALCULATION
-- ============================================================================
task.spawn(function()
    while runtimeActive do
        pcall(function()
            local hauntlet = workspace:FindFirstChild("HauntletMinigame") or workspace:FindFirstChild("Minigames")
            if hauntlet then
                for _, zone in ipairs(hauntlet:GetChildren()) do
                    local doorSet = zone:FindFirstChild("Doors") or zone:FindFirstChild("Gates")
                    if doorSet then
                        for _, door in ipairs(doorSet:GetChildren()) do
                            -- Advanced check evaluating transparent collisions/attributes indicating a real path
                            local isTrap = door:GetAttribute("Trap") or door:GetAttribute("IsFake")
                            if isTrap == false or door.Transparency > 0 then
                                local targetTween = executeTween(door.CFrame)
                                if targetTween then targetTween.Completed:Wait() end
                                task.wait(0.3)
                                break
                            end
                        end
                    end
                end
            end
        end)
        task.wait(1)
    end
end)

-- ============================================================================
-- MODULE 3: GHOST GALLERY ULTRA-SPEED GRIND
-- ============================================================================
task.spawn(function()
    while runtimeActive do
        pcall(function()
            local ghostContainer = workspace:FindFirstChild("GhostGallery") or workspace:FindFirstChild("ActiveGhosts")
            if ghostContainer then
                local shootRemote = API:FindFirstChild("MinigameAPI/ShootGhost") or API:FindFirstChild("MinigameAPI/ClickGhost")
                if shootRemote then
                    for _, ghost in ipairs(ghostContainer:GetChildren()) do
                        if ghost:IsA("BasePart") or ghost:FindFirstChild("HumanoidRootPart") then
                            -- Instantly send network instructions to score points on active items without waiting to move
                            shootRemote:FireServer(ghost.Name)
                        end
                    end
                end
            end
        end)
        task.wait(0.1) -- Fast loop delay to intercept spawned entities before normal players
    end
end)

-- ============================================================================
-- MODULE 4: STITCHES' SPOTLIGHT EVASIVE AUTOMATION
-- ============================================================================
task.spawn(function()
    while runtimeActive do
        pcall(function()
            local eventMap = workspace:FindFirstChild("StitchesSpotlight") or workspace:FindFirstChild("SpotlightGame")
            if eventMap then
                local candyDrops = eventMap:FindFirstChild("CandyCornDrops") or eventMap:FindFirstChild("Drops")
                local lights = eventMap:FindFirstChild("ActiveSpotlights") or workspace:FindFirstChild("Spotlights")
                
                if candyDrops then
                    for _, candy in ipairs(candyDrops:GetChildren()) do
                        if candy:IsA("BasePart") then
                            local pathSecure = true
                            
                            -- Vector threat field calculations against moving ray beams
                            if lights then
                                for _, beam in ipairs(lights:GetChildren()) do
                                    if beam:IsA("BasePart") and (candy.Position - beam.Position).Magnitude < 16 then
                                        pathSecure = false
                                        break
                                    end
                                end
                            end
                            
                            if pathSecure then
                                -- Smooth tween execution directly over coordinate drops
                                local candyTween = executeTween(candy.CFrame + Vector3.new(0, 1.5, 0), 50)
                                if candyTween then candyTween.Completed:Wait() end
                                task.wait(0.05)
                            end
                        end
                    end
                end
            end
        end)
        task.wait(0.4)
    end
end)

print("[SUCCESS] Complete Multi-Task Engine loaded into Delta Runtime Memory Context.")
