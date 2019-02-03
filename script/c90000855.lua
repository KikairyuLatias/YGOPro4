--Rider Deer Jun'i
function c90000855.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--replace me
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(90000855,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1)
	e1:SetTarget(c90000855.destg)
	e1:SetOperation(c90000855.desop)
	c:RegisterEffect(e1)
	--searcher
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,90000855)
	e2:SetTarget(c90000855.target)
	e2:SetOperation(c90000855.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
--searcher
function c90000855.con(e)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsLocation(LOCATION_MZONE)
end
function c90000855.indval(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end
function c90000855.filter(c)
	return c:IsSetCard(0x5a9) and c:IsAbleToHand()
end
function c90000855.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000855.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c90000855.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c90000855.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

--replace
function c90000855.cfilter(c,e,tp)
	return c:IsSetCard(0x5a9) and c:IsControler(tp) and c:IsReason(REASON_BATTLE)
		and Duel.IsExistingMatchingCard(c90000855.filterx,tp,LOCATION_DECK,0,1,nil,c:GetAttack(),nil,e,tp)
end
function c90000855.filterx(c,atk,att,e,tp)
	local a=c:GetAttack()
	return a>=0 and a<atk and c:IsSetCard(0x5a9)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90000855.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c90000855.cfilter,1,nil,e,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c90000855.cfilterx2(c,e,tp)
	return c:IsSetCard(0x5a9) and c:IsControler(tp) and c:IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c90000855.filterx,tp,LOCATION_DECK,0,1,nil,c:GetAttack(),nil,e,tp)
end
function c90000855.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local sg=eg:Filter(c90000855.cfilterx2,nil,e,tp)
	if sg:GetCount()==1 then
		local tc=sg:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c90000855.filterx,tp,LOCATION_DECK,0,1,1,nil,tc:GetAttack(),nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		local tc=sg:GetFirst()
		if not tc then return end
		local atk=tc:GetAttack()
		tc=sg:GetNext()
		if tc then
			if tc:GetAttack()>atk then atk=tc:GetAttack() end		   
		end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c90000855.filterx,tp,LOCATION_DECK,0,1,1,nil,atk,att,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end