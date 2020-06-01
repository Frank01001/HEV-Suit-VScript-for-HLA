--===============================================--
-- HEV Suit HUD Script for HL:A :: by Frank01001 --
--===============================================--

-- Really basic HUD, also you need another Trigger Output (I know, this is stupid, but I didn't want to clutter the hev_suit.lua script with optionals)

-- Radiation Indicator Entity (prop_dynamic)
local rad_indicator
-- Shock Indicator Entity (prop_dynamic)
local shock_indicator
-- Biohazard Indicator Entity (prop_dynamic)
local biohaz_indicator
-- Heat Indicator Entity (prop_dynamic)
local heat_indicator

-- Keep track of the current indicator to display the fading animation properly
local current_indicator = ""
-- 1 is positive growing alpha, -1 is negative, duh!
local trend = 1
-- Buffer variable to avoid calculating GetIndicatorAlpha 4 times (I'm mainly a C/C++ programmer, I had to optimize it)
local alphaBuffer


function Activate()
	-- Look for the Indicator entities
	rad_indicator = Entities:FindByName(nil, "HEV_UI_Radiation")
	shock_indicator = Entities:FindByName(nil, "HEV_UI_Shock")

	-- Set update function
	thisEntity:SetContextThink(nil, UpdateHud, 0)
end


function UpdateHud()
	
	if current_indicator ~= "" then
		-- Oscillate fading between 10 and 255 alpha values
		alphaBuffer = GetIndicatorAlpha(current_indicator)
		if alphaBuffer <= 10 then
			trend = 1
		elseif alphaBuffer >= 245 then
			trend = -1
		end
		
		SetIndicatorAlpha(current_indicator, alphaBuffer + trend)
	end
	return 0.1
end

-- Does what it says
function SetIndicatorAlpha(name, value)
	if name == "radiation" then
		rad_indicator:SetRenderAlpha(value)
	elseif name == "shock" then
		shock_indicator:SetRenderAlpha(value)
	elseif name == "biohazard" then
		biohaz_indicator:SetRenderAlpha(value)
	elseif name == "heat" then
		heat_indicator:SetRenderAlpha(value)
	end
end

-- Does what it says
function GetIndicatorAlpha(name)
	if name == "radiation" then
		return rad_indicator:GetRenderAlpha()
	elseif name == "shock" then
		return shock_indicator:GetRenderAlpha()
	elseif name == "biohazard" then
		return biohaz_indicator:GetRenderAlpha()
	elseif name == "heat" then
		returnheat_indicator:GetRenderAlpha()
	end
end

-- Call when leaving the trigger
function ClearIndicator()
	SetIndicatorAlpha(current_indicator, 0)
	current_indicator = ""
end

-- Call when entering the trigger
function RadiationIndicator()
	SetIndicatorAlpha(current_indicator, 0)
	current_indicator = "radiation"
end

-- Call when entering the trigger
function ShockIndicator()
	SetIndicatorAlpha(current_indicator, 0)
	current_indicator = "shock"
end

-- Call when entering the trigger
function BiohazardIndicator()
	SetIndicatorAlpha(current_indicator, 0)
	current_indicator = "biohazard"
end

-- Call when entering the trigger
function HeatIndicator()
	SetIndicatorAlpha(current_indicator, 0)
	current_indicator = "heat"
end