--Psychic Dragon Eon Princess Latias EX
function c90000254.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2)
	--effect gain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c90000254.matcheck)
	c:RegisterEffect(e1)
	--halve stats
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c90000254.atkcon)
	e2:SetTarget(c90000254.atktg)
	e2:SetValue(c90000254.atkval)
	c:RegisterEffect(e2)
	--healing
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(c90000254.reccon)
	e4:SetTarget(c90000254.rectg)
	e4:SetOperation(c90000254.recop)
	c:RegisterEffect(e4)
end

--check if you only used psychic dragon
function c90000254.filter(c)
	return c:IsSetCard(0x5f1)
end
function c90000254.matcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(c90000254.filter,2,3) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(id,0))
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(aux.tgoval)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e2:SetValue(c90000254.indval)
		c:RegisterEffect(e2)
	end
end
function c90000254.indval(e,re,tp)
	return tp~=e:GetHandlerPlayer()
end

--halve everything the opponent got
function c90000254.atkcon(e)
	return e:GetHandler():GetLinkedGroupCount()>0
end

function c90000254.atktg(e,c)
	return c~=e:GetHandler()
end
function c90000254.atkval(e,c)
	return math.ceil(c:GetAttack()/2)
end
function c90000254.defval(e,c)
	return math.ceil(c:GetDefense()/2)
end

--lp restoration
function c90000254.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle()
end
function c90000254.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	local rec=bc:GetAttack()
	if bc:GetAttack() < bc:GetDefense() then rec=bc:GetDefense() end
	if rec<0 then rec=0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end

function c90000254.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end