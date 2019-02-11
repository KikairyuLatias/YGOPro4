--Scuba Pony Aqua
function c90000656.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c,false)
	--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--hand synchro
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
	e1:SetOperation(c90000656.synop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_HAND_SYNCHRO)
	e2:SetLabel(90000656)
	e2:SetValue(c90000656.synval)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(90000656+TYPE_SYNCHRO)
	e2:SetValue(c90000656.synfilter)
	c:RegisterEffect(e3)
	--lv change
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(90000656,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c90000656.tg)
	e4:SetOperation(c90000656.op)
	c:RegisterEffect(e4)
end

--level change
function c90000656.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local lv=e:GetHandler():GetLevel()
	e:SetLabel(Duel.AnnounceLevel(tp,1,6,lv))
end
function c90000656.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

--synchro shiz
function c90000656.synfilter(e,c)
	return c:IsLocation(LOCATION_HAND) and c:IsSetCard(0x2439) and c:IsControler(e:GetHandlerPlayer())
end
function c90000656.synval(e,c,sc)
	if c:IsSetCard(0x2439) and c:IsLocation(LOCATION_HAND) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_HAND_SYNCHRO+EFFECT_SYNCHRO_CHECK)
		e1:SetLabel(90000656)
		e1:SetTarget(c90000656.synchktg)
		c:RegisterEffect(e1)
		return true
	else return false end
end
function c90000656.chk2(c)
	if not c:IsHasEffect(EFFECT_HAND_SYNCHRO) or c:IsHasEffect(EFFECT_HAND_SYNCHRO+EFFECT_SYNCHRO_CHECK) then return false end
	local te={c:GetCardEffect(EFFECT_HAND_SYNCHRO)}
	for i=1,#te do
		local e=te[i]
		if e:GetLabel()==90000656 then return true end
	end
	return false
end
function c90000656.synchktg(e,c,sg,tg,ntg,tsg,ntsg)
	if c then
		local res=true
		if #sg>=2 or (not tg:IsExists(c90000656.chk2,1,c) and not ntg:IsExists(c90000656.chk2,1,c) 
			and not sg:IsExists(c90000656.chk2,1,c)) then return false end
		local ttg=tg:Filter(c90000656.chk2,nil)
		local nttg=ntg:Filter(c90000656.chk2,nil)
		local trg=tg:Clone()
		local ntrg=ntg:Clone()
		trg:Sub(ttg)
		ntrg:Sub(nttg)
		return res,trg,ntrg
	else
		return #sg<2
	end
end
function c90000656.synop(e,tg,ntg,sg,lv,sc,tp)
	return #sg==2,false
end