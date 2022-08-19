local triggerActive = {}

function OnStartTouch(trigger)

	local npc = trigger.activator
	local npc_entindex = npc:entindex()
	local triggerName = thisEntity:GetName()
	if triggerName == "trigger_spawn_point_1" then
		spawn_point_name = "spawn_point_1"
	elseif triggerName == "trigger_spawn_point_2" then
		spawn_point_name = "spawn_point_2"
	end

	if triggerActive[npc_entindex] then
		print( "Trigger activated" )
		return
	end

	npc.spawn_point = Entities:FindByName( nil, spawn_point_name ):GetOrigin()


	triggerActive[npc_entindex] = true
end


