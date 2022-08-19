LinkLuaModifier("modifier_item_desolator_custom", "items/item_desolator", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_desolator_custom_debuff", "items/item_desolator", LUA_MODIFIER_MOTION_NONE)

item_desolator = class({})

function item_desolator:GetIntrinsicModifierName()
	return "modifier_item_desolator_custom"
end

item_desolator_1_1 = class(item_desolator)
item_desolator_1_2 = class(item_desolator)
item_desolator_1_3 = class(item_desolator)
item_desolator_1_4 = class(item_desolator)

item_desolator_2_1 = class(item_desolator)
item_desolator_2_2 = class(item_desolator)
item_desolator_2_3 = class(item_desolator)
item_desolator_2_4 = class(item_desolator)

item_desolator_3_1 = class(item_desolator)
item_desolator_3_2 = class(item_desolator)
item_desolator_3_3 = class(item_desolator)
item_desolator_3_4 = class(item_desolator)

item_desolator_4_1 = class(item_desolator)
item_desolator_4_2 = class(item_desolator)
item_desolator_4_3 = class(item_desolator)
item_desolator_4_4 = class(item_desolator)

item_desolator_5_1 = class(item_desolator)
item_desolator_5_2 = class(item_desolator)
item_desolator_5_3 = class(item_desolator)
item_desolator_5_4 = class(item_desolator)

item_desolator_6_1 = class(item_desolator)
item_desolator_6_2 = class(item_desolator)
item_desolator_6_3 = class(item_desolator)
item_desolator_6_4 = class(item_desolator)

item_desolator_7_1 = class(item_desolator)
item_desolator_7_2 = class(item_desolator)
item_desolator_7_3 = class(item_desolator)
item_desolator_7_4 = class(item_desolator)

item_desolator_8_1 = class(item_desolator)
item_desolator_8_2 = class(item_desolator)
item_desolator_8_3 = class(item_desolator)
item_desolator_8_4 = class(item_desolator)

modifier_item_desolator_custom = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_PROJECTILE_NAME, 
	}end,
})

function modifier_item_desolator_custom:GetModifierProjectileName()
	return "particles/items_fx/desolator_projectile.vpcf"
end

function modifier_item_desolator_custom:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_desolator_custom:OnAttackLanded(data)
	local caster = self:GetCaster()
	local target = data.target
	local attacker = data.attacker

	if attacker == caster and not target:IsBuilding() then
		local ability = self:GetAbility()
		local duration = ability:GetSpecialValueFor("debuff_duration")

		target:AddNewModifier(caster, ability, "modifier_item_desolator_custom_debuff", {duration = duration})
	end
end


modifier_item_desolator_custom_debuff = class({
	IsHidden 		= function(self) return false end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}end,
})


function modifier_item_desolator_custom_debuff:OnCreated(data)
    local ability = self:GetAbility()
   	self.armor_debuff = ability:GetSpecialValueFor("debuff_armor")
end


function modifier_item_desolator_custom_debuff:GetModifierPhysicalArmorBonus()
    return self.armor_debuff*(-1)
end