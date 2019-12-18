--Number 118: Phoenix Guardian - Hellfire Incarnate
function c90000875.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x641),4,2,nil,nil,7)
	c:EnableReviveLimit()
	--destroy then detach
	--burn (level only)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000875,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c90000875.condition2)
	e2:SetTarget(c90000875.target2)
	e2:SetOperation(c90000875.operation2)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--for xyz
end
--burn
function c90000875.condition2(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:FilterCount(Card.IsSetCard,nil,0x641)>0
end
	--for level
	function c90000875.target2(e,tp,eg,ep,ev,re,r,rp,chk)
		if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
		Duel.SetTargetCard(eg)
		tc=eg:GetFirst()
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(tc:GetLevel()*200)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetLevel()*200)
	end
	function c90000875.operation2(e,tp,eg,ep,ev,re,r,rp)
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end