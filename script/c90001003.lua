--Skystorm Mecha Jet - Red Blaster
function c90001003.initial_effect(c)
	--atk up
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_UPDATE_ATTACK)
	e0:SetRange(LOCATION_MZONE)
	e0:SetTargetRange(LOCATION_MZONE,0)
	e0:SetTarget(c90001003.tg)
	e0:SetValue(c90001003.val)
	c:RegisterEffect(e0)
	--def up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(c90001003.val)
	e1:SetTarget(c90001003.tg)
	c:RegisterEffect(e1)
	--burn damage (needs fixing)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c90001003.condition)
	e2:SetTarget(c90001003.target)
	e2:SetOperation(c90001003.activate)
	c:RegisterEffect(e2)
end

--boost
function c90001003.tg(e,c)
	return c:IsType(TYPE_MONSTER) and c~=e:GetHandler()
end
function c90001003.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x7c7)
end
function c90001003.val(e,c)
	return Duel.GetMatchingGroupCount(c90001003.filter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end

--burn
function c90001003.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return eg:GetCount()==1 and tc:IsControler(tp) and tc:IsSetCard(0x7c7)
		and bc:IsReason(REASON_BATTLE)
end
function c90001003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local atk=eg:GetFirst():GetBattleTarget():GetAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c90001003.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end