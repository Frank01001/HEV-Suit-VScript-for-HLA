--======================================================================--
-- Hazardous Environments Vehicle Mark IV Suit HL:A Script :: Frank01001--
--======================================================================--

-- Version 1.0 :: Basic implementation. Still waiting for VScript documentation on UI

--=========--
-- General --
--=========--
local isRunning = false
local power = 0

--=============================
-- Spawn is called by the engine whenever a new instance of an entity is created.  
-- Any setup code specific to this entity can go here
--=============================
function Spawn() 
	-- Registers a function to get called each time the entity updates, or "thinks"
	thisEntity:SetContextThink(nil, SoundThink, 0)
	flLastTime = Time()
end

-- Call when the suit is worn
function HEV_Bootup()
	ScheduleSound("hev_suit.bell", 0.2)
	-- Custom sound, needs importing and inclusion in sound event
	ScheduleSound("hev_suit.bootup", 1.2)	
	isRunning = true
end

function HEV_Health(delay)
	local localPlayer = Entities:GetLocalPlayer()
	local health

	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	if health <= 6 then
		ScheduleSound("hev_suit.beep", 0.3 + delay)
		ScheduleSound("hev_suit.beep", 0.3)
		ScheduleSound("hev_suit.beep", 0.3)
		ScheduleSound("hev_suit.near_death", 1.4)
	elseif health <= 30 then
		ScheduleSound("hev_suit.beep", 0.3 + delay)
		ScheduleSound("hev_suit.beep", 0.3)
		ScheduleSound("hev_suit.beep", 0.3)
		ScheduleSound("hev_suit.health_critical", 0.8)
		ScheduleSound("hev_suit.seek_medic", 3.0)
	elseif health <= 50 then
		ScheduleSound("hev_suit.beep", 0.3 + delay)
		ScheduleSound("hev_suit.beep", 0.3)
		ScheduleSound("hev_suit.health_dropping", 1.0)
	end

end

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

function HEV_Radiation()
	--todo implement geiger counter
	
	local localPlayer = Entities:GetLocalPlayer()
	local health

	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	health = health - 20
	localPlayer:SetHealth(health)
	
	ScheduleSound("hev_suit.blip", 0.1)
	ScheduleSound("hev_suit.blip", 0.1)
	ScheduleSound("hev_suit.blip", 0.1)
	
	if health > 50 then
		ScheduleSound("hev_suit.radiation_detected", 1.2)
	else
		HEV_Health(1.2)
	end
end

function HEV_Heat()
	local localPlayer = Entities:GetLocalPlayer()
	local health
	
	
	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	health = health - 20
	localPlayer:SetHealth(health)
	
	ScheduleSound("hev_suit.blip", 0.3)
	ScheduleSound("hev_suit.blip", 0.3)
	HEV_Health(1.2)
end

function HEV_Biohazard()
	local localPlayer = Entities:GetLocalPlayer()
	local health
	
	
	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	health = health - 20
	localPlayer:SetHealth(health)
	
	ScheduleSound("hev_suit.blip", 0.3)
	ScheduleSound("hev_suit.blip", 0.3)
	ScheduleSound("hev_suit.blip", 0.3)
	
	if health > 50 then
		ScheduleSound("hev_suit.biohazard_detected", 1.2)
	else
		HEV_Health(1.2)
	end
end

function HEV_Electricity()
	local localPlayer = Entities:GetLocalPlayer()
	local health

	if localPlayer ~= nil then
		health = localPlayer:GetHealth()
	end
	
	health = health - 20
	localPlayer:SetHealth(health)
	
	ScheduleSound("hev_suit.blip", 0.3)
	ScheduleSound("hev_suit.blip", 0.3)
	
	if health > 50 then
		ScheduleSound("hev_suit.warning", 1.5)
		ScheduleSound("hev_suit.shock_damage", 1.2)
	else
		HEV_Health(1.2)
	end
end

-- Fall
function HEV_MinFracture()
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.minor_fracture", 1.2)
end

-- Fall
function HEV_MajFracture()
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
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.blood_loss", 1.2)
	HEV_Health(4.0)
end

-- Headcrab
function HEV_MinLaceration()
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.minor_lacerations", 1.2)
	HEV_Health(4.0)
end

-- Big slash
function HEV_MajLaceration()
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.major_lacerations", 1.2)
	HEV_Health(4.0)
end

-- Sonic shockwave
function HEV_Bleed()
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.boop", 0.3)
	ScheduleSound("hev_suit.internal_bleeding", 1.2)
	HEV_Health(4.0)
end

--==========--
-- Charging --
--==========--

function HEV_Battery()
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

-- Sound Scheduling System 
local flLastTime = 0.0
local scheduledCount = 0
local scheduledSounds = {}
local scheduledDelays = {}

function SoundThink()
	local flTime = Time()
	
	if scheduledCount > 0 then
		if flTime - flLastTime >= scheduledDelays[1] then
			local localPlayer = Entities:GetLocalPlayer()
			EmitSoundOn(scheduledSounds[1], localPlayer)
			table.remove(scheduledDelays, 1)
			table.remove(scheduledSounds, 1)
			scheduledCount = scheduledCount - 1
			flLastTime = flTime
		end
		
	end
	
	-- Return the amount of time to wait before calling this function again.
	return 0.1
end

function ScheduleSound(name, delay)
	table.insert(scheduledDelays, delay)
	table.insert(scheduledSounds, name)
	scheduledCount = scheduledCount + 1
end
