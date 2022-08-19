LinkLuaModifier("modifier_item_baseitem", "items/item_baseitem", LUA_MODIFIER_MOTION_NONE)

item_baseitem = class({})

function item_baseitem:GetIntrinsicModifierName()
	return "modifier_item_baseitem"
end

item_baseitem_1 = class(item_baseitem)
item_baseitem_2 = class(item_baseitem)
item_baseitem_3 = class(item_baseitem)
item_baseitem_4 = class(item_baseitem)


modifier_item_baseitem = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}end,
})

function modifier_item_baseitem:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_stats")
end

function modifier_item_baseitem:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_stats")
end

function modifier_item_baseitem:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_stats")
end
