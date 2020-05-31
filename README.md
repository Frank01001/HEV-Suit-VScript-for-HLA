# HEV-Suit-VScript-for-HLA
A VScript for HEV Suit sounds in Half Life Alyx.

Hello. This is a tutorial on how to include the HEV Suit sounds vscript in your Half Life: Alyx custom maps. Download scripts “hev_suit.lua” and “radiation_field.lua” and place them in the /…/Half Life Alyx/game/hlvr_addons/your_addon/scripts/vscripts/. If the scripts and vscripts folder don’t exist, create them.

Some sounds are not included in the game (complete bootup sequence and ammo_depleted) while others, like the Geiger sounds, are included in the game but are included in a new soundevent file for easier use. Create a new soundevent (I called it hev_moresounds.vsndevts) and put it in /Half Life Alyx/common/hlvr_addons/your_addon/soundevents/ (create folder if missing). You can add the bootup and ammo_depleted sound yourself if you want them. (Ammo depleted is not currently working in the script anyway). After that, go in Asset Browser and select your sound event file, right click and select Full Recompile. My soundevent file is included in the soundevent folder of this repository, as are the extra sounds.

______________________________________________________________________________________

You can now open Hammer and place a logic_script in your map. Open properties Misc tab and type “hev_suit.lua” in “Entity Script”. The object needs a name, for example “HEVLogic”, so script functions can be called by triggers.
The first trigger you need is a trigger_once to give the suit to the player. Just add a logic Output to the trigger. In alternative, if you want the player to have the suit from the beginning, you can also use a logic_auto.

Use the following Output:
- My Output Named: OnTrigger
- Target entities named: HEVLogic
- Via this input: CallScriptFunction
- With a parameter override of: HEV_BootupQuick

If you call the HEV_Bootup function, it will play the complete bootup sequence (if you have imported it). If you just want the quick bootup, to get started immediately, use HEV_BootupQuick. This allows for health events (vital signs dropping, critical, user death, barnacle choke, ecc.). You can get move events using a logic_playerproxy. You can set the bootup trigger to also give you Gordon gloves using the player proxy. Also, you can add some cool HEV Suit events:

Antilion Worker spit warning:
- My Output Named: OnPlayerHitBySpit
- Target entities named: HEVLogic
- Via this input: CallScriptFunction
- With a parameter override of: HEV_Chem

Alyx cough:
- My Output Named: OnPlayerCoughed
- Target entities named: HEVLogic
- Via this input: CallScriptFunction
- With a parameter override of: HEV_Toxins

Flashlight on sound:
- My Output Named: OnFlashlightOn
- Target entities named: HEVLogic
- Via this input: CallScriptFunction
- With a parameter override of: HEV_Flashlight

Finally, you can create as many trigger_hurt as you want to create radioactive/electric damage/biohazard/heat zones. 
You can set damage values and damage type (RADIATION, SHOCK, BURN, ...) in the Object Properties. This however, will not trigger an environmental warning by itself. In fact, you will also have to add a Logic output to the trigger:

- My Output Named: OnHurtPlayer
- Target entities named: HEVLogic
- Via this input: CallScriptFunction
- With a parameter override of: HEV_Radiation

Other types of HEV warning calls are HEV_Chem (chemical hazard), HEV_Biohazard, HEV_Heat, HEV_Electricity.

In addition, the script “radiation_field.lua” can be attached to another logic_script to play Geiger counter sounds when inside a radiation trigger_hurt. I called the logic_script object “RAD1”. Calling EnterZone starts the Geiger sounds, calling LeaveZone makes it stop. If you want to have a field with more intense radiation, you can create another trigger_hurt (which NEEDS to be ENTIRELY contained inside the other one to work) and call functions EnterCritical for OnStartTouch and LeaveCritical for OnEndTouch. 

Low Radiation Trigger:
- My Output Named: OnStartTouch                     - My Output Named: OnEndTouch
- Target entities named: RAD1                       - Target entities named: RAD1
- Via this input: CallScriptFunction                - Via this input: CallScriptFunction
- With a parameter override of: EnterZone           - With a parameter override of: LeaveZone

High Radiation Trigger:
- My Output Named: OnStartTouch                     - My Output Named: OnEndTouch
- Target entities named: RAD1                       - Target entities named: RAD1
- Via this input: CallScriptFunction                - Via this input: CallScriptFunction
- With a parameter override of: EnterCritical       - With a parameter override of: LeaveCritical


