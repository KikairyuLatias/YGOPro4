--Superstar Pony Duelist Sayuri GX
function c90000664.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c90000664.lcheck)
	c:EnableReviveLimit()
	--float and stuff
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000664,1))
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c90000664.sumcon)
	e1:SetTarget(c90000664.sumtg)
	e1:SetOperation(c90000664.sumop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_TO_DECK)
	c:RegisterEffect(e3)
	--draw when you ED spam
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000664,0))
	e4:SetCategory(CATEGORY_DRAW)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c90000664.drcon)
	e4:SetTarget(c90000664.drtg)
	e4:SetOperation(c90000664.drop)
	c:RegisterEffect(e4)
end
--condition
function c90000664.lcheck(g,lc)
	return g:GetClassCount(Card.GetCode)==g:GetCount()
end

--float stuff
function c90000664.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c90000664.filter(c,e,tp)
	return c:IsLevelBelow(4) and (c:IsRace(RACE_BEAST) or c:IsAttribute(ATTRIBUTE_LIGHT)) and c:IsCanBeSpecialSummoned(e,0,tp,false,true)
end
function c90000664.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90000664.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c90000664.sumop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetFirstMatchingCard(c90000664.filter,tp,LOCATION_GRAVE+LOCATION_DECK,0,nil,e,tp)
	if tg then
		Duel.SpecialSummon(tg,0,tp,tp,false,true,POS_FACEUP)
	end
end

--draw power
function c90000664.drcon(e,tp,eg,ep,ev,re,r,rp)
	local tg=eg:GetFirst()
	return eg:GetCount()==1 and tg~=e:GetHandler() and (tg:GetSummonType()==SUMMON_TYPE_SYNCHRO or tg:GetSummonType()==SUMMON_TYPE_FUSION or tg:GetSummonType()==SUMMON_TYPE_XYZ or tg:GetSummonType()==SUMMON_TYPE_LINK)
end
function c90000664.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90000664.drop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end