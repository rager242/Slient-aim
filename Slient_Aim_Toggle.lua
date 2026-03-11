local Rs = game:GetService("ReplicatedStorage")

local AimAssistEvent = Instance.new("RemoteEvent")
AimAssistEvent.Name = "AimAssistEvent"
AimAssistEvent.Parent = Rs

AimAssistEvent.OnServerEvent:Connect(function(player, target)
	if not target.Character then return end
	local hum = target.Character:FindFirstChild("Humanoid")
	if not hum then return end

	-- Server receives target; YOU decide what to do:
	-- Example: slightly increase hit chance
	hum:TakeDamage(0)
end)
