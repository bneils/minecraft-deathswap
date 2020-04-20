# Indicate that this player is currently selected
scoreboard players set @s DS_global 1

# If any unselected players have the same id, they will increment theirs
execute as @e[team=DS_players,scores={DS_global=0}] if score @s DS_id = @e[team=DS_players,scores={DS_global=1},limit=1,sort=nearest] DS_id run scoreboard players add @s DS_id 1

scoreboard players set @s DS_global 0