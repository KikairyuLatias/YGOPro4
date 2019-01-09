-- Psychic Dragon Kasumi
function c90000207.initial_effect(c)
	--ind
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c90000207.indval)
	c:RegisterEffect(e1)
	--life gain
end

--protection
function c90000207.indval(e,c)
	return c:IsLevelBelow(4)
end
