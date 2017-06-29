# NoNew for Minetest

A mod to prevent connection of newly created accounts.

## What is this?

Special conditions require special measures. You may have a need to prevent any new players from connecting to your server temporarily or permanently. That's your call to make.

Typically though, you might find this useful when your server is under stress from a load of spammy accounts being regularly created.

In this case, activate NoNew to ensure that only previously seen players can join.

## What this is not!

This is not meant to be a ban manager, although technically you could use it as such.

You should have [a separate ban system in place][1], or just the default ban system, along side this mod -- the reason being that *if you are ready to lift the new-accounts restriction, your existing true banishments should remain in place.*

[1]: https://github.com/minetest-mods/xban2

## Settings

* `nonew.state = on/off`

Whether to kick newly created players

## Commands

* `nn_state [ on | off]`

Without arguments, displays the general state of NoNew ; else sets its state

* `nn_block <player>`

Adds a player to the block list and kick them if `nonew.state` is on

* `nn_unblock <player>`

Removes a player form the block list ; only effective if the player had already previously joined.

