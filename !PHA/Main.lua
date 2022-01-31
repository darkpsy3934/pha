local _,PetHealthAlert=...
local Frame=CreateFrame("ScrollingMessageFrame","!PHA",UIParent)	
Frame.Threshold=35
Frame.Warned=false
-- Initialize
function PetHealthAlert:Initialize()	
	Frame:SetWidth(450)
	Frame:SetHeight(200)
	Frame:SetPoint("CENTER",UIParent,"CENTER",0,0)	
	Frame:SetFont("Interface\\AddOns\\!PHA\\Res\\PHA_.TTF",30,"THICKOUTLINE")
	Frame:SetShadowColor(0.00,0.00,0.00,0.75)
	Frame:SetShadowOffset(3.00,-3.00)
	Frame:SetJustifyH("CENTER")		
	Frame:SetMaxLines(2)
	--Frame:SetInsertMode("BOTTOM")
	Frame:SetTimeVisible(2)
	Frame:SetFadeDuration(1)		
	HealthWatch:Update()
end
-- Update health warning
function PetHealthAlert:Update()	
	if(floor((UnitHealth("pet")/UnitHealthMax("pet"))*100)<=Frame.Threshold and Frame.Warned==false)then
		PlaySoundFile("Interface\\AddOns\\!PHA\\Res\\PHA.ogg")	
		Frame:AddMessage("- CRITICAL PET HEALTH -", 1, 0, 0, nil, 3)
		Frame.Warned=true
		return
	end
	if(floor((UnitHealth("pet")/UnitHealthMax("pet"))*100)>Frame.Threshold)then
		Frame.Warned=false
		return
	end	
end
-- Handle events
function PetHealthAlert:OnEvent(Event,Arg1,...)
	if(Event=="PLAYER_LOGIN")then
		PetHealthAlert:Initialize()
		return
	end	
	if(Event=="UNIT_HEALTH" and Arg1=="pet")then
		PetHealthAlert:Update()
		return
	end	
end
Frame:SetScript("OnEvent",PetHealthAlert.OnEvent)
Frame:RegisterEvent("PLAYER_LOGIN")
Frame:RegisterEvent("UNIT_HEALTH")
