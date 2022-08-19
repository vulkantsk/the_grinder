LinkLuaModifier( "modifier_item_battlefury_custom", "items/item_battlefury", LUA_MODIFIER_MOTION_NONE ) 

item_battlefury = class({})

function item_battlefury:GetIntrinsicModifierName()
	return "modifier_item_battlefury_custom"
end

item_battlefury_1_1 = class(item_battlefury)
item_battlefury_1_2 = class(item_battlefury)
item_battlefury_1_3 = class(item_battlefury)
item_battlefury_1_4 = class(item_battlefury)

item_battlefury_2_1 = class(item_battlefury)
item_battlefury_2_2 = class(item_battlefury)
item_battlefury_2_3 = class(item_battlefury)
item_battlefury_2_4 = class(item_battlefury)

item_battlefury_3_1 = class(item_battlefury)
item_battlefury_3_2 = class(item_battlefury)
item_battlefury_3_3 = class(item_battlefury)
item_battlefury_3_4 = class(item_battlefury)

item_battlefury_4_1 = class(item_battlefury)
item_battlefury_4_2 = class(item_battlefury)
item_battlefury_4_3 = class(item_battlefury)
item_battlefury_4_4 = class(item_battlefury)

item_battlefury_5_1 = class(item_battlefury)
item_battlefury_5_2 = class(item_battlefury)
item_battlefury_5_3 = class(item_battlefury)
item_battlefury_5_4 = class(item_battlefury)

item_battlefury_6_1 = class(item_battlefury)
item_battlefury_6_2 = class(item_battlefury)
item_battlefury_6_3 = class(item_battlefury)
item_battlefury_6_4 = class(item_battlefury)

item_battlefury_7_1 = class(item_battlefury)
item_battlefury_7_2 = class(item_battlefury)
item_battlefury_7_3 = class(item_battlefury)
item_battlefury_7_4 = class(item_battlefury)

item_battlefury_8_1 = class(item_battlefury)
item_battlefury_8_2 = class(item_battlefury)
item_battlefury_8_3 = class(item_battlefury)
item_battlefury_8_4 = class(item_battlefury)

modifier_item_battlefury_custom = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    DeclareFunctions        = function(self) return 
        {           
            MODIFIER_EVENT_ON_ATTACK_LANDED,
            MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
 --           MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT_ADJUST,
        } end,
})

function modifier_item_battlefury_custom:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end


function modifier_item_battlefury_custom:OnAttackLanded( params )
    if IsServer() then
		if params.attacker == self:GetParent() and ( not self:GetParent():IsIllusion() ) then
			local target = params.target
			if target ~= nil and target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
				local cleave_damage = params.damage * self:GetAbility():GetSpecialValueFor("splash_pct") / 100
				local cleave_radius = self:GetAbility():GetSpecialValueFor("splash_radius")
				local effect = "particles/items_fx/battlefury_cleave.vpcf"

				DoCleaveAttack( self:GetParent(), target, self:GetAbility(), cleave_damage, cleave_radius, cleave_radius, cleave_radius, effect )
			end
		end
    end
    return 0
end


