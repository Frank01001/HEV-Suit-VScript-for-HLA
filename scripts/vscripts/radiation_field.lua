--==============================================================================================--
-- Script to trigger geiger counter in radiation zones (needs sound event file) : by Frank01001 --
--==============================================================================================--

-- 0 is none, 1 is low, 2 is high
local radiationLevel = 0


function Spawn()
	-- Registers a function to get called each time the entity updates, or "thinks"
	thisEntity:SetContextThink(nil, UpdateField, 0)
	
end

function UpdateField()
	local localPlayer = Entities:GetLocalPlayer()
	
	local ran = math.random(-3,3)
	
	if radiationLevel == 1 then
		if ran == 3 or ran == 1 then
			EmitSoundOn("hev_suit.geiger_custom1", localPlayer)
		end
	elseif radiationLevel > 1 then
		if ran == 2 or ran == -3 then
			EmitSoundOn("hev_suit.geiger_custom2", localPlayer)
		end
	end
	
	-- 0.1 delay 'till next update
	return 0.1
end


-- Called by trigger to enter low radiation zone
function EnterZone()
	radiationLevel = 1
end

-- Called by trigger to leave radiation zone
function LeaveZone()
	radiationLevel = 0
end

-- Called by trigger to enter high radiation zone
function EnterCritical()
	radiationLevel = 2
end

-- Called by trigger to leave high radiation zone
function LeaveCritical()
	radiationLevel = 1
end
