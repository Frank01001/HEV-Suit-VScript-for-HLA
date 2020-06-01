--==========================================================================--
-- Hazardous Environments Vehicle Mark IV Suit HL:A Script :: by Frank01001 --
--==========================================================================--

-- Version 1.3 :: Fixed health sounds and death

--=========--
-- General --
--=========--
local isRunning = false
local power = 0
local lastWarning = ""

--=============================
-- Spawn is called by the engine whenever a new instance of an entity is created.  
-- Any setup code specific to this entity can go here
--=============================
function Spawn() 
	-- Registers a function to get called each time the entity updates, or "thinks"
	thisEntity:SetContextThink(nil, UpdateFunc, 0)
	ListenToGameEvent('player_health_pen_used', HEV_Antidote, self)
	ListenToGameEvent('player_grabbed_by_barnacle', HEV_MajLaceration, self)
	
	flLastTime = Time()
end

-- Call when the suit is worn
function HEV_Bootup()
	ScheduleSound("hev_suit.bell", 0.2)
	-- Custom sound, needs importing and inclusion in sound event
	ScheduleSound("hev_suit.bootup", 1.2)	
	isRunning = true
end

-- Call to activate without long initialization sequence
function HEV_BootupQuick()
	ScheduleSound("hev_suit.bell", 0.2)
	-- Custom sound, needs importing and inclusion in sound event
	isRunning = true
end

-- Sound needs to be included manually
function HEV_OutAmmo()
	
	if not isRunning then
		return
	end
	
	ScheduleSound("hev_suit.ammo_depleted", 0.2)
end

function HEV_Antidote()
	if not isRunning then
		return
	end
	ScheduleSound("hev_suit.antidote_shot", 0.3)
end

-- Read health information if necessary
function HEV_Health(delay)
	if not isRunning then
		return
	end

	local localPlayer = Entities:GetLocalPlayer()
	local health

	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	if not localPlayer:IsAlive() then
		return
	end
	
	if health <= 6 and lastWarning ~= "health_death" then
		ScheduleSound("Midi.BeepTestSingle", 0.3 + delay)
		ScheduleSound("Midi.BeepTestSingle", 0.3)
		ScheduleSound("Midi.BeepTestSingle", 0.3)
		ScheduleSound("hev_suit.near_death", 1.4)
		lastWarning = "health_death"
		return
	elseif health <= 30 and lastWarning ~= "health_critical" and lastWarning ~= "health_death" then
		ScheduleSound("Midi.BeepTestSingle", 0.3 + delay)
		ScheduleSound("Midi.BeepTestSingle", 0.3)
		ScheduleSound("Midi.BeepTestSingle", 0.3)
		ScheduleSound("hev_suit.health_critical", 0.8)
		ScheduleSound("hev_suit.seek_medic", 3.0)
		lastWarning = "health_critical"
		return
	elseif health <= 50 and lastWarning ~= "health_dropping" and lastWarning ~= "health_critical" and lastWarning ~= "health_death" then
		ScheduleSound("Midi.BeepTestSingle", 0.3 + delay)
		ScheduleSound("Midi.BeepTestSingle", 0.3)
		ScheduleSound("hev_suit.health_dropping", 1.0)
		lastWarning = "health_dropping"
		return
	end
	
end

-- Read a percetage
function HEV_Number(num, delay)

	local localPlayer = Entities:GetLocalPlayer()
	
	num_left = math.floor(num / 10)
	num_right = num % 10
	
	if num == 15 then
		ScheduleSound("hev_suit.fifteen", delay)
		ScheduleSound("hev_suit.percent", 1.9 + delay)
		return
	end
	
	if num_left == 1 then
		ScheduleSound("hev_suit.ten", delay)
	elseif num_left == 2 then
		ScheduleSound("hev_suit.twenty", delay)
	elseif num_left == 3 then
		ScheduleSound("hev_suit.thirty", delay)
	elseif num_left == 4 then
		ScheduleSound("hev_suit.fourty", delay)
	elseif num_left == 5 then
		ScheduleSound("hev_suit.fifty", delay)
	elseif num_left == 6 then
		ScheduleSound("hev_suit.sixty", delay)
	elseif num_left == 7 then
		ScheduleSound("hev_suit.seventy", delay)
	elseif num_left == 8 then
		ScheduleSound("hev_suit.eighty", delay)
	elseif num_left == 9 then
		ScheduleSound("hev_suit.ninety", delay)
	elseif num_left == 10 then
		ScheduleSound("hev_suit.onehundred", delay)
	end
	
	if num_right >= 5 then
		-- Worst case scenario is probably "seventy"
		ScheduleSound("hev_suit.five", 1.2)
	end
	
	ScheduleSound("hev_suit.percent", 1.0)
	
end

--=========================--
-- Environments and Events --
--=========================--
local isFirstFracture = true

-- Call from a trigger
function HEV_Radiation()
	if not isRunning then
		return
	end
	
	local localPlayer = Entities:GetLocalPlayer()
	local health

	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	if health > 50 and lastWarning ~= "radiation" then
		lastWarning = "radiation"
		ScheduleSound("hev_suit.blip", 0.1)
		ScheduleSound("hev_suit.blip", 0.1)
		ScheduleSound("hev_suit.blip", 0.1)
		ScheduleSound("hev_suit.radiation_detected", 1.2)
	else
		HEV_Health(1.2)
	end
end

function HEV_Heat()
	if not isRunning then
		return
	end
	local localPlayer = Entities:GetLocalPlayer()
	local health
	
	
	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	if lastWarning ~= "heat" then
		lastWarning = "heat"
		ScheduleSound("hev_suit.blip", 0.3)
		ScheduleSound("hev_suit.blip", 0.3)
	end
	HEV_Health(1.2)
end

function HEV_Biohazard()
	if not isRunning then
		return
	end
	local localPlayer = Entities:GetLocalPlayer()
	local health
	
	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	if health > 50 and lastWarning ~= "bio" then
		lastWarning = "bio"
		ScheduleSound("hev_suit.blip", 0.3)
		ScheduleSound("hev_suit.blip", 0.3)
		ScheduleSound("hev_suit.blip", 0.3)
		ScheduleSound("hev_suit.biohazard_detected", 1.2)
	else
		HEV_Health(1.2)
	end
end

function HEV_Electricity()
	if not isRunning then
		return
	end
	
	local localPlayer = Entities:GetLocalPlayer()
	local health

	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	lastHealth = health
	
	if health > 50 and lastWarning ~= "shock" then
		lastWarning = "shock"
		ScheduleSound("hev_suit.blip", 0.3)
		ScheduleSound("hev_suit.blip", 0.3)
		ScheduleSound("hev_suit.warning", 1.5)
		ScheduleSound("hev_suit.shock_damage", 1.2)
	else
		HEV_Health(1.2)
	end
end

-- Fall
function HEV_MinFracture()
	if not isRunning then
		return
	end
	
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.minor_fracture", 1.2)
end

-- Fall
function HEV_MajFracture()
	if not isRunning then
		return
	end
	
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.major_fracture", 1.2)
	
	if isFirstFracture then
		isFirstFracture = false
		ScheduleSound("hev_suit.automedic_on", 4.0)
		ScheduleSound("hev_suit.hiss", 3.0)
		ScheduleSound("hev_suit.morphine_shot", 1.0)
	else
		HEV_Health(4.0)
	end
end

-- Bullets
function HEV_BloodLoss()
	if not isRunning then
		return
	end
	
	if lastWarning ~= "blood_loss" then
		lastWarning = "blood_loss"
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.blood_loss", 1.2)
	end
	
	HEV_Health(4.0)
end

-- Blood Toxins
function HEV_Toxins()
	if not isRunning then
		return
	end
	
	if lastWarning ~= "blood_toxins" then
		lastWarning = "blood_toxins"
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.blood_loss", 1.2)
	end
	
	HEV_Health(4.0)
end

-- Headcrab
function HEV_MinLaceration()
	if not isRunning then
		return
	end
	
	if lastWarning ~= "laceration" then
		lastWarning = "laceration"
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.minor_lacerations", 1.2)
		ScheduleSound("hev_suit.wound_sterilized", 2.0)
	end
	
	HEV_Health(4.0)
end

-- Big slash
function HEV_MajLaceration()
	if not isRunning then
		return
	end
	
	if lastWarning ~= "laceration" then
		lastWarning = "laceration"
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.major_lacerations", 1.2)
		
	end
	HEV_Health(4.0)
end

-- Sonic shockwave
function HEV_Bleed()
	if not isRunning then
		return
	end
	
	if lastWarning ~= "bleeding" then
		lastWarning = "bleeding"
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.internal_bleeding", 1.2)	
	end
	
	HEV_Health(4.0)
end

-- Chemical
function HEV_Chem()
	if not isRunning then
		return
	end
	
	if lastWarning ~= "chem" then
		lastWarning = "chem"
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.boop", 0.3)
		ScheduleSound("hev_suit.chemical_detected", 1.2)
	end
	HEV_Health(4.0)
end

-- On User Death
function HEV_Death()
	local localPlayer = Entities:GetLocalPlayer()
	EmitSoundOn("hev_suit.flatline", localPlayer)
end

--==========--
-- Charging --
--==========--

function HEV_Battery()
	if not isRunning then
		return
	end
	
	power = power + 25
	if power >= 100 then
		power = 100
		ScheduleSound("hev_suit.fuzz", 0.2)
		ScheduleSound("hev_suit.fuzz", 0.2)
		ScheduleSound("hev_suit.power_restored", 1.2)
		ScheduleSound("hev_suit.boop", 0.3)
	else
		ScheduleSound("hev_suit.fuzz", 0.2)
		ScheduleSound("hev_suit.fuzz", 0.2)
		ScheduleSound("hev_suit.power_level_is", 1.2)
		HEV_Number(power, 2.5)
	end
	
end

--=======--
-- Utils --
--=======--
-- Flashlight sound
function HEV_Flashlight()
	local localPlayer = Entities:GetLocalPlayer()
	
	EmitSoundOn("hev_suit.flashlight", localPlayer)
end

-- Sound Scheduling System 
local flLastTime = 0.0
local scheduledCount = 0
local scheduledSounds = {}
local scheduledDelays = {}
local lastHealth = 100

function UpdateFunc()
	local flTime = Time()
	
	local localPlayer = Entities:GetLocalPlayer()
	local health

	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	if health - lastHealth < 0 and localPlayer:IsAlive() then
		HEV_Health(0.8)
	elseif not localPlayer:IsAlive() and isRunning then
		local scheduledCount = 0
		local scheduledSounds = {}
		local scheduledDelays = {}
		HEV_Death()
		isRunning = false
	end
	
	-- Sound update
	if isRunning and scheduledCount > 0 then
		
		if flTime - flLastTime >= scheduledDelays[1] then
			local localPlayer = Entities:GetLocalPlayer()
			EmitSoundOn(scheduledSounds[1], localPlayer)
			table.remove(scheduledDelays, 1)
			table.remove(scheduledSounds, 1)
			scheduledCount = scheduledCount - 1
			flLastTime = flTime
		end
		
	end
	
	lastHealth = health
	
	-- Return the amount of time to wait before calling this function again.
	return 0.1
end

function ScheduleSound(name, delay)
	table.insert(scheduledDelays, delay)
	table.insert(scheduledSounds, name)
	scheduledCount = scheduledCount + 1
end
