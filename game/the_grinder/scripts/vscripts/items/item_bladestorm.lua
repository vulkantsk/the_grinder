LinkLuaModifier("modifier_item_bladestorm", "items/item_bladestorm", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_thinker_item_bladestorm", "items/item_bladestorm", LUA_MODIFIER_MOTION_NONE)

item_bladestorm = class({})

function item_bladestorm:GetIntrinsicModifierName()
	return "modifier_item_bladestorm"
end

item_bladestorm_1_1 = class(item_bladestorm)
item_bladestorm_1_2 = class(item_bladestorm)
item_bladestorm_1_3 = class(item_bladestorm)
item_bladestorm_1_4 = class(item_bladestorm)

item_bladestorm_2_1 = class(item_bladestorm)
item_bladestorm_2_2 = class(item_bladestorm)
item_bladestorm_2_3 = class(item_bladestorm)
item_bladestorm_2_4 = class(item_bladestorm)

item_bladestorm_3_1 = class(item_bladestorm)
item_bladestorm_3_2 = class(item_bladestorm)
item_bladestorm_3_3 = class(item_bladestorm)
item_bladestorm_3_4 = class(item_bladestorm)

item_bladestorm_4_1 = class(item_bladestorm)
item_bladestorm_4_2 = class(item_bladestorm)
item_bladestorm_4_3 = class(item_bladestorm)
item_bladestorm_4_4 = class(item_bladestorm)

item_bladestorm_5_1 = class(item_bladestorm)
item_bladestorm_5_2 = class(item_bladestorm)
item_bladestorm_5_3 = class(item_bladestorm)
item_bladestorm_5_4 = class(item_bladestorm)

item_bladestorm_6_1 = class(item_bladestorm)
item_bladestorm_6_2 = class(item_bladestorm)
item_bladestorm_6_3 = class(item_bladestorm)
item_bladestorm_6_4 = class(item_bladestorm)

item_bladestorm_7_1 = class(item_bladestorm)
item_bladestorm_7_2 = class(item_bladestorm)
item_bladestorm_7_3 = class(item_bladestorm)
item_bladestorm_7_4 = class(item_bladestorm)

item_bladestorm_8_1 = class(item_bladestorm)
item_bladestorm_8_2 = class(item_bladestorm)
item_bladestorm_8_3 = class(item_bladestorm)
item_bladestorm_8_4 = class(item_bladestorm)

modifier_item_bladestorm = class({
	IsHidden 		= function(self) return true end,
	GetAttributes 	= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,
	DeclareFunctions  = function(self) return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}end,
})

function modifier_item_bladestorm:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_bladestorm:OnCreated()
	local ability = self:GetAbility()
	if ability.thinkers == nil then
		ability.thinkers = {}
	end
end

--function modifier_item_bladestorm:GetEffectName()
--	return "particles/items2_fx/mjollnir_shield.vpcf"
--end


function modifier_item_bladestorm:OnAttackLanded(data)
	local caster = self:GetCaster()
	local target = data.target
	local attacker = data.attacker

	if attacker == caster and not target:IsBuilding() and not target:IsMagicImmune() then
		local ability = self:GetAbility()
		local trigger_chance = ability:GetSpecialValueFor("trigger_chance")

		if RollPercentage(trigger_chance) then
			caster:EmitSound("Item.Maelstrom.Chain_Lightning")

			local thinker = CreateModifierThinker(caster, ability, "modifier_thinker_item_bladestorm", nil, caster:GetAbsOrigin(), caster:GetTeam(), false)
			thinker.id = thinker:entindex()
			table.insert(ability.thinkers, thinker.id, thinker)
			local thinker_modifier = thinker:FindModifierByName("modifier_thinker_item_bladestorm")
			thinker_modifier:ChainLight(caster, target)
		end
	end
end

modifier_thinker_item_bladestorm = class({})

function modifier_thinker_item_bladestorm:OnCreated()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.bounce_damage = 	self.ability:GetSpecialValueFor("chain_damage")
	self.bounce_count = 	self.ability:GetSpecialValueFor("chain_count")
	self.bounce_radius = 	self.ability:GetSpecialValueFor("chain_radius")
	self.bounce_interval = 	0.2
	
	self.target_count = 0
	self.bounced_targets = {}
end
function modifier_thinker_item_bladestorm:OnDestroy()
	table.remove(self.ability.thinkers, self.parent:entindex())
end

function modifier_thinker_item_bladestorm:ChainLight(target1, target2)
	self.bounced_targets[target2:entindex()] = true
	self.target_count = self.target_count + 1

	target2:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
--	ZapThem(caster, ability, caster, target, damage)

	local particle = "particles/items_fx/chain_lightning.vpcf"
--	if ability:GetAbilityName() == "item_imba_jarnbjorn" then
--		particle = "particles/items_fx/chain_lightning_jarnbjorn.vpcf"
--	end

	local bounce_pfx = ParticleManager:CreateParticle(particle, PATTACH_ABSORIGIN_FOLLOW, target1)
	ParticleManager:SetParticleControlEnt(bounce_pfx, 0, target1, PATTACH_POINT_FOLLOW, "attach_hitloc", target2:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(bounce_pfx, 1, target2, PATTACH_POINT_FOLLOW, "attach_hitloc", target2:GetAbsOrigin(), true)
	ParticleManager:SetParticleControl(bounce_pfx, 2, Vector(1, 1, 1))
	ParticleManager:ReleaseParticleIndex(bounce_pfx)

	ApplyDamage({
		attacker = self.caster, 
		victim = target2, 
		ability = self.ability, 
		damage = self.bounce_damage, 
		damage_type = DAMAGE_TYPE_MAGICAL})

	Timers:CreateTimer(self.bounce_interval, function()
		self.trigger = false
		if self.target_count >= self.bounce_count then
			self:Destroy()
			return
		end

		local nearby_enemies = FindUnitsInRadius(self.caster:GetTeamNumber(), 
					target2:GetAbsOrigin(), 
					nil, 
					self.bounce_radius, 
					DOTA_UNIT_TARGET_TEAM_ENEMY, 
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
					DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 
					FIND_ANY_ORDER, 
					false)

		for _, enemy in pairs(nearby_enemies) do
			local enemy_index = enemy:entindex()
			if self.bounced_targets[enemy_index] == nil then
				self:ChainLight(target2, enemy)
				self.trigger = true
				break
			end
		end

		if self.trigger == false then
			self:Destroy()
		end
	end)
end

