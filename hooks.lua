
-- ChunkGenerated
function OnChunkGenerated(World, ChunkX, ChunkZ, ChunkDesc)
  ObfuscateChunk(World, ChunkX, ChunkZ, ChunkDesc)
end

-- PlayerBreakingBlock
function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
  Deobfuscate(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
end

-- PlayerPlacingBlock
function OnPlayerPlacingBlock()
  
end

-- PlayerMoving
function OnPlayerMoving(Player, OldPosition, NewPosition)
  local World = Player:GetWorld()
  local RelX = NewPosition.x % 16
  local ChunkX = math.floor((NewPosition.x - RelX) / 16)
  local RelZ = NewPosition.z % 16
  local ChunkZ = math.floor((NewPosition.z - RelZ) / 16)
  
  if g_PlayerChunkCaches[Player:GetName()] == nil then
    g_PlayerChunkCaches[Player:GetName()] = cSmallChunkCache:NewFromChunkPos(World, ChunkX, ChunkZ)
  end 
  
  local PlayerChunks = g_PlayerChunkCaches[Player:GetName()]
  
end