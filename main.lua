-- [[ ADOPT ME PC MASTER FARM ENGINE — BYPASS EDITION ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- Clear prior runtime threads to avoid script conflicts
if _G.CancelActiveFarm then _G.CancelActiveFarm() end
local runtimeActive = true
_G.CancelActiveFarm = function() runtimeActive = false end

-- Active Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")

-- Instant Folder Discovery (Bypasses Freeze Bugs)
local API = ReplicatedStorage:FindFirstChild("API")
local ClientModules = ReplicatedStorage:FindFirstChild("ClientModules")

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
    local duration = distance / (velocity or 55)
    
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
            if not API or not ClientModules then 
                API = ReplicatedStorage:FindFirstChild("API")
                ClientModules = ReplicatedStorage:FindFirstChild("ClientModules")
            end
            
            local dataData = ClientModules and ClientModules:FindFirstChild("DataModule")
            if dataData then
                local playerData = require(dataData).GetLocalData()
                if playerData and playerData.pets then
                    for _, pet in pairs(playerData.pets) do
                        if pet.is_equipped and pet.ailments then
                            for ailmentId, _ in pairs(pet.ailments) do
                                local remotePath = ailmentId == "hungry" and "PetAPI/ConsumeFoodItem" 
                                                or ailmentId == "thirsty" and "PetAPI/ConsumeFoodItem"
                                                or ailmentId == "sleep" and "HousingAPI/ActivateFurniture"
                                                or ailmentId == "dirty" and "HousingAPI/ActivateFurniture"
                                                or ailmentId == "school" and "SchoolAPI/AttendSchool"
                                                or "MechanismAPI/PlayMinigame"
                                
                                local targetRemote = API:FindFirstChild(remotePath)
                                if targetRemote then
                                    targetRemote:FireServer(ailmentId)
                                end
                            end
                        end
                    end
                end
            end
        end)
        task.wait(3.0)
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
            if ghostContainer and API then
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
        task.wait(0.05)
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
        task.wait(0.3)
    end
end)

print("!!! BYPASS SCRIPT FORCED INTO EXECUTION CONTEXT !!!")
