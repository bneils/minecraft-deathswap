# Detect that players have joined for the second time (if they're online but not yet marked as online)
tag @a[scores={DS_online=0}, tag=DS_wasPlayer] add DS_quitter
tag @a[scores={DS_online=0}, tag=DS_wasDead] add DS_quitter
tellraw @a[tag=DS_quitter] {"text":"You left the game, so you were kicked.","color":"red"}
gamemode survival @a[tag=DS_quitter]
team leave @a[tag=DS_quitter]
kill @a[tag=DS_quitter]
tag @a remove DS_quitter

## Update online status
scoreboard players set * DS_online 0
scoreboard players set @a DS_online 1

## In the case the game crashed, players will not have a "leave" score. All current players must be awarded a tag
#kill @a[team=!DS_players, tag=DS_wasPlayer]
#tag @a[team=!DS_players, tag=DS_wasPlayer] remove DS_wasPlayer
#kill @a[team=!DS_dead, tag=DS_wasDead]
#tag @a[team=!DS_players, tag=DS_wasDead] remove DS_wasDead

tag @a remove DS_wasPlayer
tag @a remove DS_wasDead
tag @a[team=DS_players] add DS_wasPlayer
tag @a[team=DS_dead] add DS_wasDead

## Cull the team (this isn't redundant)
team empty DS_players
team join DS_players @a[tag=DS_wasPlayer]

team empty DS_dead
team join DS_dead @a[tag=DS_wasDead]

# Decrement the wait counter
execute if score INGAME DS_global matches 1.. run scoreboard players remove WAIT DS_global 1

scoreboard players operation SECONDS DS_global = WAIT DS_global
scoreboard players operation SECONDS DS_global /= TICKSEC DS_global

# Alert players that the swap is going to happen soon
## Manage bossbar
bossbar set deathswap:wait_sec players @a[team=DS_players]
execute store result bossbar deathswap:wait_sec value run scoreboard players get WAIT DS_global
execute if score SECONDS DS_global matches 1..10 if score INGAME DS_global matches 1.. run bossbar set deathswap:wait_sec visible true
execute if score SECONDS DS_global matches 10 if score INGAME DS_global matches 1.. run bossbar set deathswap:wait_sec color green
execute if score SECONDS DS_global matches 7 if score INGAME DS_global matches 1.. run bossbar set deathswap:wait_sec color yellow
execute if score SECONDS DS_global matches 4 if score INGAME DS_global matches 1.. run bossbar set deathswap:wait_sec color red
execute if score SECONDS DS_global matches 0 if score INGAME DS_global matches 1.. run bossbar set deathswap:wait_sec visible false

## Make a sound when a second passes
scoreboard players operation REM_TICK DS_global = WAIT DS_global
scoreboard players operation REM_TICK DS_global %= TICKSEC DS_global
execute if score INGAME DS_global matches 1.. if score SECONDS DS_global matches ..10 if score REM_TICK DS_global matches 0 as @a at @s run playsound minecraft:ui.button.click master @s ~ ~ ~ 1 2

## Set the actionbar
execute if score INGAME DS_global matches 1.. if score SECONDS DS_global matches ..10 run title @a[team=DS_players] actionbar ["",{"text":"Swapping in ","bold":true,"color":"red"},{"score":{"name":"SECONDS","objective":"DS_global"},"color":"red","bold":true},{"text":" second(s)","color":"red","bold":true}]

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
execute if score WAIT DS_global matches ..0 run function deathswap:swap
execute if score WAIT DS_global matches 40 as @a[team=DS_players] at @s run playsound block.portal.trigger master @s ~ ~ ~ 0.25 2

# End game
execute store result score ALIVE DS_global run team list DS_players
execute if score INGAME DS_global matches 1.. if score ALIVE DS_global matches 0..1 run function deathswap:stop
