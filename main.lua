
g_Ores = {
E_BLOCK_COAL_ORE,
E_BLOCK_IRON_ORE,
E_BLOCK_GOLD_ORE,
E_BLOCK_DIAMOND_ORE,
E_BLOCK_REDSTONE_ORE,
E_BLOCK_LAPIS_ORE,
E_BLOCK_EMERALD_ORE
}

g_NumOres = #g_Ores

PlayerPos = {}

PLUGIN = nil


function Initialize(Plugin)
	Plugin:SetName("SphinxOrbs")
	Plugin:SetVersion(1)
	
	-- Hooks
  cPluginManager.AddHook(cPluginManager.HOOK_CHUNK_GENERATED, OnChunkGenerated)
  --cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, OnPlayerBreakingBlock)
  --cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_SPAWNED, OnPlayerSpawned)
  --cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)
  
  
	
	PLUGIN = Plugin -- NOTE: only needed if you want OnDisable() to use GetName() or something like that
	
	-- Command Bindings

	LOG("Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end





function OnDisable()
	LOG(PLUGIN:GetName() .. " is shutting down...")
end






function OnChunkGenerated(World, ChunkX, ChunkZ, ChunkDesc)
  ObfuscateChunk(ChunkX, ChunkZ, ChunkDesc)
end



-- Thanks to STR_Warrior for this function
function HasAir(BlockArea, X, Y, Z)
  if (
    cBlockInfo:IsTransparent(BlockArea:GetRelBlockType(X + 1, Y, Z)) or
    cBlockInfo:IsTransparent(BlockArea:GetRelBlockType(X - 1, Y, Z)) or
    cBlockInfo:IsTransparent(BlockArea:GetRelBlockType(X, Y + 1, Z)) or
    cBlockInfo:IsTransparent(BlockArea:GetRelBlockType(X, Y - 1, Z)) or
    cBlockInfo:IsTransparent(BlockArea:GetRelBlockType(X, Y, Z + 1)) or
    cBlockInfo:IsTransparent(BlockArea:GetRelBlockType(X, Y, Z - 1))) then
      return true
  end
    return false
end