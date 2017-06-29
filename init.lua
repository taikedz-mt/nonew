nonew = {}
nonew.players = {}
nonew.data = minetest.get_worldpath().."/blocked_nonew.txt"

nonew.state = true
if minetest.setting_get("nonew.state") == 'off' then
	nonew.state = false
end

-- This can be overridden with another function
function nonew:action(playername)
	if not nonew.state then return end

	if nonew.players[playername] == 1 then
		minetest.after(0, function()
			minetest.kick_player(playername, "No new players are being accepted at the moment.")
		end)
	end
end

local function write_blocked_players()
	local sdata = minetest.serialize(nonew.players)

	if not sdata then
		minetest.log("error", "No player object data")
		return
	end

	local file, err = io.open(nonew.data, "w")
	if err then return err end

	file:write(sdata)

	file:close()
end

local function read_blocked_players()
	local file, err = io.open(nonew.data, "r")
	if err then return err end

	local sdata = file:read("*a")
	file:close()

	nonew.players = minetest.deserialize(sdata)
end

function nonew:unblock(playername)
	if not playername then return end

	nonew.players[playername] = nil
	write_blocked_players()
end

function nonew:block(playername)
	if not playername then return end

	nonew.players[playername] = 1
	write_blocked_players()

	if minetest.get_player_by_name(playername) then
		nonew:action(playername)
	end
end

minetest.register_on_newplayer(function(player)
	local playername = player:get_player_name()
	nonew:block(playername)
	nonew:action(playername)
end)

minetest.register_on_prejoinplayer(function(playername, ip)
	-- If they are already in the block list, just get them here
	nonew:action(playername)
end)

read_blocked_players()

dofile(minetest.get_modpath("nonew").."/commands.lua")
