LinkLuaModifier("modifier_item_damage", "items/item_damage", LUA_MODIFIER_MOTION_NONE)

item_damage = class({})

function item_damage:GetIntrinsicModifierName()
	return "modifier_item_damage"
end

item_damage_1_1 = class(item_damage)
item_damage_1_2 = class(item_damage)
item_damage_1_3 = class(item_damage)
item_damage_1_4 = class(item_damage)

item_damage_2_1 = class(item_damage)
item_damage_2_2 = class(item_damage)
item_damage_2_3 = class(item_damage)
item_damage_2_4 = class(item_damage)

item_damage_3_1 = class(item_damage)
item_damage_3_2 = class(item_damage)
item_damage_3_3 = class(item_damage)
item_damage_3_4 = class(item_damage)

item_damage_4_1 = class(item_damage)
item_damage_4_2 = class(item_damage)
item_damage_4_3 = class(item_damage)
item_damage_4_4 = class(item_damage)

item_damage_5_1 = class(item_damage)
item_damage_5_2 = class(item_damage)
item_damage_5_3 = class(item_damage)
item_damage_5_4 = class(item_damage)

item_damage_6_1 = class(item_damage)
item_damage_6_2 = class(item_damage)
item_damage_6_3 = class(item_damage)
item_damage_6_4 = class(item_damage)

item_damage_7_1 = class(item_damage)
item_damage_7_2 = class(item_damage)
item_damage_7_3 = class(item_damage)
item_damage_7_4 = class(item_damage)

item_damage_8_1 = class(item_damage)
item_damage_8_2 = class(item_damage)
item_damage_8_3 = class(item_damage)
item_damage_8_4 = class(item_damage)

modifier_item_damage = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
	}end,
})

function modifier_item_damage:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end