--Psychic Dragon Princess Latios
function c90000252.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(Card.IsRace,RACE_DRAGON),1,99)
	c:EnableReviveLimit()
	--added typing
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_RACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(RACE_PSYCHIC)
	c:RegisterEffect(e1)
	--burn
	--destroy something
end
