scoreboard objectives add DS_global dummy
scoreboard objectives add DS_id dummy
scoreboard objectives add DS_comp dummy
scoreboard objectives add DS_deaths deathCount
#scoreboard objectives add DS_leave minecraft.custom:minecraft.leave_game
scoreboard objectives add DS_online dummy
scoreboard objectives add DS_wins dummy
#scoreboard objectives add DS_celebrating dummy

scoreboard players add INGAME DS_global 0
scoreboard players set TICKSEC DS_global 20
scoreboard players set WAITSEC DS_global 4800

# When there is 10s of time left, show a bossbar
bossbar add deathswap:wait_sec {"text":"Swap ETA"}
bossbar set deathswap:wait_sec visible false
bossbar set deathswap:wait_sec max 200

# Add teams (prior players will have a tag denoting that they're a part of the team)
team add DS_players "Death Swap Players"
team add DS_dead "Death Swap Dead Players"

# Team configuration
team modify DS_players collisionRule pushOtherTeams
team modify DS_players friendlyFire false
team modify DS_players suffix {"text":" ❤","color":"green"}
team modify DS_dead suffix {"text":" ☠","color":"red"}

gamerule showDeathMessages false

# To make dying less interruptive
gamerule doImmediateRespawn true
