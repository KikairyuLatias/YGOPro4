--Sunbeast Kilina
local s,id=GetID()
function s.initial_effect(c)
	--materials and stuff
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_BEAST),2)
	c:EnableReviveLimit()
	--negate things
	--return up to 3 cards
	--floating	
end