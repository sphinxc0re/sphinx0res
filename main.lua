
g_Ores = {
E_BLOCK_IRON_ORE,
E_BLOCK_COAL_ORE,
E_BLOCK_MOSSY_COBBLESTONE,
E_BLOCK_GOLD_ORE,
E_BLOCK_DIAMOND_ORE,
E_BLOCK_REDSTONE_ORE,
E_BLOCK_LAPIS_ORE,
E_BLOCK_EMERALD_ORE
}

g_NumOres = #g_Ores

PlayerPos = {}

PLUGIN = nil

PLUGFOLDER = "SphinxOres"
SCHEMFOLDER = PLUGFOLDER .. "/Schema"


function Initialize(Plugin)
	Plugin:SetName("SphinxOres")
	Plugin:SetVersion(1)
	
  cFile:CreateFolder(PLUGFOLDER)
  cFile:CreateFolder(SCHEMFOLDER)
  
  
  
	-- Hooks
  cPluginManager.AddHook(cPluginManager.HOOK_CHUNK_GENERATED, OnChunkGenerated)
  -- cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, OnPlayerBreakingBlock)
  
  
	
	PLUGIN = Plugin -- NOTE: only needed if you want OnDisable() to use GetName() or something like that
	
	-- Command Bindings

	LOG("Initialised " .. Plugin:GetName() .. " v." .. Plugin:GetVersion())
	return true
end




function OnDisable()
	LOG(PLUGIN:GetName() .. " is shutting down...")
end




function GetSchematicFileName(WorldName, ChunkX, ChunkZ)
  return SCHEMFOLDER .. "/" .. WorldName .. "/CHUNK#" .. ChunkX .. "#" .. ChunkZ .. ".schematic"
end




function IsChunkGenerated(ChunkX, ChunkZ, WorldName)
  return cFile:Exists(GetSchematicFileName(WorldName, ChunkX, ChunkZ))
end




function ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ, WorldName)
  if  IsChunkGenerated(ChunkX + 1, ChunkZ, WorldName) and
      IsChunkGenerated(ChunkX - 1, ChunkZ, WorldName) and
      IsChunkGenerated(ChunkX, ChunkZ + 1, WorldName) and
      IsChunkGenerated(ChunkX, ChunkZ - 1, WorldName) and
      IsChunkGenerated(ChunkX + 1, ChunkZ + 1, WorldName) and
      IsChunkGenerated(ChunkX - 1, ChunkZ - 1, WorldName) and
      IsChunkGenerated(ChunkX - 1, ChunkZ + 1, WorldName) and
      IsChunkGenerated(ChunkX + 1, ChunkZ - 1, WorldName)
      
  then
    return true
  else
    return false
  end
end


function ChunkHasAnyDirectNeigborGenerated(ChunkX, ChunkZ, WorldName)
  if  IsChunkGenerated(ChunkX + 1, ChunkZ, WorldName) or
      IsChunkGenerated(ChunkX - 1, ChunkZ, WorldName) or
      IsChunkGenerated(ChunkX, ChunkZ + 1, WorldName) or
      IsChunkGenerated(ChunkX, ChunkZ - 1, WorldName) or
      IsChunkGenerated(ChunkX + 1, ChunkZ + 1, WorldName) or
      IsChunkGenerated(ChunkX - 1, ChunkZ - 1, WorldName) or
      IsChunkGenerated(ChunkX - 1, ChunkZ + 1, WorldName) or
      IsChunkGenerated(ChunkX + 1, ChunkZ - 1, WorldName)
  then
    return true
  else
    return false
  end
end




