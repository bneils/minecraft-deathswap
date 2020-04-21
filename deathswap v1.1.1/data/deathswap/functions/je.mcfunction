# The name of this file is "Jump Equal" (assembly allusion)
# This will be invoked by all placeholders in swap.mcfunction

# set all player's TEMP score to their id
execute as @a[team=DS_players] run scoreboard players operation @s DS_comp = @s DS_id

# subtract the stand's ID from all players' TEMP
scoreboard players operation @a[team=DS_players] DS_comp -= @s DS_id

# teleport the player with a TEMP of 0 to the current stand
tp @a[team=DS_players, scores={DS_comp=0}] @s