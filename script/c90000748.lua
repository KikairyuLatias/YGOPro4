--Moon Bunny
function c90000748.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c90000748.lcheck)
	c:EnableReviveLimit()
	--unaffected
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(s.indtg)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--banish
end

--condition
function c90000748.lcheck(g,lc)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end

--protection
function s.indtg(e,c)
	return e:GetHandler():GetLinkedGroup():IsContains(c)
end