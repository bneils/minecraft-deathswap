scoreboard objectives add DS_global dummy
scoreboard objectives add DS_id dummy
scoreboard objectives add DS_comp dummy
scoreboard objectives add DS_deaths deathCount

scoreboard players add INGAME DS_global 0
scoreboard players set TICKSEC DS_global 20

team add DS_players "Death Swap Players"
team add DS_dead "Death Swap Dead Players"

# Team configuration
team modify DS_players collisionRule pushOtherTeams
team modify DS_players friendlyFire false
team modify DS_players prefix {"text":"Death Swap ","bold":true,"color":"dark_red"}
team modify DS_players suffix {"text":" Alive","color":"green"}

team modify DS_dead prefix {"text":"Death Swap ","bold":true,"color":"dark_red"}
team modify DS_dead suffix {"text":" Dead","color":"red"}

gamerule showDeathMessages false