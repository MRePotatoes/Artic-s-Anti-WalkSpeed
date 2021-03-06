local MaxCaughts = 3 -- This is max value of how many times anti-exploit can detect player exploiting.

local MaxSinceLastCaughtChange = 10 -- This is max time for how long 'caughts' value wasn't changed.

--IMPORTANT: You can leave everything by default this Anti-Exploit is going to automatically detect what is your game's default WalkSpeed by reading the walk speed from server-side.

--               _   _      _                      _   _     __          __   _ _     _____                     _ 
--    /\        | | (_)    ( )         /\         | | (_)    \ \        / /  | | |   / ____|                   | |
--   /  \   _ __| |_ _  ___|/ ___     /  \   _ __ | |_ _ _____\ \  /\  / /_ _| | | _| (___  _ __   ___  ___  __| |
--  / /\ \ | '__| __| |/ __| / __|   / /\ \ | '_ \| __| |______\ \/  \/ / _` | | |/ /\___ \| '_ \ / _ \/ _ \/ _` |
-- / ____ \| |  | |_| | (__  \__ \  / ____ \| | | | |_| |       \  /\  / (_| | |   < ____) | |_) |  __/  __/ (_| |
--/_/    \_\_|   \__|_|\___| |___/ /_/    \_\_| |_|\__|_|        \/  \/ \__,_|_|_|\_\_____/| .__/ \___|\___|\__,_|
--                                                                                         | |                    
--                                                                                         |_|                    
--  Artic's Anti-WalkSpeed is free software: you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation, either version 3 of the License, or
--  (at your option) any later version.

--  Artic's Anti-WalkSpeed is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.

--  You should have received a copy of the GNU General Public License
--  along with Artic's Anti-WalkSpeed. If not, see <https://www.gnu.org/licenses/>.


game:GetService("Players").PlayerAdded:Connect(function(plr)
	
	local PlayerName = Instance.new("StringValue") -- Just a value to determine localplayer name
	PlayerName.Parent = script
	PlayerName.Name = plr.Name
	
	local SinceLastChange = Instance.new("IntValue")
	SinceLastChange.Parent = PlayerName
	SinceLastChange.Name = "SinceLastChange"
     
    local counter = Instance.new("IntValue") -- Anti-Exploit detection caughts 
    counter.Parent = PlayerName
    counter.Name = "Counter"
	
	plr.CharacterAdded:Connect(function(char)
		
		while true do
			
			SinceLastChange.Value = SinceLastChange.Value + 1
			
		     if counter.Value ~= 0 then -- if counter variable is not 0
			   if SinceLastChange.Value > MaxSinceLastCaughtChange then -- If time from last change is higher than selected variable then
				   counter.Value = 0 -- set counter to 0
				   SinceLastChange.Value = 0 -- set time from last change to 0
			    end
			  end
			
			if char:FindFirstChild("HumanoidRootPart") ~= nil then
			local FirstCFrame = char:FindFirstChild("HumanoidRootPart").Position -- Get player's first position
			wait(1)
			local SecondCFrame = char:FindFirstChild("HumanoidRootPart").Position -- Get player9s second position after wait(1)
			
			local CFrameDifference = (FirstCFrame - SecondCFrame).Magnitude --Get the difference of positions
			
			if CFrameDifference < 0 then -- If difference is below 0
				local CFrameDifference =  (FirstCFrame - SecondCFrame) * (-1) -- Change it to positive value
			end
			
			if char:FindFirstChild("Humanoid") then --If Humanoid exists then
				local LocalWalkspeed = char:FindFirstChild("Humanoid").WalkSpeed -- Get players local walkspeed (local walkspeed determines how many studs player create on second)
                if math.floor(CFrameDifference) > LocalWalkspeed then -- If difference of positions is higher then his local walkspeed then
	                if char:FindFirstChild("Humanoid").FloorMaterial ~= Enum.Material.Air then -- If player is touching the ground
		                counter.Value = counter.Value + 1 -- Add a caught to counter
	                end
                end
			end
			
			if counter.Value > MaxCaughts then -- If player passes max counter then
				if char:FindFirstChild("Humanoid") then -- If Humanoid still exsits
					warn("Exploit detected at player: " .. plr.Name) -- warn it to console
					plr:Kick("We caught you exploiting.") -- Kick player from game
					-- Do whatever you want to do to player who was detected exploiting
					if script:FindFirstChild(plr.Name) then 
					   script[plr.Name]:Destroy() -- Destroy player from script in ServerScriptService (IMPORTANT: Make sure you keep this in this if statment)
					   break
				    end
				end
		     end
				 
			  else
				
			if char:FindFirstChild("Humanoid") then -- If Humanoid still exsits
					warn("Exploit detected at player: " .. plr.Name) -- warn it to console
					plr:Kick("We caught you exploiting.") -- Kick player from game
					-- Do whatever you want to do to player who was detected exploiting
					if script:FindFirstChild(plr.Name) then 
					   script[plr.Name]:Destroy() -- Destroy player from script in ServerScriptService (IMPORTANT: Make sure you keep this in this if statment)
					   break
				    end
				end
			end
		end
	end)
end)
