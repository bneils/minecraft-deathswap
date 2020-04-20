function deathswap:uninstall
function deathswap:load

# wait for 2 minutes (20 ticks/sec * 2min * 60sec/min) = 2400
scoreboard players set WAIT DS_global 2400
scoreboard players set INGAME DS_global 1

gamemode survival @a[team=DS_players]

# Reset their stats
clear @a[team=DS_players]
effect clear @a[team=DS_players]
effect give @a[team=DS_players] instant_health 5 255 true
effect give @a[team=DS_players] saturation 5 255 true

playsound entity.player.levelup master @a[team=DS_players] ~ ~ ~ 1 0
tellraw @a[team=DS_players] {"text":"Death swap has commenced!", "color":"green"}

spreadplayers 0 0 100000 200000 false @e[team=DS_players]