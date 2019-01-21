--Fallen Pegasus Omicron
function c90001608.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,c90001608,xyzfilter,5,2)
	c:EnableReviveLimit()
end

--xyz filter
function c90001608.xyzfilter(c)
return Duel.GetFlagEffect(c:GetControler(),90001608)==0 and c:IsRace(RACE_BEAST)