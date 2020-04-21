# Reset timer
scoreboard players operation WAIT DS_global = WAITSEC DS_global

kill @e[tag=DS_placeholder]

# Give all players their own id before the swap
# DS_id=0 for initial id; DS_global=0 means that the player is unselected
scoreboard players set @a[team=DS_players] DS_id 0
scoreboard players set @a[team=DS_players] DS_global 0
execute as @a[team=DS_players] run function deathswap:give_id

# Summon a placeolder (with last ID) and increment player's ID
execute as @a[team=DS_players] at @s run summon area_effect_cloud ~ ~ ~ {Duration:5, Tags:["DS_placeholder"]}
## Orient that placeholder to have the player's exact pos + orientation
execute as @a[team=DS_players] at @s run tp @e[tag=DS_placeholder, limit=1, sort=nearest] @s

execute as @a[team=DS_players] at @s run scoreboard players operation @e[tag=DS_placeholder, limit=1, sort=nearest] DS_id = @s DS_id
execute as @a[team=DS_players] run scoreboard players add @s DS_id 1

# Now the player with the greatest ID has an id of n (number of players) instead of n-1
# Find that max id
scoreboard players set max DS_id 0
scoreboard players operation max DS_id > @a[team=DS_players] DS_id

# Find the player with the greatest id (hopefully only 1...) and reset it to 0 (modulo n)
execute as @a[team=DS_players] if score @s DS_id = max DS_id run scoreboard players set @s DS_id 0

# Teleport all players to the entity with their id
execute as @e[tag=DS_placeholder] run function deathswap:je

execute as @a[team=DS_players] at @s run particle portal ~ ~ ~ .5 1.5 .5 0.5 500
execute as @a[team=DS_players] at @s run playsound block.portal.travel master @s ~ ~ ~ 0.25 2

# Show a title to the user
title @a[team=DS_players] times 20 40 20
title @a[team=DS_players] title ""
title @a[team=DS_players] subtitle {"text":"Swapped!","bold":true,"color":"dark_purple"}
tellraw @a[team=DS_players] ["",{"text":"ETA of next swap is 4 minutes.","italic":true,"color":"red"}]

effect give @s fire_resistance 5
effect give @s resistance 2 10

kill @e[tag=DS_placeholder]