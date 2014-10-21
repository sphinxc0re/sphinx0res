
-- ChunkGenerated
function OnChunkGenerated(World, ChunkX, ChunkZ, ChunkDesc)
  ObfuscateChunk(World, ChunkX, ChunkZ, ChunkDesc)
end

-- PlayerMoving
function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
  local RelX = BlockX % 16
  local ChunkX = math.floor((BlockX - RelX) / 16)
  local RelZ = BlockZ % 16
  local ChunkZ = math.floor((BlockZ - RelZ) / 16)
  local RelY = BlockY
  
  local World = Player:GetWorld()
  local WorldName = World:GetName()
  
  local DeobBlockArea = cBlockArea()
  DeobBlockArea:LoadFromSchematicFile(GetSchematicFileName(WorldName, ChunkX, ChunkZ))
  
  DeobBlockArea:SetRelBlockTypeMeta(RelX, RelY, RelZ, 0, 0)
  DeobBlockArea:SaveToSchematicFile(GetSchematicFileName(WorldName, ChunkX, ChunkZ))
  
  
  World:SetBlock(BlockX + 1, BlockY, BlockZ, GetDeopBlockType(RelX + 1, RelY, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX + 1, RelY, RelZ, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX - 1, BlockY, BlockZ, GetDeopBlockType(RelX - 1, RelY, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX - 1, RelY, RelZ, ChunkX, ChunkZ, WorldName))
  
  World:SetBlock(BlockX, BlockY + 1, BlockZ, GetDeopBlockType(RelX, RelY + 1, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY + 1, RelZ, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX, BlockY - 1, BlockZ, GetDeopBlockType(RelX, RelY - 1, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY - 1, RelZ, ChunkX, ChunkZ, WorldName))
  
  World:SetBlock(BlockX, BlockY, BlockZ + 1, GetDeopBlockType(RelX, RelY, RelZ + 1, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY, RelZ + 1, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX, BlockY, BlockZ - 1, GetDeopBlockType(RelX, RelY, RelZ - 1, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY, RelZ - 1, ChunkX, ChunkZ, WorldName))
  
  
  
  
  
  World:SetBlock(BlockX + 2, BlockY, BlockZ, GetDeopBlockType(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX - 2, BlockY, BlockZ, GetDeopBlockType(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, WorldName))
  
  World:SetBlock(BlockX, BlockY + 2, BlockZ, GetDeopBlockType(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX, BlockY - 2, BlockZ, GetDeopBlockType(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, WorldName))
  
  World:SetBlock(BlockX, BlockY, BlockZ + 2, GetDeopBlockType(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX, BlockY, BlockZ - 2, GetDeopBlockType(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, WorldName))
  
  
  
  
end
