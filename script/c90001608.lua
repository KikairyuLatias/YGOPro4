--Fallen Pegasus Omicron
function c90001608.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2,c90001608.ovfilter,aux.Stringid(90001608,0))
	c:EnableReviveLimit()
	--protection
end

--xyz filter
function c90000619.ovfilter(c)
	local rk=c:GetRank()
	return c:IsFaceup() and (rk==5 or rk==6) and c:IsRace(RACE_BEAST)
end