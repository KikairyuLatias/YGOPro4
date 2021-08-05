--Hazmat Animal Fusion
local s,id=GetID()
function s.initial_effect(c)
	local e1=Fusion.CreateSummonEff(c,s.ffilter,nil,s.fextra)
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
	if not AshBlossomTable then AshBlossomTable={} end
	table.insert(AshBlossomTable,e1)
end

function s.ffilter(c)
	return c:IsSetCard(0x43a)
end
function s.fextra(e,tp,mg)
	if Duel.IsExistingMatchingCard(aux.FilterFaceupFunction(Card.IsCode,233000588),tp,LOCATION_MZONE,0,1,nil) then
		local sg=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_DECK+LOCATION_EXTRA,0,nil)
		if #sg>0 then
			return sg,s.fcheck
		end
	end
	return nil
end
function s.fcheck(tp,sg,fc)
	return sg:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)<=1
end