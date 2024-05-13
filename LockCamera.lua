while sa do
    wait(.0)
    for _,ball in next, workspace.Balls:GetChildren() do
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, ball.Position)
    end
  end
