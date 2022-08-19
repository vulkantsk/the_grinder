LinkLuaModifier("modifier_item_health", "items/item_health", LUA_MODIFIER_MOTION_NONE)

item_health = class({})

function item_health:GetIntrinsicModifierName()
	return "modifier_item_health"
end


item_health_1_1 = class(item_health)
item_health_1_2 = class(item_health)
item_health_1_3 = class(item_health)
item_health_1_4 = class(item_health)

item_health_2_1 = class(item_health)
item_health_2_2 = class(item_health)
item_health_2_3 = class(item_health)
item_health_2_4 = class(item_health)

item_health_3_1 = class(item_health)
item_health_3_2 = class(item_health)
item_health_3_3 = class(item_health)
item_health_3_4 = class(item_health)

item_health_4_1 = class(item_health)
item_health_4_2 = class(item_health)
item_health_4_3 = class(item_health)
item_health_4_4 = class(item_health)

item_health_5_1 = class(item_health)
item_health_5_2 = class(item_health)
item_health_5_3 = class(item_health)
item_health_5_4 = class(item_health)

item_health_6_1 = class(item_health)
item_health_6_2 = class(item_health)
item_health_6_3 = class(item_health)
item_health_6_4 = class(item_health)

item_health_7_1 = class(item_health)
item_health_7_2 = class(item_health)
item_health_7_3 = class(item_health)
item_health_7_4 = class(item_health)

item_health_8_1 = class(item_health)
item_health_8_2 = class(item_health)
item_health_8_3 = class(item_health)
item_health_8_4 = class(item_health)

modifier_item_health = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}end,
})

function modifier_item_health:GetModifierHealthBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_health:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_regen")
end