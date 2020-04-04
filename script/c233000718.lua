--Skateboard Dragon Hyakunichisou
local s,id=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),3,2)
	c:EnableReviveLimit()
	--stat drop
	--usual bouncing
	--kill the ED
end
