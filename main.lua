
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
  Chunk0 = cBlockArea()
  ChunkDesc:ReadBlockArea(Chunk0, 0, 14, 0, (ChunkDesc:GetMaxHeight()), 0, 14)
  -- LOG("READ CHUNK")
  for y = 0, ChunkDesc:GetMaxHeight() do
    for x = 0, 14 do
      for z = 0, 14 do
        local btype = Chunk0:GetBlockType(x, y, z)
        for n = 0, g_NumOres do
          if btype == g_Ores[n] then
            -- LOG("Ore found at " .. x .. " " .. y .. " " .. z .. " ")
            World:ForEachPlayer(
              function(Player)
                local ClientHandle = Player:GetClientHandle()
                if not HasAir(World, x, y, z) then
                  Chunk0:SetBlockType(x, y, z, 0)
                end
              end
            )
          end
        end
      end
    end
  end
end




function HasAir(World, X, Y, Z)
  if (
    cBlockInfo:IsTransparent(World:GetBlock(X + 1, Y, Z)) or
    cBlockInfo:IsTransparent(World:GetBlock(X - 1, Y, Z)) or
    cBlockInfo:IsTransparent(World:GetBlock(X, Y + 1, Z)) or
    cBlockInfo:IsTransparent(World:GetBlock(X, Y - 1, Z)) or
    cBlockInfo:IsTransparent(World:GetBlock(X, Y, Z + 1))or
    cBlockInfo:IsTransparent(World:GetBlock(X, Y, Z - 1))) then
      return true
  end
    return false
end