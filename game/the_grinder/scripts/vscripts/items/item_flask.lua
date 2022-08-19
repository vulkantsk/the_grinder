
item_flask_1 = class({})

function item_flask_1:OnSpellStart()
	local item = self
	local caster = self:GetCaster()
	local heal = item:GetSpecialValueFor("heal")
	local heal_pct = item:GetSpecialValueFor("heal_pct")
	local total_heal = caster:GetMaxHealth()*heal_pct/100 + heal_pct
	caster:Heal(total_heal, item)
	caster:EmitSound("DOTA_Item.HealingSalve.Activate")
	
	item:SpendCharge()
	if item:GetCurrentCharges() <1 then
		self:Destroy()
	end
end
