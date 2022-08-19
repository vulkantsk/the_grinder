
-------------------------------------------
--				REVERB RAPIER
-------------------------------------------
LinkLuaModifier("modifier_triple_blow_passive", "heroes/hero_phantom_assassin/triple_blow", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_triple_blow_haste", "heroes/hero_phantom_assassin/triple_blow", LUA_MODIFIER_MOTION_NONE)
-------------------------------------------

imba_phantom_assassin_triple_blow = class({})

-------------------------------------------
function imba_phantom_assassin_triple_blow:GetIntrinsicModifierName()
    return "modifier_triple_blow_passive"
end

-------------------------------------------
modifier_triple_blow_passive = class({})
function modifier_triple_blow_passive:IsDebuff() return false end
function modifier_triple_blow_passive:IsHidden() return true end
function modifier_triple_blow_passive:IsPermanent() return true end
function modifier_triple_blow_passive:IsPurgable() return false end
function modifier_triple_blow_passive:IsPurgeException() return false end
function modifier_triple_blow_passive:IsStunDebuff() return false end
function modifier_triple_blow_passive:RemoveOnDeath() return false end


function modifier_triple_blow_passive:DeclareFunctions()
    local decFuns =
    {
		MODIFIER_EVENT_ON_ATTACK_START
	}
    return decFuns
end



function modifier_triple_blow_passive:OnAttackStart(keys)
	local item = self:GetAbility()
	local parent = self:GetParent()
	if item then
		if (keys.attacker == parent) and (parent:IsRealHero() or parent:IsClone()) then
			if item:IsCooldownReady() then
				parent:AddNewModifier(parent, item, "modifier_triple_blow_haste", {})
				item:UseResources(false,false,true)			
			end
		end
	end
end
-------------------------------------------
modifier_triple_blow_haste = class({})
function modifier_triple_blow_haste:IsDebuff() return false end
function modifier_triple_blow_haste:IsHidden() return true end
function modifier_triple_blow_haste:IsPurgable() return false end
function modifier_triple_blow_haste:IsPurgeException() return false end
function modifier_triple_blow_haste:IsStunDebuff() return false end
function modifier_triple_blow_haste:RemoveOnDeath() return true end
-------------------------------------------
function modifier_triple_blow_haste:OnCreated()
	local item = self:GetAbility()
	self.parent = self:GetParent()
	if item then
		local current_speed = self.parent:GetIncreasedAttackSpeed()
		current_speed = current_speed * 2

		local max_hits = item:GetSpecialValueFor("max_hits")
		self:SetStackCount(max_hits)
		self.attack_speed_buff = math.max(item:GetSpecialValueFor("attack_speed_buff"), current_speed)
	end
end

function modifier_triple_blow_haste:DeclareFunctions()
    local decFuns =
    {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK
    }
    return decFuns
end

function modifier_triple_blow_haste:OnAttack(keys)
	if self.parent == keys.attacker then
		
		-- If the target is a deflector, do nothing
	
		if self:GetStackCount() == 1 then
			self:Destroy()
			return nil
		end

		self:DecrementStackCount()
	end
end

function modifier_triple_blow_haste:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed_buff
end
-------------------------------------------
