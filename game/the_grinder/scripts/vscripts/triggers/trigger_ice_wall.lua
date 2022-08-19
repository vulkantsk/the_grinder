

function OnStartTouch(trigger)
	local triggerName = thisEntity:GetName()
	local team = trigger.activator:GetTeam()
	local level = trigger.activator:GetLevel()
	local unit = trigger.activator
	--print("Trap Button Trigger Entered")

	local wall_ent = Entities:FindByName( nil, triggerName.."_model" )
	local obstructions = Entities:FindAllByName(triggerName .. "_obstruction")
	if unit.speed == nil or unit.speed < 750 then
		print( "Trap Skip" )
		return
	end

	for _,obstruction in pairs (obstructions) do
		obstruction:RemoveSelf()
	end
	wall_ent:EmitSound("Ability.FrostNova")

	local effect = "particles/units/heroes/hero_lich/lich_frost_nova.vpcf"
	local pfx = ParticleManager:CreateParticle(effect, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, wall_ent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)

	wall_ent:RemoveSelf()
	thisEntity:RemoveSelf()
end

function OnEndTouch(trigger)
	local triggerName = thisEntity:GetName()
	local team = trigger.activator:GetTeam()
	--print("Trap Button Trigger Exited")
--	local heroIndex = trigger.activator:GetEntityIndex()
--	local heroHandle = EntIndexToHScript(heroIndex)
end


