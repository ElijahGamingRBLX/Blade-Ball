-- Define a global table to simulate getgenv()
local globals = {}
-- Define placeholder for get_plr() if not already defined
local function get_plr()
    -- Placeholder implementation, replace with actual logic to get the player object.
    return game.Players.LocalPlayer
end
local Range = 10
-- Define IsAlive function if not already defined
local function IsAlive()
    -- Placeholder implementation, replace with actual logic to check if the player is alive.
    local Alive = workspace:WaitForChild("Alive", 20)
    return Alive and Alive:FindFirstChild(get_plr().Name) ~= nil
end
-- Define ViewParryArea function
local function ViewParryArea()
    -- Clean up any previous Visual object
    local previousVisual = workspace:FindFirstChild("Parry Range")
    if previousVisual then
        previousVisual:Destroy()
    end
    -- Create a new Visual part
    local Visual = Instance.new("Part", workspace)
    Visual.Name = "Parry Range"
    Visual.Material = Enum.Material.ForceField
    Visual.CastShadow = false
    Visual.CanCollide = false
    Visual.Anchored = true
    Visual.BrickColor = BrickColor.new(1004)
    Visual.Shape = Enum.PartType.Ball

    -- Retrieve the local player
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer

    -- Keep track of the visibility of the parry area
    globals.ViewParryArea = true

    -- Main loop to visualize the parry area
    while globals.ViewParryArea do
        -- Use a wait time that doesnĂ¢â‚¬â„¢t degrade performance
        
        task.wait() 
        local plrChar = Player.Character or Player.CharacterAdded:Wait()
        local plrPP = plrChar:FindFirstChild("HumanoidRootPart") or plrChar.PrimaryPart

        if plrPP then
            Visual.CFrame = CFrame.new(plrPP.Position)
            -- Additional logic for determining the Range based on your game's need
            Visual.Size = Vector3.new(Range, Range, Range)
            if plrChar:FindFirstChild("Highlight") then
                Visual.BrickColor = BrickColor.new(1004)
                Range = 20
            else
                Visual.BrickColor = BrickColor.new(1023)
                Range = 10
            end
            -- Position the Visual at the player's position
            Visual.Position = plrPP.Position
        else
            -- If the player does not have a primary part, move the Visual off-screen
            Visual.Position = Vector3.new(1000, 1000, 1000)
        end
    end
end

-- Call the ViewParryArea function to activate the parry area visualization
while true do
ViewParryArea()
task.wait()
end
