--Eclipse Dream Tech Raiden
function c90000472.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x5f9),2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c90000472.descon)
	e1:SetTarget(c90000472.destg)
	e1:SetOperation(c90000472.desop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c90000472.tg)
	e2:SetValue(c90000472.val)
	c:RegisterEffect(e2)
	--def up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(c90000472.val)
	e3:SetTarget(c90000472.tg)
	c:RegisterEffect(e3)
		--atk down
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD)
		e4:SetCode(EFFECT_UPDATE_ATTACK)
		e4:SetRange(LOCATION_MZONE)
		e4:SetTargetRange(0,LOCATION_MZONE)
		e4:SetValue(c90000472.val2)
		c:RegisterEffect(e4)
		--def down
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD)
		e5:SetCode(EFFECT_UPDATE_DEFENSE)
		e5:SetRange(LOCATION_MZONE)
		e5:SetTargetRange(0,LOCATION_MZONE)
		e5:SetValue(c90000472.val2)
		c:RegisterEffect(e5)
end
--destruction for Eclipse Dream
function c90000472.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return ep~=tp and tc:IsControler(tp) and tc:IsSetCard(0x5f9)
end
function c90000472.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.SelectTarget(tp,Card.IsRemovable,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c90000472.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEDOWN,REASON_EFFECT)
	end
end
--boost
function c90000472.tg(e,c)
	return c:IsSetCard(0x5f9) and c:IsType(TYPE_MONSTER)
end
function c90000472.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5f9)
end
function c90000472.val(e,c)
	return Duel.GetMatchingGroupCount(c90000472.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c90000472.val2(e,c)
	return Duel.GetMatchingGroupCount(c90000472.filter,c:GetControler(),0,LOCATION_MZONE,nil)*-200
end