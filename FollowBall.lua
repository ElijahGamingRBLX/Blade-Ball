local trackedBall = nil

while Follow do
    local balls = workspace.Balls:GetChildren()

    if trackedBall and not trackedBall.Parent then
        trackedBall = nil  -- ติดตามบอลเฉพาะเมื่อบอลยังอยู่ใน workspace.Balls
    end

    if not trackedBall and #balls > 0 then
        trackedBall = balls[1]  -- เริ่มติดตามบอลแรกในลำดับ
    end

    if trackedBall then
        if trackedBall:IsA("BasePart") and trackedBall.Velocity then
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = trackedBall.CFrame * CFrame.new(0, 0, trackedBall.Velocity.Magnitude * 0)
        end
    end

    wait()
end
