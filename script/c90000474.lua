--Eclipse Dream Delphinite
function c90000474.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c90000474.lcheck)
	c:EnableReviveLimit()
	--zero battle damage with Eclipse Dream
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c90000474.efilter)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--special summon member
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(90000474,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c90000474.target)
	e3:SetOperation(c90000474.operation)
	c:RegisterEffect(e3)
end
--req
function c90000474.lcheck(g,lc)
	return g:IsExists(Card.IsSetCard,1,nil,0x5f9)
end
--zero damage
function c90000474.efilter(e,c)
	return c:IsSetCard(0x5f9)
end
--ss condition
function c90000474.filter(c,e,tp)
	return c:IsSetCard(0x5f9) and c:IsAttackBelow(2300) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone) and not c:IsCode(90000474)
end
function c90000474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=Duel.GetZoneWithLinkedCount(1,tp)&0x1f
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_HAND+LOCATION_GRAVE) and c90000474.filter(chkc,e,tp,zone) end
	if chk==0 then return Duel.IsExistingTarget(c90000474.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c90000474.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp,zone)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c90000474.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local zone=Duel.GetZoneWithLinkedCount(1,tp)&0x1f
	if tc and tc:IsRelateToEffect(e) and zone~=0  then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end