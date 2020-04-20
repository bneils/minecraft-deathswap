# minecraft-deathswap
A .mcfunction minecraft datapack that implements the Minecraft minigame, Death Swap, with 2+ player compatibility.

Several player cycling was achieved by assigning unique numerical ids to all players prior to teleporting.
Each player summons an entity with their ID.
Then, every player's ID is assigned with `id=(id+1)%n` where n is the number of players and id begins at 0.
Finally, all players teleport to the entity with their ID.
