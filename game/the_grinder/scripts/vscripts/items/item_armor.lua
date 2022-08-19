LinkLuaModifier("modifier_item_armor", "items/item_armor", LUA_MODIFIER_MOTION_NONE)

item_armor = class({})

function item_armor:GetIntrinsicModifierName()
	return "modifier_item_armor"
end


item_armor_1_1 = class(item_armor)
item_armor_1_2 = class(item_armor)
item_armor_1_3 = class(item_armor)
item_armor_1_4 = class(item_armor)

item_armor_2_1 = class(item_armor)
item_armor_2_2 = class(item_armor)
item_armor_2_3 = class(item_armor)
item_armor_2_4 = class(item_armor)

item_armor_3_1 = class(item_armor)
item_armor_3_2 = class(item_armor)
item_armor_3_3 = class(item_armor)
item_armor_3_4 = class(item_armor)

item_armor_4_1 = class(item_armor)
item_armor_4_2 = class(item_armor)
item_armor_4_3 = class(item_armor)
item_armor_4_4 = class(item_armor)

item_armor_5_1 = class(item_armor)
item_armor_5_2 = class(item_armor)
item_armor_5_3 = class(item_armor)
item_armor_5_4 = class(item_armor)

item_armor_6_1 = class(item_armor)
item_armor_6_2 = class(item_armor)
item_armor_6_3 = class(item_armor)
item_armor_6_4 = class(item_armor)

item_armor_7_1 = class(item_armor)
item_armor_7_2 = class(item_armor)
item_armor_7_3 = class(item_armor)
item_armor_7_4 = class(item_armor)

item_armor_8_1 = class(item_armor)
item_armor_8_2 = class(item_armor)
item_armor_8_3 = class(item_armor)
item_armor_8_4 = class(item_armor)

modifier_item_armor = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}end,
})

function modifier_item_armor:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end