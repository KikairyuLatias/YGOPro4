--Dreamlight Tenko
function c90000440.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x5f7),3,3,c90000440.lcheck)
	c:EnableReviveLimit()
	--nine tails goes on rampage (add later)
	--proc
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(c90000440.unaffectedval)
	e2:SetCondition(c90000440.tgcon)
	c:RegisterEffect(e2)
end

--summon cond
function c90000440.lcheck(g,lc,tp)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end

--don't even bother, opponent
function c90000440.unaffectedval(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end

	--proc con
	function c90000440.tgcon(e)
		return e:GetHandler():GetLinkedGroupCount()>0
	end
