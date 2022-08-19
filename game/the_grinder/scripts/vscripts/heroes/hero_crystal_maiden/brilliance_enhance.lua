
LinkLuaModifier( "modifier_crystal_maiden_brilliance_enhance", "heroes/hero_crystal_maiden/brilliance_enhance", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_brilliance_enhance_debuff", "heroes/hero_crystal_maiden/brilliance_enhance", LUA_MODIFIER_MOTION_NONE )

crystal_maiden_brilliance_enhance = class({})

function crystal_maiden_brilliance_enhance:GetIntrinsicModifierName()
	return "modifier_crystal_maiden_brilliance_enhance"
end

modifier_crystal_maiden_brilliance_enhance = class({
	IsHidden 				= function(self) return true end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return false end,
	IsBuff                  = function(self) return true end,
	RemoveOnDeath 			= function(self) return false end,
	DeclareFunctions		= function(self) return 
	 	{
			MODIFIER_EVENT_ON_ATTACK_LANDED,
		}end,
	
})


function modifier_crystal_maiden_brilliance_enhance:OnAttackLanded(keys)
	if IsServer() then
		-- When someone affected by overload buff has attacked
		if keys.attacker == self:GetParent() then
			-- Does not proc when attacking buildings or allies
			if not keys.target:IsBuilding() and keys.target:GetTeamNumber() ~= keys.attacker:GetTeamNumber() then

				-- Ability properties
				local parent	=	self:GetParent()
				local ability	=	self:GetAbility()
				local particle	=	"particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf"
				-- Ability paramaters
				local radius 		=	ability:GetSpecialValueFor("radius") 
				local proc_chance 	=	ability:GetSpecialValueFor("proc_chance") 
				local duration = ability:GetSpecialValueFor("duration")
--				local int_damage = ability:GetSpecialValueFor("int_mult")*parent:GetIntellect()/100
				local damage = ability:GetSpecialValueFor("base_damage")


				if not RollPercentage(proc_chance) and not parent:HasModifier("modifier_item_special_mark_upgrade")  then
					return 
				end

				keys.target:EmitSound("Hero_Crystal.CrystalNova")

				local particle_fx = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN, parent)
				ParticleManager:SetParticleControl(particle_fx, 0, keys.target:GetAbsOrigin())
				ParticleManager:SetParticleControl(particle_fx, 1, Vector(radius, 1, radius))
				ParticleManager:ReleaseParticleIndex(particle_fx)
				-- Find enemies around the target
				local enemies	=	FindUnitsInRadius(	parent:GetTeamNumber(),
					keys.target:GetAbsOrigin(),
					nil,
					radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false)

				-- Damage and apply slow to enemies near target
				for _,enemy in pairs(enemies) do

					ApplyDamage({
						victim = enemy, 
						attacker = parent, 
						damage = damage, 
						damage_type = DAMAGE_TYPE_MAGICAL, 
						ability = ability})

					-- Apply debuff
					enemy:AddNewModifier(parent, ability, "modifier_crystal_maiden_brilliance_enhance_debuff",	{duration = duration} )

					-- Emit particle
					-- Remove overload buff
--					self:Destroy()
				end
			end
		end
	end
end

modifier_crystal_maiden_brilliance_enhance_debuff = class({
	IsHidden 				= function(self) return false end,
	IsPurgable 				= function(self) return false end,
	IsDebuff 				= function(self) return true end,
	IsBuff                  = function(self) return false end,
	RemoveOnDeath 			= function(self) return true end,
	DeclareFunctions		= function(self) return 
	 	{
			MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
			MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
		}end,
})

function modifier_crystal_maiden_brilliance_enhance_debuff:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_crystal_maiden_brilliance_enhance_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("movespeed_slow")*(-1)
end

function modifier_crystal_maiden_brilliance_enhance_debuff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("attackspeed_slow")*(-1)
end

