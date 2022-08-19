LinkLuaModifier('modifier_item_hard_armor', 'items/item_hard_armor', LUA_MODIFIER_MOTION_NONE)

item_hard_armor = class({})

function item_hard_armor:GetIntrinsicModifierName()
    return "modifier_item_hard_armor"
end

item_hard_armor_1_1 = class(item_hard_armor)
item_hard_armor_1_2 = class(item_hard_armor)
item_hard_armor_1_3 = class(item_hard_armor)
item_hard_armor_1_4 = class(item_hard_armor)

item_hard_armor_2_1 = class(item_hard_armor)
item_hard_armor_2_2 = class(item_hard_armor)
item_hard_armor_2_3 = class(item_hard_armor)
item_hard_armor_2_4 = class(item_hard_armor)

item_hard_armor_3_1 = class(item_hard_armor)
item_hard_armor_3_2 = class(item_hard_armor)
item_hard_armor_3_3 = class(item_hard_armor)
item_hard_armor_3_4 = class(item_hard_armor)

item_hard_armor_4_1 = class(item_hard_armor)
item_hard_armor_4_2 = class(item_hard_armor)
item_hard_armor_4_3 = class(item_hard_armor)
item_hard_armor_4_4 = class(item_hard_armor)

item_hard_armor_5_1 = class(item_hard_armor)
item_hard_armor_5_2 = class(item_hard_armor)
item_hard_armor_5_3 = class(item_hard_armor)
item_hard_armor_5_4 = class(item_hard_armor)

item_hard_armor_6_1 = class(item_hard_armor)
item_hard_armor_6_2 = class(item_hard_armor)
item_hard_armor_6_3 = class(item_hard_armor)
item_hard_armor_6_4 = class(item_hard_armor)

item_hard_armor_7_1 = class(item_hard_armor)
item_hard_armor_7_2 = class(item_hard_armor)
item_hard_armor_7_3 = class(item_hard_armor)
item_hard_armor_7_4 = class(item_hard_armor)

item_hard_armor_8_1 = class(item_hard_armor)
item_hard_armor_8_2 = class(item_hard_armor)
item_hard_armor_8_3 = class(item_hard_armor)
item_hard_armor_8_4 = class(item_hard_armor)

modifier_item_hard_armor = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return true end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
            MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        }
    end,
})


function modifier_item_hard_armor:OnCreated(data)
--    if IsClient() then return end
    local ability = self:GetAbility()
    self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
    self.chance_block = ability:GetSpecialValueFor("chance_block")
   
end

function modifier_item_hard_armor:GetModifierIncomingDamage_Percentage()
    if RollPercentage(self.chance_block) then
        return -1000
    end
end

function modifier_item_hard_armor:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end
