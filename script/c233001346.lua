--Blazefur Athlete Opening Ceremony
local s,id=GetID()
function s.initial_effect(c)
	--Ritual Summon
	local e1=Ritual.CreateProc(c,RITPROC_GREATER,aux.FilterBoolFunction(Card.IsCode,233001345),nil,nil,nil,nil,s.mfilter,nil,LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1,id)
	c:RegisterEffect(e1)
end
function s.mfilter(c)
	return c:IsLocation(LOCATION_HAND+LOCATION_MZONE)
end
