--Rider Deer Shosa
function c90000853.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--replacement
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(90000853,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1)
	e1:SetTarget(c90000853.destg)
	e1:SetOperation(c90000853.desop)
	c:RegisterEffect(e1)
	--spsummon proc
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c90000853.spcon)
	c:RegisterEffect(e2)
	--draw effect
	local e3=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(90000853,2))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c90000853.drcon)
	e3:SetTarget(c90000853.drtg)
	e3:SetOperation(c90000853.drop)
	c:RegisterEffect(e3)
end
--condition
function c90000853.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0,nil)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
--draw
function c90000853.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=eg:GetFirst()
	while rc do
		if rc:IsStatus(STATUS_OPPO_BATTLE) then
			if rc:IsRelateToBattle() then
				if rc:IsControler(tp) and rc:IsSetCard(0x5a9) then return true end
			else
				if rc:GetPreviousControler()==tp and rc:IsPreviousSetCard(0x5a9) then return true end
			end
		end
		rc=eg:GetNext()
	end
	return false
end
function c90000853.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000853.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end

--replace
function c90000853.cfilter(c,e,tp)
	return c:IsSetCard(0x5a9) and c:IsControler(tp) and c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT)
		and Duel.IsExistingMatchingCard(c90000853.filterx,tp,LOCATION_DECK,0,1,nil,c:GetAttack(),nil,e,tp)
end
function c90000853.filterx(c,atk,att,e,tp)
	local a=c:GetAttack()
	return a>=0 and a<atk and c:IsSetCard(0x5a9)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c90000853.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c90000853.cfilter,1,nil,e,tp) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c90000853.cfilterx2(c,e,tp)
	return c:IsSetCard(0x5a9) and c:IsControler(tp) and c:IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c90000853.filterx,tp,LOCATION_DECK,0,1,nil,c:GetAttack(),nil,e,tp)
end
function c90000853.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local sg=eg:Filter(c90000853.cfilterx2,nil,e,tp)
	if sg:GetCount()==1 then
		local tc=sg:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c90000853.filterx,tp,LOCATION_DECK,0,1,1,nil,tc:GetAttack(),nil,e,tp)
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
		local g=Duel.SelectMatchingCard(tp,c90000853.filterx,tp,LOCATION_DECK,0,1,1,nil,atk,att,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end