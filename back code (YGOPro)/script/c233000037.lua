--Elemental HERO Scarlet Gallant
local s,id=GetID()
function s.initial_effect(c)
	--materials
	c:EnableReviveLimit()
	aux.AddFusionProcMixN(c,true,true,s.ffilter,2)
end
--fusion materials
s.material_setcode=0x8
function s.ffilter(c,fc,sumtype,tp,sub,mg,sg)
	return c:IsFusionSetCard(0x8) and (not sg or not sg:IsExists(s.fusfilter,1,c,c:GetFusionCode()))
end
function s.fusfilter(c,code)
	return c:IsFusionCode(code) and not c:IsHasEffect(511002961)
end