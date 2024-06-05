local module = {}

module.Data = require(script.Parent)

function module.AddOverhead(player:Player)
	repeat wait() until player.Character:FindFirstChild("Humanoid")
	
	if player.Character:WaitForChild("Head"):FindFirstChild("OverheadGUI") then else
		local OverheadGUI = script.Parent.OverheadGUI:Clone()
		OverheadGUI.Parent = player.Character:WaitForChild("Head")
		
		return OverheadGUI
	end
end

function module.SetupGroupRank(player:Player)
	local OverheadGUI = player.Character:WaitForChild("Head"):WaitForChild("OverheadGUI")
	
	if OverheadGUI then
		if player:IsInGroup(module.Data.MainGroup) then
			for num,list in pairs(module.Data.Ranks) do
				if player:GetRoleInGroup(module.Data.MainGroup) == num then
					if list.Hidden then else
						OverheadGUI.Main.Group.Rank.Text = num
						OverheadGUI.Main.Group.BackgroundColor = list.Color
						OverheadGUI.Main.Group.Visible = true
					end
				end
			end
		end
	else
		warn(player.Name.." does not have an overhead ui.")
	end
end

function module.SetupUsername(player:Player)
	local OverheadGUI = player.Character:WaitForChild("Head"):WaitForChild("OverheadGUI")
	
	if OverheadGUI then
		OverheadGUI.Main.Username.Text = player.DisplayName.." (@"..player.Name..")"
	else
		warn(player.Name.." does not have an overhead ui.")
	end
end

function module.MakeOverheadVisible(player:Player)
	local OverheadGUI = player.Character:WaitForChild("Head"):WaitForChild("OverheadGUI")

	if OverheadGUI then
		OverheadGUI.Enabled = true
	else
		warn(player.Name.." does not have an overhead ui.")
	end
end

function module.SetupHumanoidProperties(player:Player)
	repeat wait() until player.Character:FindFirstChild("Humanoid")
	
	local Humanoid:Humanoid = player.Character.Humanoid
	
	Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
	Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
end

function module.Setup()
	game.Players.PlayerAdded:Connect(function(player:Player)
		player.CharacterAdded:Connect(function(character:Model)
			module.SetupHumanoidProperties(player)
			module.AddOverhead(player)
			module.SetupUsername(player)
			module.SetupGroupRank(player)
			module.MakeOverheadVisible(player)
		end)
	end)
end

return module
