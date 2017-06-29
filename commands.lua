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
	
		for playername in tokens do
			nonew:unblock( playername )
		end
	end,
})

minetest.register_chatcommand("nn_block", {
	description = "",
	privs = {nonew = true},
	params = "<player1> <player2> ...",
	func = function(caller, argstring)
		local tokens = tokenize(argstring)
	
		for playername in tokens do
			nonew:block( playername )
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
	else
		minetest.chat_send_player(caller, "Invalid option for "..option.." - please choose on or off.")
		return
	end

	minetest.chat_send_player(caller, "NoNew "..option..": "..nonew[option])
end

minetest.register_chatcommand("nn_state",{
	description = "",
	privs = {nonew = true},
	params = "{ on | off }",
	func = function(caller, argstring)
		setstate(caller, argstring, "state")
	end,
})
