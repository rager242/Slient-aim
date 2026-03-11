local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Rs = game:GetService("ReplicatedStorage")

local AimAssistEvent = Rs:WaitForChild("AimAssistEvent")

local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local FOVCircle = script.Parent:WaitForChild("FOVCircle")

local aimEnabled = true
local aimRadius = 150 -- pixels on mobile
local maxLockDistance = 120 -- studs

-- Move circle to center of screen for mobile
RunService.RenderStepped:Connect(function()
	FOVCircle.Position = UDim2.new(0, UIS:GetMouseLocation().X, 0, UIS:GetMouseLocation().Y)
end)

local function getClosestMobileTarget()
	local closest = nil
	local shortestDist = math.huge

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

			local root = plr.Character.HumanoidRootPart
			local worldPos = root.Position
			local screenPos, onScreen = Camera:WorldToScreenPoint(worldPos)

			if onScreen then
				local fingerPos = UIS:GetMouseLocation()
				local distance = (Vector2.new(screenPos.X, screenPos.Y) - fingerPos).Magnitude

				if distance <= aimRadius and distance < shortestDist then
					shortestDist = distance
					closest = plr
				end
			end
		end
	end

	return closest
end

RunService.RenderStepped:Connect(function()
	if not aimEnabled then return end
	
	local target = getClosestMobileTarget()
	if target then
		AimAssistEvent:FireServer(target)
	end
end)
