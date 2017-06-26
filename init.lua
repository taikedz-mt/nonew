nonew = {}
nonew.players = {}
nonew.data = minetest.get_worldpath().."/blocked_nonew.txt"

nonew.action = function(playername)
	if nonew.players[playername] == 1 then
		minetest.kick_player(playername, "No new players are being accepted at the moment.")
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

local function register_newcomer(playername)
	nonew.players[playername] = 1
	write_blocked_players()
end

minetest.register_on_newplayer(function(player)
	local playername = player:get_player_name()
	register_newcomer(playername)
	nonew.action(playername)
end)

read_blocked_players()
