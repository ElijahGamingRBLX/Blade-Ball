local function get_plr()
  return game.Players.LocalPlayer
end

local function get_plrChar()
  local plrChar = get_plr().Character
  if plrChar then
    return plrChar
  end
end

local function get_plrRP()
  local plrRP = get_plrChar():FindFirstChild("HumanoidRootPart")
  if plrRP then
    return plrRP
  end
end

local function playerJump()
  pcall(function()
    game.Players.LocalPlayer.Character.Humanoid.Jump = true
  end)
end

local function get_PlayersNumber()
  local Alive = workspace:WaitForChild("Alive", 20):GetChildren()
  local PlayersNumber = 0
  for _,v in pairs(Alive) do
    if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 50 then
      PlayersNumber = PlayersNumber + 1
    end
  end
  return PlayersNumber
end

local function get_ProxyPlayer()
  local Players = workspace:WaitForChild("Alive"):GetChildren()
  local Distance = math.huge
  local plr = game.Players.LocalPlayer
  local plrRP = plr.Character:FindFirstChild("HumanoidRootPart")
  local Player = nil
  
  for _,plr1 in pairs(Players) do
    if plr1.Name ~= plr.Name and plrRP and plr1:FindFirstChild("HumanoidRootPart") and plr1:FindFirstChild("Humanoid") and plr1.Humanoid.Health > 50 then
      local magnitude = (plr1.HumanoidRootPart.Position - plrRP.Position).Magnitude
      if magnitude <= Distance then
        Distance = magnitude
        Player = plr1
      end
    end
  end
  return Player
end

local function Click_Button()
  task.spawn(function()
    local plr = game.Players.LocalPlayer
    local plrFind = workspace.Alive:FindFirstChild(plr.Name)
    if plrFind then
      local plrs = 0
      for _,v in pairs(workspace:WaitForChild("Alive", 10):GetChildren()) do
        plrs = plrs + 1
      end
      if plrs > 1 then
        game:GetService("ReplicatedStorage").Remotes.ParryButtonPress:Fire()
      end
    end
  end)
end

task.spawn(function()
  while task.wait() do
    if getgenv().SpamClickA then
      Click_Button()
    end
  end
end)

local function DetectSpam()
  local Balls = workspace:WaitForChild("Balls", 20)
  
  local OldPos = Vector3.new()
  local OldTick1 = tick()
  
  local OldBall = Balls
  local TargetPlayer = ""
  local SpamNum = 0
  local BallSpeed = 0
  local BallDistance = 0
  
  task.spawn(function()
    local OldTick = tick()
    local OldPos = Vector3.new()
    while getgenv().DetectSpam do task.wait()
      local plrRP = get_plrRP()
      local Ball = Balls:FindFirstChildOfClass("Part")
      if plrRP and Ball then
        BallDistance = (plrRP.Position - Ball.Position).Magnitude
        BallSpeed = (OldPos - Ball.Position).Magnitude
        if tick() - OldTick >= 1/60 then
          OldTick = tick()
          OldPos = Ball.Position
        end
      end
    end
  end)
  
  while getgenv().DetectSpam do task.wait()
    local Ball = Balls:FindFirstChildOfClass("Part")
    local plrRP = get_plrRP()
    local ProxyPlayer = get_ProxyPlayer()
    
    if not Ball then
      getgenv().SpamClickA = false
    end
  
    if Ball and Ball:GetAttribute("realBall") and OldBall ~= Ball then
    
      Ball.Changed:Connect(function()task.wait()
        local Ball = Balls:FindFirstChildOfClass("Part")
        
        if Ball then
          TargetPlayer = Ball:GetAttribute("target")
          
          if ProxyPlayer and TargetPlayer == ProxyPlayer.Name or get_plr() and TargetPlayer == get_plr().Name then
            SpamNum = SpamNum + 1
          else
            SpamNum = 0
          end
          
          local args = ProxyPlayer and ProxyPlayer:FindFirstChild("HumanoidRootPart")
          local HL1 = ProxyPlayer and ProxyPlayer:FindFirstChild("Highlight")
          local HL2 = get_plrChar() and get_plrChar():FindFirstChild("Highlight")
          
          if plrRP and HL1 and args or plrRP and HL2 and args then
            local DistancePlayer = (ProxyPlayer.HumanoidRootPart.Position - plrRP.Position).Magnitude
            local DistanceBall = (Ball.Position - plrRP.Position).Magnitude
            
            if get_PlayersNumber() < 3 then
              if DistancePlayer <= 30 and DistanceBall <= 35 and SpamNum >= 2 then
                getgenv().SpamClickA = true
              else
                getgenv().SpamClickA = false
              end
            else
              if DistancePlayer <= 30 and DistanceBall <= 35 and SpamNum >= 3 then
                getgenv().SpamClickA = true
              else
                getgenv().SpamClickA = false
              end
            end
          else
            getgenv().SpamClickA = false
          end
        end
      end)
      OldBall = Ball
    end
  end
end

getgenv().DetectSpam = true
DetectSpam()

getgenv().AutoDetectSpam = true

--///////////////////////////////////////////////////////////////////--

local Alive = workspace:WaitForChild("Alive", 9e9)
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 9e9)
local ParryAttempt = Remotes:WaitForChild("ParryAttempt", 9e9)
local Balls = workspace:WaitForChild("Balls", 9e9)

--///////////////////////////////////////////////////////////////////--

local function get_ProxyPlayer()
  local Distance = math.huge
  local plrRP = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
  local PlayerReturn = nil
  
  for _,plr1 in pairs(Alive:GetChildren()) do
    if plr1:FindFirstChild("Humanoid") and plr1.Humanoid.Health > 50 then
      if plr1.Name ~= Player.Name and plrRP and plr1:FindFirstChild("HumanoidRootPart") then
        local magnitude = (plr1.HumanoidRootPart.Position - plrRP.Position).Magnitude
        if magnitude <= Distance then
          Distance = magnitude
          PlayerReturn = plr1
        end
      end
    end
  end
  return PlayerReturn
end

local function SuperClick()
  task.spawn(function()
    if IsAlive() and #Alive:GetChildren() > 1 then
      local args1 = 0.5
      local args2 = CFrame.new()
      local args3 = {["enzo"] = Vector3.new()}
      local args4 = {500, 500}
      
      if args1 and args2 and args3 and args4 then
        ParryAttempt:FireServer(args1, args2, args3, args4)
      end
    end
  end)
end

task.spawn(function()
  while task.wait() do
    if getgenv().SpamClickA and getgenv().AutoDetectSpam then
      SuperClick()
    end
  end
end)

local ParryCounter = 0
local DetectSpamDistance = 0

local function GetBall(ball)
  local Target = ""
  
  ball:GetPropertyChangedSignal("Position"):Connect(function()
    local PlayerPP = Player and Player.Character and Player.Character.PrimaryPart
    local NearestPlayer = get_ProxyPlayer()
    
    if ball and PlayerPP and NearestPlayer and NearestPlayer.PrimaryPart then
      local PlayerDistance = (PlayerPP.Position - NearestPlayer.PrimaryPart.Position).Magnitude
      local BallDistance = (PlayerPP.Position - ball.Position).Magnitude
      
      DetectSpamDistance = 25 + math.clamp(ParryCounter / 3, 0, 25)
      
      if ParryCounter > 2 and PlayerDistance < DetectSpamDistance and BallDistance < 55 then
        getgenv().SpamClickA = true
      else
        getgenv().SpamClickA = false
      end
    end
  end)
  ball:GetAttributeChangedSignal("target"):Connect(function()
    Target = ball:GetAttribute("target")
    local NearestPlayer = get_ProxyPlayer()
    
    if NearestPlayer then
      if Target == NearestPlayer.Name or Target == Player.Name then
        ParryCounter = ParryCounter + 1
      else
        ParryCounter = 0
      end
    end
  end)
end

for _,ball in pairs(Balls:GetChildren()) do
  if ball and not ball:GetAttribute("realBall") then
    return
  end
  
  GetBall(ball)
end

Balls.ChildAdded:Connect(function(ball)
  if not getgenv().AutoDetectSpam then
    return
  elseif ball and not ball:GetAttribute("realBall") then
    return
  end
  
  getgenv().SpamClickA = false
  ParryCounter = 0
  GetBall(ball)
end)
