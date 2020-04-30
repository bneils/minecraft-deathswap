# minecraft-deathswap
A 1.15.2 .mcfunction minecraft datapack that implements the Minecraft minigame, Death Swap, with 2+ player compatibility. 
No longer do you have to abide by the duality of deathswap! This minigame supports as many players as your server can handle. 

Please note that when players are spread throughout the world, a large amount of new chunks will be loaded, causing a considerable amount of initial lag on most non-triple-A servers (e.g. Hypixel).

In this repo, there is a datapack and NBT structure. If you wish, you may load the structure if you're setting up a lobby for players to queue and un-queue at will. This datapack was developed in 1.15.2, so it is not guaranteed to operate in any prior versions.

To manually queue players, use `team join DS_players <selector>`.
To start the game, use `function deathswap:start` and NOT `deathswap:_start`.
