AddEventHandler('playerDropped', function(Reason) 
	local src = source
	TriggerClientEvent('mercy-base/client/on-logout', src)
	-- TriggerEvent("mercy-logs:server:SendLog", "joinleave", "Dropped", "red", "**".. GetPlayerName(src) .. "** ("..GetPlayerIdentifiers(src)[1]..")  left.. The reason is: " .. reason)
	if Reason ~= "Reconnecting" and src > 60000 then return false end
	if(src==nil or (ServerPlayers[src] == nil)) then return false end
	ServerPlayers[src].Functions.Save()
	ServerPlayers[src] = nil
end)

AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	deferrals.defer()
	local src = source
    FunctionsModule = exports[GetCurrentResourceName()]:FetchModule('Functions')
	Wait(500)
    -- Name
	deferrals.update("📝 Verifying Name..")
	Wait(500)
	local PlayerName = GetPlayerName(src)
	if PlayerName == nil then 
		FunctionsModule.Kick(src, '❌ Don\'t use an empty Steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end
	if(string.match(PlayerName, "[*%%'=`\"]")) then
        FunctionsModule.Kick(src, ' ❌ You have a sign in your name ('..string.match(PlayerName, "[*%%'=`\"]")..') which is not allowed.\nPlease remove this from your name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end
	if (string.match(PlayerName, "drop") or string.match(PlayerName, "table") or string.match(PlayerName, "database")) then
        FunctionsModule.Kick(src, '❌ You have a word in your name which is not allowed.\nPlease remove this from your steam name.', setKickReason, deferrals)
        CancelEvent()
        return false
	end
    -- Steam
	Wait(500)
	deferrals.update("💻 Verifying Steam..")
	Wait(500)
    local Steam = FunctionsModule.GetIdentifier(src, "steam")
	if Steam == nil then 
		FunctionsModule.Kick(src, '❌ Error while contacting steam services, please try again.', setKickReason, deferrals)
		CancelEvent()
		return false
	end
    if ((Steam:sub(1,6) == "steam:") == false) then
        FunctionsModule.Kick(src, '❌ Ensure steam is launched and reconnect.', setKickReason, deferrals)
        CancelEvent()
		return false
	end
	Wait(500)
	deferrals.update("🔒 Verifying Ban Status..")
	Wait(500)
	local IsBanned, Message = FunctionsModule.IsPlayerBanned(src)
    if IsBanned then
		deferrals.update(Message)
        CancelEvent()
        return false
    end
	Wait(500)
	deferrals.update("\n\nWelcome to RPFrogs! Loading final assets...")
	-- TODO: Queue
    Wait(3000)
	deferrals.update("Everything loaded successfully! Joining the world now...")
    Citizen.Wait(2500)
    deferrals.done()
	-- Wait(2500)

	-- TriggerEvent("mercy-logs:server:SendLog", "joinleave", "Queue", "orange", "**"..name .. "** ("..json.encode(GetPlayerIdentifiers(src))..") in queue..")
	-- TriggerEvent("connectqueue:playerConnect", src, setKickReason, deferrals)
end)

RegisterNetEvent("mercy-base/server/load-user", function()
	local src = source
    local SteamIdentifier = FunctionsModule.GetIdentifier(src, "steam")
    DatabaseModule.Execute("SELECT * FROM server_users WHERE steam = ? ", {SteamIdentifier}, function(UserData)
        if UserData[1] == nil then
            DatabaseModule.Insert("INSERT INTO server_users (name, steam, ip, permission, token) VALUES (?, ?, ?, ?, ?)", {
				GetPlayerName(src), 
				SteamIdentifier, 
				GetPlayerEndpoint(src), 
				"user",
				"rpfrog-"..math.random(1111, 9999),
			})
        else
            DatabaseModule.Update("UPDATE server_users SET name = ?, ip = ? WHERE steam = ? ", {GetPlayerName(src), GetPlayerEndpoint(src), SteamIdentifier})
        end
    end)
end)
