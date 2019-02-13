--Diver Deer Florentina
function c90001123.initial_effect(c)
	--synchro custom
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TUNER_MATERIAL_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetTarget(c90001123.synlimit)
	c:RegisterEffect(e1)
	--fusion custom
	local e2=e1:Clone()
	e2:SetCode(EFFECT_FUSION_MATERIAL_LIMIT)
	c:RegisterEffect(e2)
	--xyz custom
	local e3=e1:Clone()
	e3:SetCode(EFFECT_XYZ_MATERIAL_LIMIT)
	c:RegisterEffect(e3)
	--link custom
	local e4=e1:Clone()
	e4:SetCode(EFFECT_LINK_MATERIAL_LIMIT)
	c:RegisterEffect(e4)
	--lv change
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCountLimit(1)
	e5:SetTarget(c90001123.target)
	e5:SetOperation(c90001123.operation)
	c:RegisterEffect(e5)
	--draw
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(90001123,0))
	e6:SetCategory(CATEGORY_DRAW)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_BE_MATERIAL)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetCondition(c90001123.drcon)
	e6:SetCountLimit(1,90001123)
	e6:SetTarget(c90001123.drtg)
	e6:SetOperation(c90001123.drop)
	e6:SetCountLimit(1,90001123)
	c:RegisterEffect(e6)
end

--synchro limit
function c90001123.synlimit(e,c)
	return c:IsSetCard(0x4af)
end

--level change
function c90001123.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0x4af)
end
function c90001123.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c90001123.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c90001123.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c90001123.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local t={}
	local p=1
	local lv1=g:GetFirst():GetLevel()
	local lv2=0
	local tc2=g:GetNext()
	if tc2 then lv2=tc2:GetLevel() end
	for i=1,6 do
		if lv1~=i and lv2~=i then t[p]=i p=p+1 end
	end
	Duel.Hint(HINT_SELECTMSG,tp,567)
	local lv=Duel.AnnounceNumber(tp,table.unpack(t))
	e:SetLabel(lv)
end
function c90001123.lvfilter(c,e)
	return c:IsFaceup() and c:IsRelateToEffect(e)
end
function c90001123.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c90001123.lvfilter,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end

--draw when you summon with me
function c90001123.drcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_SYNCHRO or r==REASON_FUSION or r==REASON_XYZ or r==REASON_LINK
end
function c90001123.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c90001123.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
