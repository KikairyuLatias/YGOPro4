--Superstar Pony Duelist Uli'ahikalani
local s,id=GetID()
function s.initial_effect(c)
	Pendulum.AddProcedure(c)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)  
end