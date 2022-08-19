

local triggerActive = true

function OnStartTouch(trigger)
	if not triggerActive then
		print( "Trap Skip" )
		return
	end
		
	local triggerName = thisEntity:GetName()
	local npc_activator = trigger.activator
	local team = npc_activator:GetTeam()
	local level = npc_activator:GetLevel()
	--print("Trap Button Trigger Entered")
	local button = triggerName .. "_button"
	local model = triggerName .. "_model"
	local wall = triggerName .. "_wall"
	local npc = Entities:FindByName( nil, triggerName .. "_npc" )
	local target = Entities:FindByName( nil, triggerName .. "_target" )
	local wall_ent = Entities:FindByName( nil, wall )
	local wall_origin = wall_ent:GetOrigin()
	local obstructions = Entities:FindAllByName(triggerName .. "_obstruction")

	triggerActive = false
--	npc:SetContextThink( "ResetButtonModel", ResetButtonModel, 1 )
--	npc:CastAbilityOnPosition(target:GetOrigin(), fireTrap, -1 )
	DoEntFire( button, "SetAnimation", "ancient_trigger001_down", 0, self, self )
	DoEntFire( button, "SetAnimation", "ancient_trigger001_down_idle", .35, self, self )
--	DoEntFire( button, "SetAnimation", "ancient_trigger001_up", 2, self, self )
--	DoEntFire( button, "SetAnimation", "ancient_trigger001_idle", 2.5, self, self )

	DoEntFire( wall, "SetAnimation", "earth_spirit_rockspikesphy_anim", 0, self, self )
	DoEntFire( wall, "SetAnimation", "earth_spirit_rockspikesphy_end", 1, self, self )
	for _,obstruction in pairs (obstructions) do
		obstruction:RemoveSelf()
	end
	EmitGlobalSound("gate_break")
	GameRules:ExecuteTeamPing(team, wall_origin.x, wall_origin.y, npc_activator, 0)
	AddFOWViewer(team, wall_origin, 400, 10, false)


	Timers:CreateTimer(4,function()
		wall_ent:RemoveSelf()
	end)

	local heroIndex = trigger.activator:GetEntityIndex()
	local heroHandle = EntIndexToHScript(heroIndex)
end

function OnEndTouch(trigger)
	local triggerName = thisEntity:GetName()
	local team = trigger.activator:GetTeam()
	--print("Trap Button Trigger Exited")
--	local heroIndex = trigger.activator:GetEntityIndex()
--	local heroHandle = EntIndexToHScript(heroIndex)
end


