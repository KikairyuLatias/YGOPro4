--Pony Rebreather Superhorse
function c90000670.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x439),2)
	--tribute to boost
	 local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90000670,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c90000670.atkcost)
	e1:SetOperation(c90000670.atkop)
	c:RegisterEffect(e1)	
	--self preservation
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFCT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c90000670.tgcon)
	e2:SetValue(aux.imval1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
end
--boost
function c90000670.cfilter(c)
	return c:IsSetCard(0x439) and c:GetAttack()>0 and c:IsAbleToGraveAsCost() and not c:IsCode(90000670)
end
function c90000670.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c90000670.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c90000670.cfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetFirst():GetAttack())
end
function c90000670.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

--proc
function c90000670.indesfil(c)
	return c:IsFaceup() and c:IsSetCard(0x439)
end

function c90000670.tgcon(e)
	return e:GetHandler():GetLinkedGroup():IsExists(c90000670.indesfil,1,nil)
end