-- Number 119: Blizzard Flyer - Shirayuki
function c90001234.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c90001234.mfilter,4,2,c90001234.ovfilter,aux.Stringid(90001234,0),3,c90001234.xyzop)
	c:EnableReviveLimit()
	--while I have Xyz, my friends are safe
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetCondition(c90001234.dscon)
	e1:SetValue(c90001234.atlimit)
	c:RegisterEffect(e1)	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90001234.tglimit)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--stat boosting
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c90001234.tg)
	e3:SetValue(c90001234.val)
	c:RegisterEffect(e3)
	--def up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetValue(c90001234.val)
	e4:SetTarget(c90001234.tg)
	c:RegisterEffect(e4)
	--WINTER IS COMING!
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(90001234,1))
	e5:SetCategory(CATEGORY_DISABLE)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCost(c90001234.discost)
	e5:SetTarget(c90001234.distg)
	e5:SetOperation(c90001234.disop)
	c:RegisterEffect(e5)
end
c90001234.xyz_number=119
--filter on summon
function c90001234.mfilter(c)
return c:IsRace(RACE_BEAST) and c:IsAttribute(ATTRIBUTE_LIGHT)
end

function c90001234.ovfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsSetCard(0x4c9) and not c:IsCode(90001234)
end
function c90001234.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,90001234)==0 end
	Duel.RegisterFlagEffect(tp,90001234,RESET_PHASE+PHASE_END,0,1)
end

--protection from attack
function c90001234.atlimit(e,c)
	return c~=e:GetHandler()
end
function c90001234.tglimit(e,c)
	return c~=e:GetHandler()
end
function c90001234.dscon(e)
	return e:GetHandler():GetOverlayCount()~=0
end

--boost
function c90001234.tg(e,c)
	return c:IsSetCard(0x4c9) and c:IsType(TYPE_MONSTER)
end
function c90001234.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x4c9)
end
function c90001234.val(e,c)
	return Duel.GetMatchingGroupCount(c90001234.filter,c:GetControler(),LOCATION_MZONE,0,nil)*100
end

--negate
function c90001234.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c90001234.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.disfilter1,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c90001234.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.disfilter1,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end