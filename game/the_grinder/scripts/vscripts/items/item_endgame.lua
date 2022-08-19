
item_endgame = class({})

function item_endgame:OnSpellStart()
	local item = self
	local caster = self:GetCaster()
	local team = caster:GetTeam()
	
	GameRules:SetGameWinner(team)
end
