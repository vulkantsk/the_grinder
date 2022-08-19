LinkLuaModifier("modifier_item_ancient_shield", "items/item_ancient_shield", LUA_MODIFIER_MOTION_NONE)

item_ancient_shield = class({})

function item_ancient_shield:GetIntrinsicModifierName()
	return "modifier_item_ancient_shield"
end

item_ancient_shield_1_1 = class(item_ancient_shield)
item_ancient_shield_1_2 = class(item_ancient_shield)
item_ancient_shield_1_3 = class(item_ancient_shield)
item_ancient_shield_1_4 = class(item_ancient_shield)

item_ancient_shield_2_1 = class(item_ancient_shield)
item_ancient_shield_2_2 = class(item_ancient_shield)
item_ancient_shield_2_3 = class(item_ancient_shield)
item_ancient_shield_2_4 = class(item_ancient_shield)

item_ancient_shield_3_1 = class(item_ancient_shield)
item_ancient_shield_3_2 = class(item_ancient_shield)
item_ancient_shield_3_3 = class(item_ancient_shield)
item_ancient_shield_3_4 = class(item_ancient_shield)

item_ancient_shield_4_1 = class(item_ancient_shield)
item_ancient_shield_4_2 = class(item_ancient_shield)
item_ancient_shield_4_3 = class(item_ancient_shield)
item_ancient_shield_4_4 = class(item_ancient_shield)

item_ancient_shield_5_1 = class(item_ancient_shield)
item_ancient_shield_5_2 = class(item_ancient_shield)
item_ancient_shield_5_3 = class(item_ancient_shield)
item_ancient_shield_5_4 = class(item_ancient_shield)

item_ancient_shield_6_1 = class(item_ancient_shield)
item_ancient_shield_6_2 = class(item_ancient_shield)
item_ancient_shield_6_3 = class(item_ancient_shield)
item_ancient_shield_6_4 = class(item_ancient_shield)

item_ancient_shield_7_1 = class(item_ancient_shield)
item_ancient_shield_7_2 = class(item_ancient_shield)
item_ancient_shield_7_3 = class(item_ancient_shield)
item_ancient_shield_7_4 = class(item_ancient_shield)

item_ancient_shield_8_1 = class(item_ancient_shield)
item_ancient_shield_8_2 = class(item_ancient_shield)
item_ancient_shield_8_3 = class(item_ancient_shield)
item_ancient_shield_8_4 = class(item_ancient_shield)

modifier_item_ancient_shield = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}end,
})

function modifier_item_ancient_shield:GetModifierPhysical_ConstantBlock()
	return self:GetAbility():GetSpecialValueFor("bonus_block")
end



