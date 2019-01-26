--Shinreiryu Final Dance
function c90000240.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000240,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,90000240+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c90000240.cost)
	e1:SetTarget(c90000240.target)
	e1:SetOperation(c90000240.operation)
	c:RegisterEffect(e1)
end
--burn
function c90000240.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x5f1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x5f1)
	e:SetLabel(g:GetFirst():GetLevel()*300)
	Duel.Release(g,REASON_COST)
end
function c90000240.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c90000240.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c90000240.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x5f1) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x5f1)
	e:SetLabelObject(g:GetFirst())
	Duel.Release(g,REASON_COST)
end