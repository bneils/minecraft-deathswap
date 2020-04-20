scoreboard players set INGAME DS_global 0

tag @e[limit=1,team=DS_players] add DS_winner
team leave @e[team=DS_players]

title @a title ""

execute if score ALIVE DS_global matches 1 run tellraw @a ["",{"selector":"@e[tag=DS_winner, limit=1]","bold":true,"color":"gold"},{"text":" won Death Swap!","color":"gold"}]
execute if score ALIVE DS_global matches 1 run title @a subtitle ["",{"selector":"@e[tag=DS_winner, limit=1]","bold":true,"color":"gold"},{"text":" won Death Swap!","color":"gold"}]

execute if score ALIVE DS_global matches 0 run tellraw @a ["",{"text":"There was a draw!","color":"red"}]
execute if score ALIVE DS_global matches 0 run title @a subtitle ["",{"text":"There was a draw!","color":"red"}]

tag @e remove DS_winner
gamemode survival @a[team=DS_dead]
kill @a[team=DS_dead]

team leave @a[team=DS_dead]
scoreboard players reset @a[scores={DS_deaths=1..}] DS_deaths