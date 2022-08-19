LinkLuaModifier('modifier_item_curtain_helm', 'items/item_curtain_helm', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_item_curtain_helm_buff', 'items/item_curtain_helm', LUA_MODIFIER_MOTION_NONE)

item_curtain_helm = class({})
function item_curtain_helm:GetIntrinsicModifierName()
   return "modifier_item_curtain_helm"
end

item_curtain_helm_1_1 = class(item_curtain_helm)
item_curtain_helm_1_2 = class(item_curtain_helm)
item_curtain_helm_1_3 = class(item_curtain_helm)
item_curtain_helm_1_4 = class(item_curtain_helm)

item_curtain_helm_2_1 = class(item_curtain_helm)
item_curtain_helm_2_2 = class(item_curtain_helm)
item_curtain_helm_2_3 = class(item_curtain_helm)
item_curtain_helm_2_4 = class(item_curtain_helm)

item_curtain_helm_3_1 = class(item_curtain_helm)
item_curtain_helm_3_2 = class(item_curtain_helm)
item_curtain_helm_3_3 = class(item_curtain_helm)
item_curtain_helm_3_4 = class(item_curtain_helm)

item_curtain_helm_4_1 = class(item_curtain_helm)
item_curtain_helm_4_2 = class(item_curtain_helm)
item_curtain_helm_4_3 = class(item_curtain_helm)
item_curtain_helm_4_4 = class(item_curtain_helm)

item_curtain_helm_5_1 = class(item_curtain_helm)
item_curtain_helm_5_2 = class(item_curtain_helm)
item_curtain_helm_5_3 = class(item_curtain_helm)
item_curtain_helm_5_4 = class(item_curtain_helm)

item_curtain_helm_6_1 = class(item_curtain_helm)
item_curtain_helm_6_2 = class(item_curtain_helm)
item_curtain_helm_6_3 = class(item_curtain_helm)
item_curtain_helm_6_4 = class(item_curtain_helm)

item_curtain_helm_7_1 = class(item_curtain_helm)
item_curtain_helm_7_2 = class(item_curtain_helm)
item_curtain_helm_7_3 = class(item_curtain_helm)
item_curtain_helm_7_4 = class(item_curtain_helm)

item_curtain_helm_8_1 = class(item_curtain_helm)
item_curtain_helm_8_2 = class(item_curtain_helm)
item_curtain_helm_8_3 = class(item_curtain_helm)
item_curtain_helm_8_4 = class(item_curtain_helm)

modifier_item_curtain_helm = class({
    IsHidden                = function(self) return true end,
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


function modifier_item_curtain_helm:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end

function modifier_item_curtain_helm:OnCreated(data)
    local ability = self:GetAbility()
    self.tick_interval = 0.1
    self:StartIntervalThink(self.tick_interval)
    self.bonus_armor = ability:GetSpecialValueFor("bonus_armor")
    self.damage_absorb = ability:GetSpecialValueFor("damage_absorb")

end

function modifier_item_curtain_helm:OnRefresh(data)
    self:OnCreated()
end

function modifier_item_curtain_helm:OnDestroy()
    if self.shield_modifier then
        self.shield_modifier:Destroy()
    end
end

function modifier_item_curtain_helm:OnIntervalThink()
    local ability = self:GetAbility()
    local caster = self:GetCaster()

    if ability:IsCooldownReady() then
        ability:UseResources(true, true, true)
        self.shield_modifier = caster:AddNewModifier(caster, ability, "modifier_item_curtain_helm_buff", nil)   
        self.shield_modifier:SetStackCount(self.damage_absorb)
    end
end



modifier_item_curtain_helm_buff = class({
    IsHidden                = function(self) return false end,
    IsPurgable              = function(self) return false end,
    IsDebuff                = function(self) return false end,
    IsBuff                  = function(self) return true end,
    RemoveOnDeath           = function(self) return true end,
    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
        }
    end,

    GetModifierTotal_ConstantBlock = function(self,data) 
        if data.damage < 0 then return end
        
        local absorbAmount = self:GetStackCount() - data.damage
        if absorbAmount < 0 then 
            self:Destroy()

            return absorbAmount + data.damage
        else
            self:SetStackCount(absorbAmount)

            return data.damage          
        end 
    end,
})

function modifier_item_curtain_helm_buff:OnCreated(data)
--    if IsClient() then return end
    local ability = self:GetAbility()

    self.parent = self:GetParent()
    local shield_size = 70
     self.nfx = ParticleManager:CreateParticle('particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf', PATTACH_CUSTOMORIGIN_FOLLOW,self:GetParent())
    ParticleManager:SetParticleControl(self.nfx, 1, Vector(shield_size,0,shield_size))
    ParticleManager:SetParticleControl(self.nfx, 2, Vector(shield_size,0,shield_size))
    ParticleManager:SetParticleControl(self.nfx, 4, Vector(shield_size,0,shield_size))
    ParticleManager:SetParticleControl(self.nfx, 5, Vector(shield_size,0,0))
    ParticleManager:SetParticleControlEnt(self.nfx, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(self.nfx, true, false, 1, true, true)

end



