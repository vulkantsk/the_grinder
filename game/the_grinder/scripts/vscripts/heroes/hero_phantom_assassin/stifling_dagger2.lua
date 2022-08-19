--[[
Author: sercankd
Date: 06.04.2017
Updated: 15.04.2017
]]


-------------------------------------------
-- Stifling Dagger
-------------------------------------------

imba_phantom_assassin_stifling_dagger = class({})

LinkLuaModifier("modifier_imba_stifling_dagger_slow", "heroes/hero_phantom_assassin/stifling_dagger", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_imba_stifling_dagger_bonus_damage", "heroes/hero_phantom_assassin/stifling_dagger", LUA_MODIFIER_MOTION_NONE)

function imba_phantom_assassin_stifling_dagger:OnSpellStart()

    local caster 	= self:GetCaster()
	local ability 	= self
--	local target 	= self:GetCursorTarget()
	local scepter 	= caster:HasScepter()

	--ability specials
	move_slow 				=	ability:GetSpecialValueFor("move_slow")
	dagger_speed 			=	ability:GetSpecialValueFor("dagger_speed")
	slow_duration 			=	ability:GetSpecialValueFor("slow_duration")
	silence_duration 		= 	ability:GetSpecialValueFor("silence_duration")
	damage_reduction 		=	ability:GetSpecialValueFor("damage_reduction")
	dagger_vision 			=	ability:GetSpecialValueFor("dagger_vision")
	scepter_knives_interval =	0.3
	cast_range				=	ability:GetEffectiveCastRange(caster:GetAbsOrigin(), nil)
	playbackrate			=	1 + scepter_knives_interval

	--TALENT: +35 Stifling Dagger bonus damage
	bonus_damage	=	ability:GetSpecialValueFor("bonus_damage")
	

	--coup de grace variables
	local ability_crit = caster:FindAbilityByName("modifier_imba_coup_de_grace")
--	local ps_coup_modifier = "modifier_imba_phantom_strike_coup_de_grace"

	StartSoundEvent("Hero_PhantomAssassin.Dagger.Cast", caster)

	local extra_data = {main_dagger = true}

	local enemies = FindUnitsInRadius( 
						caster:GetTeamNumber(),	--команда юнита
						caster:GetOrigin(),		--местоположение юнита
						nil,	--айди юнита (необязательно)
						cast_range,	--радиус поиска
						DOTA_UNIT_TARGET_TEAM_ENEMY,	-- юнитов чьей команды ищем вражеской/дружественной
						DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	--юнитов какого типа ищем 
						DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	--поиск по флагам
						FIND_CLOSEST,	--сортировка от ближнего к дальнему или от дальнего к ближнему
						false )
	for i=1,#enemies do
		local dagger_projectile

		dagger_projectile = {
				EffectName = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf",
				Dodgeable = true,
				Ability = ability,
				ProvidesVision = true,
				VisionRadius = 600,
				bVisibleToEnemies = true,
				iMoveSpeed = dagger_speed,
				Source = caster,
				iVisionTeamNumber = caster:GetTeamNumber(),
				Target = enemies[i],
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
				bReplaceExisting = false,
				ExtraData = extra_data
			}
		ProjectileManager:CreateTrackingProjectile( dagger_projectile )
	end


end

function imba_phantom_assassin_stifling_dagger:OnProjectileHit( target, location )

    local caster = self:GetCaster()                                                                                 

	if not target then
		return nil
	end

	-- With 20 percentage play random stifling dagger response
	local responses = {"phantom_assassin_phass_ability_stiflingdagger_01","phantom_assassin_phass_ability_stiflingdagger_02","phantom_assassin_phass_ability_stiflingdagger_03","phantom_assassin_phass_ability_stiflingdagger_04"}
--	caster:EmitCasterSound("npc_dota_hero_phantom_assassin",responses, 20, DOTA_CAST_SOUND_FLAG_NONE, 20,"stifling_dagger")

	-- If the target possesses a ready Linken's Sphere, do nothing else
	if target:GetTeamNumber() ~= caster:GetTeamNumber() then
		if target:TriggerSpellAbsorb(self) then
			return nil
		end
	end

	-- Apply slow and silence modifiers
	if not target:IsMagicImmune() then
		target:AddNewModifier(caster, self, "modifier_imba_stifling_dagger_slow", {duration = slow_duration})
	end

	caster:AddNewModifier(caster, self, "modifier_imba_stifling_dagger_bonus_damage", {})

	-- Attack (calculates on-hit procs)
	local initial_pos = caster:GetAbsOrigin()
	local target_pos = target:GetAbsOrigin()

	-- Offset is necessary, because cleave from Battlefury doesn't work (in any direction) if you are exactly on top of the target unit
	local offset = 100 --dotameters (default melee range is 150 dotameters)
	
	-- Find the distance vector (distance, but as a vector rather than Length2D)
	-- z is 0 to prevent any wonkiness due to height differences, we'll use the targets height, unmodified
	local distance_vector = Vector(target_pos.x - initial_pos.x, target_pos.y - initial_pos.y, 0)
	-- Normalize it, so the offset can be applied to x/y components, proportionally
	distance_vector = distance_vector:Normalized()
	
	-- Offset the caster 100 units in front of the target
	target_pos.x = target_pos.x - offset * distance_vector.x
	target_pos.y = target_pos.y - offset * distance_vector.y
	
	caster:SetAbsOrigin(target_pos)
	caster:PerformAttack(target, true, true, true, true, true, false, true)
	caster:SetAbsOrigin(initial_pos)

	caster:RemoveModifierByName( "modifier_imba_stifling_dagger_bonus_damage" )
	return true
end

function imba_phantom_assassin_stifling_dagger:GetCastRange()
	return self:GetSpecialValueFor("cast_range")
end
-------------------------------------------
-- Stifling Dagger slow modifier
-------------------------------------------

modifier_imba_stifling_dagger_slow = class({})

function modifier_imba_stifling_dagger_slow:OnCreated()
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		local dagger_vision = ability:GetSpecialValueFor("dagger_vision")	
		local duration = ability:GetSpecialValueFor("slow_duration")
		local stifling_dagger_modifier_slow_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.target)
		ParticleManager:ReleaseParticleIndex(stifling_dagger_modifier_slow_particle)

		-- Add vision for the duration	
		AddFOWViewer(caster:GetTeamNumber(), self:GetParent():GetAbsOrigin(), dagger_vision, duration, false)
	end
end

function modifier_imba_stifling_dagger_slow:DeclareFunctions()
  local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_STATE_PROVIDES_VISION }
  return funcs
end

function modifier_imba_stifling_dagger_slow:GetModifierMoveSpeedBonus_Percentage()
  	return self:GetAbility():GetSpecialValueFor("move_slow");
end

function modifier_imba_stifling_dagger_slow:GetModifierProvidesFOWVision()	return true end

function modifier_imba_stifling_dagger_slow:IsDebuff()		return true end

function modifier_imba_stifling_dagger_slow:IsPurgable()	return true end


-------------------------------------------
-- Stifling Dagger bonus damage modifier
-------------------------------------------

modifier_imba_stifling_dagger_bonus_damage = class({})

function modifier_imba_stifling_dagger_bonus_damage:DeclareFunctions()
  local funcs = { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
  return funcs
end

function modifier_imba_stifling_dagger_bonus_damage:GetModifierPreAttack_BonusDamage()
	local ability = self:GetAbility()
  	return ability:GetSpecialValueFor("bonus_damage");
end

function modifier_imba_stifling_dagger_bonus_damage:IsBuff()			return true end

function modifier_imba_stifling_dagger_bonus_damage:IsPurgable() 	return false end

function modifier_imba_stifling_dagger_bonus_damage:IsHidden() 	  return true end
