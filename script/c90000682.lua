--Fallen Pegasus Omicron
function c90000682.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2,c90000682.ovfilter,aux.Stringid(90000682,0))
	c:EnableReviveLimit()
	--protection
end

--xyz filter
function c90000619.ovfilter(c)
	local rk=c:GetRank()
	return c:IsFaceup() and (rk==5 or rk==6) and c:IsRace(RACE_BEAST)
end