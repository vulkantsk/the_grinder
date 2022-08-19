LinkLuaModifier("modifier_item_attackspeed", "items/item_attackspeed", LUA_MODIFIER_MOTION_NONE)

item_attackspeed = class({})

function item_attackspeed:GetIntrinsicModifierName()
	return "modifier_item_attackspeed"
end


item_attackspeed_1_1 = class(item_attackspeed)
item_attackspeed_1_2 = class(item_attackspeed)
item_attackspeed_1_3 = class(item_attackspeed)
item_attackspeed_1_4 = class(item_attackspeed)

item_attackspeed_2_1 = class(item_attackspeed)
item_attackspeed_2_2 = class(item_attackspeed)
item_attackspeed_2_3 = class(item_attackspeed)
item_attackspeed_2_4 = class(item_attackspeed)

item_attackspeed_3_1 = class(item_attackspeed)
item_attackspeed_3_2 = class(item_attackspeed)
item_attackspeed_3_3 = class(item_attackspeed)
item_attackspeed_3_4 = class(item_attackspeed)

item_attackspeed_4_1 = class(item_attackspeed)
item_attackspeed_4_2 = class(item_attackspeed)
item_attackspeed_4_3 = class(item_attackspeed)
item_attackspeed_4_4 = class(item_attackspeed)

item_attackspeed_5_1 = class(item_attackspeed)
item_attackspeed_5_2 = class(item_attackspeed)
item_attackspeed_5_3 = class(item_attackspeed)
item_attackspeed_5_4 = class(item_attackspeed)

item_attackspeed_6_1 = class(item_attackspeed)
item_attackspeed_6_2 = class(item_attackspeed)
item_attackspeed_6_3 = class(item_attackspeed)
item_attackspeed_6_4 = class(item_attackspeed)

item_attackspeed_7_1 = class(item_attackspeed)
item_attackspeed_7_2 = class(item_attackspeed)
item_attackspeed_7_3 = class(item_attackspeed)
item_attackspeed_7_4 = class(item_attackspeed)

item_attackspeed_8_1 = class(item_attackspeed)
item_attackspeed_8_2 = class(item_attackspeed)
item_attackspeed_8_3 = class(item_attackspeed)
item_attackspeed_8_4 = class(item_attackspeed)


modifier_item_attackspeed = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}end,
})

function modifier_item_attackspeed:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attackspeed")
end