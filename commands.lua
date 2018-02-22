minetest.register_privilege("nonew", "Allow configuring nonew")

local function tokenize(argstring)
	local args = {}
	
	for token in argstring:gmatch("[^%s]+") do
		args[#args+1] = token
	end

	return args
end

minetest.register_chatcommand("nn_unblock", {
	description = "Unblock players",
	privs = {nonew = true},
	params = "<player1> <player2> ...",
	func = function(caller, argstring)
		local tokens = tokenize(argstring)
	
		for i = 1, #tokens do
			minetest.debug("NoNew: "..caller.." unblocks "..tokens[i])
			nonew:unblock( tokens[i] )
		end
	end,
})

minetest.register_chatcommand("nn_block", {
	description = "",
	privs = {nonew = true},
	params = "<player1> <player2> ...",
	func = function(caller, argstring)
		local tokens = tokenize(argstring)
	
		for i = 1, #tokens do
			minetest.debug("NoNew: "..caller.." blocks "..tokens[i])
			nonew:block( tokens[i] )
		end
	end,
})

local function setstate(caller, argstring, option)
	local tokens = tokenize(argstring)
	local value = tokens[1]

	if value == 'on' then
		nonew[option] = true
	elseif value == 'off' then
		nonew[option] = false
	end

	minetest.chat_send_player(caller, "NoNew "..option..": "..tostring(nonew[option]) )
end

minetest.register_chatcommand("nn_state",{
	description = "",
	privs = {nonew = true},
	params = "{ on | off }",
	func = function(caller, argstring)
		setstate(caller, argstring, "state")
	end,
})
