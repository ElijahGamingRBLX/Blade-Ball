local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 9e9) -- A second argument in waitforchild what could it mean?
local Balls = workspace:WaitForChild("Balls", 9e9)

local function VerifyBall(Ball)
    if typeof(Ball) == "Instance" and Ball:IsA("BasePart") and Ball:IsDescendantOf(Balls) and Ball:GetAttribute("realBall") == true then
        return true
    end
end

local function IsTarget()
    return (Player.Character and Player.Character:FindFirstChild("Highlight"))
end

local function RParry()
local args = {
[1] = 1.5,
[2] = CFrame.new(-282.66534423828125, 119.49650573730469, -178.448486328125) * CFrame.Angles(-0.26179957389831543, 0, -0),
[3] = {
 ["5099463143"] = Vector3.new(437, 190.51422119140625, 26.312973022460938)
          },
[4] = {
[1] = 781,
[2] = 147
    }
}
           game:GetService("ReplicatedStorage").Remotes.ParryAttempt:FireServer(unpack(args))
end

local function Parry()
    Remotes:WaitForChild("ParryButtonPress"):Fire()
end

Balls.ChildAdded:Connect(function(Ball)
    if not VerifyBall(Ball) then
        return
    end
    
    local OldPosition = Ball.Position
    local OldTick = tick()
    
    Ball:GetPropertyChangedSignal("Position"):Connect(function()
        if IsTarget() then
            local Distance = (Ball.Position - workspace.CurrentCamera.Focus.Position).Magnitude
            local Velocity = (OldPosition - Ball.Position).Magnitude 
        
            if (Distance / Velocity) <= 0 then
                Parry()
                task.wait()
        end
   end
        if (tick() - OldTick >= 1/60) then
            OldTick = tick()
            OldPosition = Ball.Position
        end
    end)
end)

Balls.ChildAdded:Connect(function(Ball)
    if not VerifyBall(Ball) then
        return
    end
    
    local OldPosition = Ball.Position
    local OldTick = tick()
    
    Ball:GetPropertyChangedSignal("Position"):Connect(function()
        if IsTarget() then
            local Distance = (Ball.Position - workspace.CurrentCamera.Focus.Position).Magnitude
            local Velocity = (OldPosition - Ball.Position).Magnitude 
        
            if (Distance / Velocity) <= 2.5 then
            wait(0.02)
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
          end
   end
        if (tick() - OldTick >= 1/40) then
            OldTick = tick()
            OldPosition = Ball.Position
        end
    end)
end)

Balls.ChildAdded:Connect(function(Ball)
    if not VerifyBall(Ball) then
        return
    end
    
    local OldPosition = Ball.Position
    local OldTick = tick()
    
    Ball:GetPropertyChangedSignal("Position"):Connect(function()
        if IsTarget() then
            local Distance = (Ball.Position - workspace.CurrentCamera.Focus.Position).Magnitude
            local Velocity = (OldPosition - Ball.Position).Magnitude 
        
            if (Distance / Velocity) <= 1 then
            wait(0.03)
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
            RParry()
          end
   end
        if (tick() - OldTick >= 1/30) then
            OldTick = tick()
            OldPosition = Ball.Position
        end
    end)
end)
  	end    
})
