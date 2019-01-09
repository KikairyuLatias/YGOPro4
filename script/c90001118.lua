-- Diver Deer Master Salvia
function c90001118.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x4af),3)
	c:EnableReviveLimit()
	--targeting immunity
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--shuffle stuff into deck (WIP)
	--multiple strike (WIP)
	end
--because I can get into places you can't
function c90001118.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end
