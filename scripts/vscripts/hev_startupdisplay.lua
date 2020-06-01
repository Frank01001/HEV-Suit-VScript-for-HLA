--=========================================--
-- Bootup Sequence Script :: by Frank01001 --
--=========================================--

-- Version 1.0 : Just works

-- Sequence step
local bootup_sequence_status = 0

-- =================== --
--		 Entities	   --
-- =================== --
-- Title (upper-center)
local text_title
-- Os Version (upper-center, immediately under title)
local text_subtitle
-- Subsystem init informer (lower-center)
local text_bottom
-- Rotating HEV Suit wireframe model
local suit_model
-- Text above and under suit
local text_suit_up, text_suit_down
-- Show off paths 
local text_paths

-- Table of startup messages
local startup_messages = {"H.E.V. (Hazardous Enviroments Vehicle) Mark IV", --title
						  "OS V4.2.124 firmware v0.8 2006-7", -- subtitle
						  "Standby for Main Systems Startup", -- centre
						  "REACTIVE ARMOR SYSTEM", -- side header
						  "MULTIDIRECTIONAL SENSORY ARRAYS", 
						  "HIGH IMPACT ABSORPTION/DISTRIBUTION GRID", 
						  "POWER MANAGEMENT UTILITY", 
						  "USER #ID 4190 - VANCE", -- above suit
						  "HEIGHT: 5FT 5.276 IN", -- under suit
						  "WEIGHT: 111 LB", -- under suit
						  "CALCULATING FIT ADJUSTMENTS", -- under suit
						  "DONE.", -- under suit
						  "USER #ID 4190 - VANCE, ALYX", -- above suit, update
						  "ATMOSPHERIC CONTAMINANT SENSORS", -- side header
						  "SENSOR ARRAYS",
						  "GEIGER-MULLER INSTRUMENT",
						  "AUTOMATIC MEDICAL SYSTEM COMPONENTS", -- side header
						  "BIOMETRIC MONITORING SYSTEMS",
						  "MORPHINE ADMINISTRATION SYSTEM",
						  "ANTITOXIN ADMINISTRATION SYSTEM",
						  "DEFENSIVE WEAPON SELECTION SYSTEM", -- side header
						  "WEAPONS REGISTRY/DATABASE",
						  "MENU SELECTION",
						  "ACQUISITION DETECTION SENSORS (PALMS)",
						  "<MISSING ENTRY ///>", -- twice N/A
						  "MUNITION LEVEL MONITORING", -- side header
						  "MUNITIONS DETECTION AND MONITOR PROTOCOL",
						  "ONBOARD COMMUNICATIONS SYSTEMS", -- side header
						  "WIRELESS RADIO MICROPHONE/RECEIVER",
						  "DALSYS TELECOM TRANSMITTER/RECEIVER",
						  "DALSYS SECURITY NETWORK INTERFACE",
						  "VOICE SYSTEM READOUT",
						  "HAVE A VERY SAFE DAY"} -- under suit
						  
-- Table of show off paths
local paths = {"C:/HEV/system/sensors/stir/testinit.exe",
			   "C:/HEV/system/pgrm/util/X198.exe",
			   "C:/HEV/programs/voice/hev_klv.rom",
			   "C:/HEV/mnge/diagnostic/h422.exe",
			   "C:/HEV/system/addons/v1950/deoccheck.exe",
			   "C:/MATS/{99A016E1-0840-43AE-8434-A18CEDEA8}",
			   "C:/HEV/integrations/russel/grav_gloves.exe"}


function Activate()
	text_title = Entities:FindByName(nil, "HEV_UI_TITLE")
	text_subtitle = Entities:FindByName(nil, "HEV_UI_SUBTITLE")
	
	text_paths = Entities:FindByName(nil, "HEV_UI_PATHS")
	
	text_suit_up = Entities:FindByName(nil, "HEV_UI_SUITUP")
	suit_model = Entities:FindByName(nil, "HEV_UI_Model")
	text_suit_down = Entities:FindByName(nil, "HEV_UI_SUITDOWN")
	
	text_bottom = Entities:FindByName(nil, "HEV_UI_BOTTOM")
	
	-- Set update function
	thisEntity:SetContextThink(nil, UpdateText, 0)
end

-- Call from a trigger to start the visual sequence (1.5 seconds of delay are reccomended for syncronization with audio track)
function StartBootup()
	bootup_sequence_status = 1;
end

-- Update function
function UpdateText()
	-- Really poor code, I know... but substrings and other string functions didn't seem to work, so I got lazy
	if bootup_sequence_status > 0 and bootup_sequence_status <= 34 then
		if bootup_sequence_status == 1 then --title
			text_title:SetMessage(startup_messages[1])
			
		elseif bootup_sequence_status == 2 then --subtitle
			text_subtitle:SetMessage(startup_messages[2])
			
		elseif bootup_sequence_status == 3 then --paths
			text_paths:SetMessage(startup_messages[3])
			
		elseif bootup_sequence_status == 4 then 
			text_paths:SetMessage(startup_messages[3].."\n\n"..paths[1])
			text_bottom:SetMessage(startup_messages[4])
			
		elseif bootup_sequence_status == 5 then 
			text_paths:SetMessage(startup_messages[3].."\n\n"..paths[1].."\n"..paths[2])
			text_bottom:SetMessage(startup_messages[4].."\n\n"..startup_messages[5])
			
		elseif bootup_sequence_status == 6 then 
			text_paths:SetMessage(startup_messages[3].."\n\n"..paths[1].."\n"..paths[2].."\n"..paths[3])
			text_bottom:SetMessage(startup_messages[4].."\n\n"..startup_messages[5].."\n"..startup_messages[6])
			
		elseif bootup_sequence_status == 7 then 
			text_paths:SetMessage(startup_messages[3].."\n\n"..paths[1].."\n"..paths[2].."\n"..paths[3].."\n"..paths[4])
			text_bottom:SetMessage(startup_messages[4].."\n\n"..startup_messages[5].."\n"..startup_messages[6].."\n"..startup_messages[7])
			
		elseif bootup_sequence_status == 8 then 
			text_paths:SetMessage(startup_messages[3].."\n\n"..paths[1].."\n"..paths[2].."\n"..paths[3].."\n"..paths[4].."\n"..paths[5])
			suit_model:SetOrigin(text_suit_up:GetOrigin() - Vector(0.0, 0.0, 5.0))
			text_suit_up:SetMessage(startup_messages[8])
			
		elseif bootup_sequence_status == 9 then 
			text_paths:SetMessage(startup_messages[3].."\n\n"..paths[1].."\n"..paths[2].."\n"..paths[3].."\n"..paths[4].."\n"..paths[5].."\n"..paths[6])
			text_suit_down:SetMessage(startup_messages[9])
			
		elseif bootup_sequence_status == 10 then 
			text_paths:SetMessage(startup_messages[3].."\n\n"..paths[1].."\n"..paths[2].."\n"..paths[3].."\n"..paths[4].."\n"..paths[5].."\n"..paths[6].."\n"..paths[7])
			text_suit_down:SetMessage(startup_messages[9].."\n"..startup_messages[10])
			
		elseif bootup_sequence_status == 11 then 
			text_suit_down:SetMessage(startup_messages[9].."\n"..startup_messages[10].."\n"..startup_messages[11])
			
		elseif bootup_sequence_status == 12 then 
			text_suit_down:SetMessage(startup_messages[9].."\n"..startup_messages[10].."\n"..startup_messages[11].."\n"..startup_messages[12])
			
		elseif bootup_sequence_status == 13 then 
			text_suit_up:SetMessage(startup_messages[13])
			
		elseif bootup_sequence_status >= 14 and bootup_sequence_status <= 32 then 
			text_bottom:SetMessage(startup_messages[bootup_sequence_status])
		elseif bootup_sequence_status == 33 then 
			text_suit_down:SetMessage(startup_messages[33])
		end
	
	-- End of sequence, hide everything
	elseif bootup_sequence_status >= 37 then
		text_suit_up:SetMessage("")
		text_suit_down:SetMessage("")
		text_bottom:SetMessage("")
		text_paths:SetMessage("")
		text_subtitle:SetMessage("")
		text_title:SetMessage("")
		suit_model:SetOrigin(suit_model:GetOrigin() - Vector(0.0, 0.0, 1024))
	end
	
	if bootup_sequence_status > 0 and bootup_sequence_status <= 37 then
		bootup_sequence_status = bootup_sequence_status + 1
	end
	
	-- Delay between one step in the sequence and the other
	return 1.2
end