LinkLuaModifier('modifier_item_hero_armor', 'items/item_hero_armor', LUA_MODIFIER_MOTION_NONE)

item_hero_armor = class({})

function item_hero_armor:GetCastRange()
    return self:GetSpecialValueFor("search_radius")
end

function item_hero_armor:GetIntrinsicModifierName()
    return "modifier_item_hero_armor"
end

item_hero_armor_1_1 = class(item_hero_armor)
item_hero_armor_1_2 = class(item_hero_armor)
item_hero_armor_1_3 = class(item_hero_armor)
item_hero_armor_1_4 = class(item_hero_armor)

item_hero_armor_2_1 = class(item_hero_armor)
item_hero_armor_2_2 = class(item_hero_armor)
item_hero_armor_2_3 = class(item_hero_armor)
item_hero_armor_2_4 = class(item_hero_armor)

item_hero_armor_3_1 = class(item_hero_armor)
item_hero_armor_3_2 = class(item_hero_armor)
item_hero_armor_3_3 = class(item_hero_armor)
item_hero_armor_3_4 = class(item_hero_armor)

item_hero_armor_4_1 = class(item_hero_armor)
item_hero_armor_4_2 = class(item_hero_armor)
item_hero_armor_4_3 = class(item_hero_armor)
item_hero_armor_4_4 = class(item_hero_armor)

item_hero_armor_5_1 = class(item_hero_armor)
item_hero_armor_5_2 = class(item_hero_armor)
item_hero_armor_5_3 = class(item_hero_armor)
item_hero_armor_5_4 = class(item_hero_armor)

item_hero_armor_6_1 = class(item_hero_armor)
item_hero_armor_6_2 = class(item_hero_armor)
item_hero_armor_6_3 = class(item_hero_armor)
item_hero_armor_6_4 = class(item_hero_armor)

item_hero_armor_7_1 = class(item_hero_armor)
item_hero_armor_7_2 = class(item_hero_armor)
item_hero_armor_7_3 = class(item_hero_armor)
item_hero_armor_7_4 = class(item_hero_armor)

item_hero_armor_8_1 = class(item_hero_armor)
item_hero_armor_8_2 = class(item_hero_armor)
item_hero_armor_8_3 = class(item_hero_armor)
item_hero_armor_8_4 = class(item_hero_armor)

modifier_item_hero_armor = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return true end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        }
    end,
})


function modifier_item_hero_armor:OnCreated(data)
    local ability = self:GetAbility()
    self.search_radius = ability:GetSpecialValueFor("search_radius")
    self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
    self.armor_per_enemy = ability:GetSpecialValueFor("armor_per_enemy")
   
   self:StartIntervalThink(0.1)
end

function modifier_item_hero_armor:OnIntervalThink()
    if IsClient() then return end
    
    local units = FindUnitsInRadius(self:GetCaster():GetTeam(), 
    self:GetParent():GetOrigin(), 
    nil, 
    self.search_radius,
    DOTA_UNIT_TARGET_TEAM_ENEMY, 
    DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
    self:GetAbility():GetAbilityTargetFlags(),
    FIND_ANY_ORDER, 
    false)

    self:SetStackCount(#units)
end

function modifier_item_hero_armor:OnRefresh()
    self:OnCreated()
end

function modifier_item_hero_armor:GetModifierPhysicalArmorBonus()
    return self.bonus_armor + self.armor_per_enemy * self:GetStackCount()
end
