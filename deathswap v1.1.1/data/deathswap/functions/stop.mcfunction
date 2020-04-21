# For server outages, ensure that players do not have the tag anymore
tag @a remove DS_wasDead
tag @a remove DS_wasPlayer

tag @a[limit=1,team=DS_players] add DS_winner
scoreboard players set INGAME DS_global 0

title @a title ""

execute if score ALIVE DS_global matches 1 run tellraw @a ["",{"selector":"@e[tag=DS_winner, limit=1]","bold":true,"color":"gold"},{"text":" won Death Swap!","color":"gold"}]
execute if score ALIVE DS_global matches 1 run title @a subtitle ["",{"selector":"@e[tag=DS_winner, limit=1]","bold":true,"color":"gold"},{"text":" won Death Swap!","color":"gold"}]

execute if score ALIVE DS_global matches 0 run tellraw @a ["",{"text":"There was a draw!","color":"red"}]
execute if score ALIVE DS_global matches 0 run title @a subtitle ["",{"text":"There was a draw!","color":"red"}]

tag @e remove DS_winner
gamemode survival @a[team=DS_dead]
kill @a[team=DS_dead]
kill @a[team=DS_players]

# reload all components
team remove DS_players
team remove DS_dead
function deathswap:load