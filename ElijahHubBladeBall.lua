local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Elijah Hub - Tower Of Hell", HidePremium = false, SaveConfig = true, IntroEnabled = false, IntroText = "Elijah Hub", ConfigFolder = "OrionTest"})

OrionLib:MakeNotification({
	Name = "Elijah Hub - Blade Ball",
	Content = "Elijah Hub Has Loaded Welcome "..Player.Name.."!",
	Image = "rbxassetid://4483345998",
	Time = 5
})

local Tab = Window:MakeTab({
	Name = "Auto Parry",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Auto Parry Main"
})

Tab:AddButton({
	Name = "Auto Parry",
	Callback = function()
      	getgenv().disable = true
wait(.1)
getgenv().disable = false
function getball()
    local ball
    for i, v in pairs(workspace.Balls:GetChildren()) do if v.Anchored == false then ball = v end end
return ball
end

function istargeted()
    return game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Highlight") and true or false
end

function distancefromball()
    local dist
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.HumanoidRootPart and getball() then
        return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - getball().Position).Magnitude
    end
end

function getping()
    return game.Players.LocalPlayer:GetNetworkPing()*20
end

function getparrydist()
    return math.clamp(getball().Velocity.Magnitude/2.4+getping(),15, 200)
end

function waituntilnottargeted()
local timeout = false
    spawn(function()
wait(.8)
timeout = true
    end)
    repeat wait() until not istargeted() or timeout
end

local circle = Instance.new("Part")
circle.Shape = Enum.PartType.Ball
circle.Material = Enum.Material.SmoothPlastic
circle.Parent = workspace
circle.CanCollide = false
circle.Material = Enum.Material.ForceField
circle.Anchored = true
circle.CastShadow = false

local last = 99999
local spam = false
local alrchecked = false

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    spam = false
end)

game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
    spam = false
end)

spawn(function()
while wait() and not getgenv().disable do
    xpcall(function()
        -- if getball() then print(getparrydist()) end
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then circle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame circle.Size = Vector3.new(getparrydist(),getparrydist(),getparrydist()) end
if istargeted() and not alrchecked then
    if tick() - last < .7 and distancefromball() < 70 or distancefromball() < 20  then
        print(distancefromball())
        print(tick() - last)
    spam = true
    print("spam")
    circle.Color = Color3.new(1,0,0)
    alrchecked = true
    else
        alrchecked = true
        print("no spam")
        spam = false
    circle.Color = Color3.new(1,1,1)
    end
    last = tick()
elseif not istargeted() then
    alrchecked = false
end
        if istargeted() == true and getball() ~= nil and distancefromball() < getparrydist() or spam and istargeted() then
            local args = {
        [1] = 0.5,
        [2] = CFrame.lookAt(workspace.CurrentCamera.CFrame.p, Vector3.new(workspace.CurrentCamera.CFrame.p.X,999999999999999999999999999,workspace.CurrentCamera.CFrame.p.Z)),
        [3] = {
            ["HunnayyyxD"] = Vector3.new(1171.807861328125, 226.43194580078125, 85.06675720214844),
            ["Softicey"] = Vector3.new(10073.6025390625, 640.4264526367188, 10.497177124023438),
            ["DonPlayyz_YT"] = Vector3.new(-2097.249755859375, -391.8228759765625, -8.48858642578125),
            ["Caryhco"] = Vector3.new(1336.871337890625, 224.7318115234375, 105.85006713867188),
            ["ii_VaIord"] = Vector3.new(4280.7001953125, 324.5129699707031, 33.27197265625),
            ["wayareyousoga"] = Vector3.new(-650.9739990234375, 24.628662109375, -31.402557373046875),
            ["East_Wave"] = Vector3.new(2366.4990234375, 272.4285888671875, 51.80149841308594),
            ["Idea_Saman100"] = Vector3.new(1856.654052734375, 224.4664306640625, 106.3294677734375),
            ["SteveTheMan042"] = Vector3.new(-4457.2109375, -216.7236328125, -12.2535400390625),
            ["piggy12841"] = Vector3.new(1569.9359130859375, 223.1246337890625, 109.55888366699219),
            ["geeseofthesilly"] = Vector3.new(940.6378173828125, 556.8900146484375, 12.81744384765625),
            ["Mariagurl_16"] = Vector3.new(797.1363525390625, 272.2474060058594, 47.91747283935547)
        },
        [4] = {
            [1] = 893,
            [2] = 618
        }
    }
    
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("ParryAttempt"):FireServer(unpack(args))
    if not spam then waituntilnottargeted() else wait(distancefromball()/250) end
end
end, warn)
end
end)
repeat wait() until getgenv().disable
circle:Destroy()	
  	end 
})

Tab:AddButton({
	Name = "Auto Parry V2",
	Callback = function()
      		local Debug = false 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 9e9) -- A second argument in waitforchild what could it mean?
local Balls = workspace:WaitForChild("Balls", 9e9)

-- Functions

local function print(...) 
    if Debug then
        warn(...)
    end
end

local function VerifyBall(Ball) -- Returns nil if the ball isn't a valid projectile; true if it's the right ball.
    if typeof(Ball) == "Instance" and Ball:IsA("BasePart") and Ball:IsDescendantOf(Balls) and Ball:GetAttribute("realBall") == true then
        return true
    end
end

local function IsTarget() -- Returns true if we are the current target.
    return (Player.Character and Player.Character:FindFirstChild("Highlight"))
end

local function Parry() -- Parries.
    Remotes:WaitForChild("ParryButtonPress"):Fire()
end

-- The actual code

Balls.ChildAdded:Connect(function(Ball)
    if not VerifyBall(Ball) then
        return
    end
    
    print(`Ball Spawned: {Ball}`)
    
    local OldPosition = Ball.Position
    local OldTick = tick()
    
    Ball:GetPropertyChangedSignal("Position"):Connect(function()
        if IsTarget() then -- No need to do the math if we're not being attacked.
            local Distance = (Ball.Position - workspace.CurrentCamera.Focus.Position).Magnitude 
            local Velocity = (OldPosition - Ball.Position).Magnitude -- Fix for .Velocity not working. Yes I got the lowest possible grade in accuplacer math.
            
            print(`Distance: {Distance}\nVelocity: {Velocity}\nTime: {Distance / Velocity}`)
        
            if (Distance / Velocity) <= 13 then
                Parry()
            end
        end
        
        if (tick() - OldTick >= 1/60) then 
            OldTick = tick()
            OldPosition = Ball.Position
        end
    end)
end)
  	end 
})

local Tab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Other Stuff"
})

Tab:AddButton({
	Name = "Auto Detect",
	Callback = function()
      		loadstring(game:HttpGet(('https://pastebin.com/raw/HPNBFGSf'),true))()
  	end    
})

Tab:AddButton({
	Name = "Auto Spam",
	Callback = function()
      	loadstring(game:HttpGet("https://pastebin.com/raw/t2391h1A"))()	
  	end    
})

Tab:AddButton({
	Name = "Aiming Mechanism",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/Refinement/main/M%3ABlade%20Ball%20Mechanism",true))()
  	end    
})

local Tab = Window:MakeTab({
	Name = "Auto Clash",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Auto Clash Section"
})

Tab:AddButton({
	Name = "Auto Clash",
	Callback = function()
      		loadstring(game:HttpGet("https://pastebin.com/raw/t2391h1A"))()
  	end    
})


Tab:AddButton({
	Name = "Auto Clash V2",
	Callback = function()
      		loadstring(game:HttpGet("https://raw.githubusercontent.com/datshort1/datmodhub/main/AutoClash"))()
  	end    
})
