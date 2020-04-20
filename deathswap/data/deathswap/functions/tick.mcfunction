execute if score INGAME DS_global matches 1.. run scoreboard players remove WAIT DS_global 1

scoreboard players operation SECONDS DS_global = WAIT DS_global
scoreboard players operation SECONDS DS_global /= TICKSEC DS_global

execute if score SECONDS DS_global matches ..5 if score INGAME DS_global matches 1.. run title @a[team=DS_players] actionbar ["",{"text":"Swapping in ","bold":true,"color":"red"},{"score":{"name":"SECONDS","objective":"DS_global"},"color":"red","bold":true},{"text":" second(s)","color":"red","bold":true}]

# When someone dies, announce it to everyone, and take them away from the game.
## Remove the player from their team as to only display their name
tag @a[team=DS_players, scores={DS_deaths=1..}] add DS_died
team leave @a[team=DS_players, tag=DS_died]

## Tell alive, dead, and players in limbo (players on the respawn screen)
execute as @a[tag=DS_died, scores={DS_deaths=1..}] run tellraw @a[team=DS_players] ["",{"selector":"@s","bold":true,"color":"red"},{"text":" has died!","color":"red"}]
execute as @a[tag=DS_died, scores={DS_deaths=1..}] run tellraw @a[team=DS_dead] ["",{"selector":"@s","bold":true,"color":"red"},{"text":" has died!","color":"red"}]
execute as @a[tag=DS_died, scores={DS_deaths=1..}] run tellraw @s ["",{"selector":"@s","bold":true,"color":"red"},{"text":" has died!","color":"red"}]

team join DS_dead @a[tag=DS_died, scores={DS_deaths=1..}]
scoreboard players reset @a[scores={DS_deaths=1..}] DS_deaths

## When the player respawns, make them a spectator
execute if score INGAME DS_global matches 1.. run gamemode spectator @e[type=player, tag=DS_died]
tag @e[type=player, tag=DS_died] remove DS_died

# Swap players
execute if score WAIT DS_global matches 0 run function deathswap:swap
execute if score WAIT DS_global matches 40 as @a[team=DS_players] at @s run playsound block.portal.trigger master @s ~ ~ ~ 0.25 2

# End game
execute store result score ALIVE DS_global run team list DS_players
execute if score INGAME DS_global matches 1.. if score ALIVE DS_global matches 0..1 run function deathswap:stop