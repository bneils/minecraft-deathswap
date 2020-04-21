scoreboard players operation WAIT DS_global = WAITSEC DS_global
scoreboard players set INGAME DS_global 1

xp set @a[team=DS_players] 0
gamemode survival @a[team=DS_players]

time set 0
weather clear

# Reset their stats
clear @a[team=DS_players]
effect clear @a[team=DS_players]
effect give @a[team=DS_players] instant_health 5 255 true
effect give @a[team=DS_players] saturation 5 255 true

playsound entity.player.levelup master @a[team=DS_players] ~ ~ ~ 1 0
tellraw @a[team=DS_players] {"text":"Death Swap has commenced!", "color":"green", "bold":true}

# Spread players 1 million blocks away from (0,0) and 15k blocks apart
execute store success score SPREAD_SUCCESS DS_global run spreadplayers 0 0 15000 1000000 false @e[team=DS_players]
# There was somehow an error spreading players. Try again.
execute if score SPREAD_SUCCESS DS_global matches 0 store success score SPREAD_SUCCESS DS_global run spreadplayers 0 0 10000 5000000 false @e[team=DS_players]
# If even THAT does not work, then just log the error.
execute if score SPREAD_SUCCESS DS_global matches 0 run tellraw @a {"text":"Unable to distribute players 5 mil blocks. Maybe try investigating _start.mcfunction?", "color":"red"}