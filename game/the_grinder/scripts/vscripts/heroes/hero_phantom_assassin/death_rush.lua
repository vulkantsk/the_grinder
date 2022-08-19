LinkLuaModifier("modifier_phantom_assassin_death_rush", "heroes/hero_phantom_assassin/death_rush", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_death_rush_passive", "heroes/hero_phantom_assassin/death_rush", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_death_rush_buff", "heroes/hero_phantom_assassin/death_rush", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_death_rush_cooldown", "heroes/hero_phantom_assassin/death_rush", LUA_MODIFIER_MOTION_NONE)

phantom_assassin_death_rush = class({})

function phantom_assassin_death_rush:GetIntrinsicModifierName()
    return "modifier_phantom_assassin_death_rush_passive"
end

modifier_phantom_assassin_death_rush_passive = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return false end,
    DeclareFunctions        = function(self) return 
        {
            MODIFIER_PROPERTY_MIN_HEALTH,
            MODIFIER_EVENT_ON_TAKEDAMAGE
        } end,

})
function modifier_phantom_assassin_death_rush_passive:GetMinHealth()
    if self:GetAbility():IsCooldownReady() or not self:GetCaster():IsRealHero() then
        return 1
    else
        return 
    end

end

function modifier_phantom_assassin_death_rush_passive:OnTakeDamage( keys )
    if not  IsServer() then
        return
    end
    if keys.unit ~= self:GetCaster() then
        return
    end
    if self:GetCaster():FindModifierByName("modifier_phantom_assassin_death_rush_cooldown") then
        return
    end

    if self:GetCaster():GetHealth() <= 1 then
        local caster = self:GetCaster()
        local ability = self:GetAbility()
        local duration = ability:GetSpecialValueFor("duration")
      
        caster:AddNewModifier(caster, ability, "modifier_phantom_assassin_death_rush", { duration = duration})
        ability:UseResources(true, true, true)
   
    end
end

modifier_phantom_assassin_death_rush = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self) return 
        {
            MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
            MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
            MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        } end,
    CheckState      = function(self) return 
        {
            [MODIFIER_STATE_NO_HEALTH_BAR] = true,          
            [MODIFIER_STATE_INVULNERABLE] = true, 
        } end,
})

function modifier_phantom_assassin_death_rush:OnDestroy()
    self:GetCaster():ForceKill(false)
end

function modifier_phantom_assassin_death_rush:GetModifierBaseAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("dmg_bonus")
end

function modifier_phantom_assassin_death_rush:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("ms_bonus")
end

function modifier_phantom_assassin_death_rush:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("as_bonus")
end

function modifier_phantom_assassin_death_rush:GetEffectName()
    return "particles/econ/courier/courier_greevil_purple/courier_greevil_purple_ambient_3.vpcf"
end
