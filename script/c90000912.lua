--優雅なの空戦士 シェイミ
local s,id=GetID()
function s.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,1,1,aux.NonTuner(Card.IsAttribute,ATTRIBUTE_WIND),1,99)
	--typing
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_EXTRA)
	e1:SetCode(EFFECT_ADD_RACE)
	e1:SetValue(RACE_PLANT)
	c:RegisterEffect(e1)
	--damage (level)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetTarget(s.damtg)
	e2:SetOperation(s.damop)
	c:RegisterEffect(e2)
	--damage (rank)
	local e2a=Effect.CreateEffect(c)
	e2a:SetDescription(aux.Stringid(id,0))
	e2a:SetCategory(CATEGORY_DAMAGE)
	e2a:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2a:SetCode(EVENT_BATTLE_DESTROYING)
	e2a:SetTarget(s.damtg2)
	e2a:SetOperation(s.damop2)
	c:RegisterEffect(e2a)
	--flinch
end

--level burn
function s.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetBattleTarget()
	local level=tc:GetLevel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(level)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,level)
end
function s.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if tc:IsRelateToEffect(e) then
		Duel.Damage(p,tc:GetLevel()*200,REASON_EFFECT)
	end
end

--level burn
function s.damtg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetHandler():GetBattleTarget()
	local level=tc:GetRank()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(rank)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,rank)
end
function s.damop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if tc:IsRelateToEffect(e) then
		Duel.Damage(p,tc:GetRank()*200,REASON_EFFECT)
	end
end
