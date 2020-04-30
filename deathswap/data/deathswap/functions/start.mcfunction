execute if score ALIVE DS_global matches ..1 run tellraw @a {"text":"Can't start Death Swap due to insufficient players.", "color":"red"}
execute if score ALIVE DS_global matches ..1 run playsound minecraft:block.note_block.harp master @a ~ ~ ~ 3 0

execute if score INGAME DS_global matches 1.. run tellraw @a {"text":"Unable to start Death Swap as it's already running!", "color": "red"}
execute if score INGAME DS_global matches 1.. run playsound minecraft:block.note_block.harp master @a ~ ~ ~ 3 0

execute if score INGAME DS_global matches 0 if score ALIVE DS_global matches 2.. run function deathswap:_start