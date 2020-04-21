# Indicate that this player is currently selected
scoreboard players set @s DS_global 1

# If any unselected players have the same id, they will increment theirs
execute as @a[team=DS_players, scores={DS_global=0}] if score @s DS_id = @p[team=DS_players, scores={DS_global=1}] DS_id run scoreboard players add @s DS_id 1

# Unselect current player
scoreboard players set @s DS_global 0