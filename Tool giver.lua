local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local SpeedCoilButton = Instance.new("TextButton")
local GravityCoilButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

local ArrowButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

local ContentFrame = Instance.new("Frame")

local FooterLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
MainFrame.Size = UDim2.new(0, 300, 0, 300)
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

TitleLabel.Parent = MainFrame
TitleLabel.Text = "Tool giver"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 20
TitleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Size = UDim2.new(1, -60, 0, 30)
TitleLabel.Position = UDim2.new(0, 10, 0, 5)

ArrowButton.Parent = MainFrame
ArrowButton.Size = UDim2.new(0, 25, 0, 25)
ArrowButton.Position = UDim2.new(1, -60, 0, 7)
ArrowButton.Text = "+"
ArrowButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UICorner:Clone().Parent = ArrowButton

CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 7)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UICorner:Clone().Parent = CloseButton

ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, 0, 0.75, 0)
ContentFrame.Position = UDim2.new(0, 0, 0.2, 0)
ContentFrame.BackgroundTransparency = 1

SpeedCoilButton.Parent = ContentFrame
SpeedCoilButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SpeedCoilButton.Text = "Speed Coil"
SpeedCoilButton.Font = Enum.Font.SourceSansBold
SpeedCoilButton.TextSize = 18
SpeedCoilButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedCoilButton.Position = UDim2.new(0.1, 0, 0.1, 0)
SpeedCoilButton.Size = UDim2.new(0.8, 0, 0.3, 0)
UICorner:Clone().Parent = SpeedCoilButton

GravityCoilButton.Parent = ContentFrame
GravityCoilButton.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
GravityCoilButton.Text = "Gravity Coil"
GravityCoilButton.Font = Enum.Font.SourceSansBold
GravityCoilButton.TextSize = 18
GravityCoilButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GravityCoilButton.Position = UDim2.new(0.1, 0, 0.6, 0)
GravityCoilButton.Size = UDim2.new(0.8, 0, 0.3, 0)
UICorner:Clone().Parent = GravityCoilButton

FooterLabel.Parent = ContentFrame
FooterLabel.Size = UDim2.new(1, 0, 0, 20)
FooterLabel.Position = UDim2.new(0, 0, 0.9, 0)
FooterLabel.BackgroundTransparency = 1
FooterLabel.Text = "by: t.me/tolik_scripter"
FooterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FooterLabel.Font = Enum.Font.Gotham
FooterLabel.TextSize = 14
FooterLabel.TextTransparency = 0.3

local isContentVisible = true
ArrowButton.MouseButton1Click:Connect(function()
    isContentVisible = not isContentVisible
    if isContentVisible then
        MainFrame.Size = UDim2.new(0, 300, 0, 300)
        ContentFrame.Visible = true
        ArrowButton.Text = "-"
    else
        MainFrame.Size = UDim2.new(0, 300, 0, 40)
        ContentFrame.Visible = false
        ArrowButton.Text = "+"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local dragging = false
local dragInput, mousePos, framePos

TitleLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleLabel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        MainFrame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

local function equipSpeedCoil()
    local speedCoil = game:GetObjects('rbxassetid://99119158')[1]
    speedCoil.Parent = game.Players.LocalPlayer.Backpack
    speedCoil.Equipped:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
        local sound = Instance.new("Sound")
        local soundId = "99173388"
        sound.Parent = game.Workspace
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Playing = true
        sound.Looped = false
        sound.Volume = 1
    end)
    speedCoil.Unequipped:Connect(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)
end

local function equipGravityCoil()
    local gravityCoil = game:GetObjects('rbxassetid://16688968')[1]
    gravityCoil.Parent = game.Players.LocalPlayer.Backpack
    gravityCoil.Equipped:Connect(function()
        game.Workspace.Gravity = 50
        local sound = Instance.new("Sound")
        local soundId = "16619553"
        sound.Parent = game.Workspace
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Playing = true
        sound.Looped = false
        sound.Volume = 1
    end)
    gravityCoil.Unequipped:Connect(function()
        game.Workspace.Gravity = 196.2
    end)
end

SpeedCoilButton.MouseButton1Click:Connect(equipSpeedCoil)
GravityCoilButton.MouseButton1Click:Connect(equipGravityCoil)
