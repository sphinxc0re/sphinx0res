
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
  local PlayerName = Player:GetName()
  local World = Player:GetWorld()

  local BlockX = NewPosition.x
  local BlockZ = NewPosition.z

  local RelX = BlockX % 16
  local ChunkX = (BlockX - RelX) / 16)
  local RelZ = BlockZ % 16
  local ChunkZ = (BlockZ - RelZ) / 16)
  

  if g_PlayerChunkCaches[PlayerName] == nil then
    g_PlayerChunkCaches[PlayerName] = cSmallChunkCache:NewFromChunkPos(World, ChunkX, ChunkZ)
  elseif g_PlayerChunkCaches[PlayerName].OriginX ~= ChunkX or g_PlayerChunkCaches[PlayerName].OriginY ~= ChunkY then
    g_PlayerChunkCaches[PlayerName]:NewFromChunkPos(World, ChunkX, ChunkZ)
  end
end
