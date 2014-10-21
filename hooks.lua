
-- ChunkGenerated
function OnChunkGenerated(World, ChunkX, ChunkZ, ChunkDesc)
  ObfuscateChunk(World, ChunkX, ChunkZ, ChunkDesc)
end

-- PlayerMoving
function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
  RelX = BlockX % 16
  ChunkX = math.floor((BlockX - RelX) / 16)
  RelZ = BlockZ % 16
  ChunkZ = math.floor((BlockZ - RelZ) / 16)
  RelY = BlockY
  
  local World = Player:GetWorld()
  
  DeobBlockArea = cBlockArea()
  DeobBlockArea:LoadFromSchematicFile(GetSchematicFileName(World:GetName(), ChunkX, ChunkZ))
  
  DeobBlockArea:SetRelBlockTypeMeta(RelX, RelY, RelZ, 0, 0)
  DeobBlockArea:SaveToSchematicFile(GetSchematicFileName(World:GetName(), ChunkX, ChunkZ))
  
  
  
  
  World:SetBlock(BlockX + 1, BlockY, BlockZ, GetDeopBlockType(RelX + 1, RelY, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX + 1, RelY, RelZ, ChunkX, ChunkZ, World:GetName()))
  World:SetBlock(BlockX - 1, BlockY, BlockZ, GetDeopBlockType(RelX - 1, RelY, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX - 1, RelY, RelZ, ChunkX, ChunkZ, World:GetName()))
  
  World:SetBlock(BlockX, BlockY + 1, BlockZ, GetDeopBlockType(RelX, RelY + 1, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY + 1, RelZ, ChunkX, ChunkZ, World:GetName()))
  World:SetBlock(BlockX, BlockY - 1, BlockZ, GetDeopBlockType(RelX, RelY - 1, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY - 1, RelZ, ChunkX, ChunkZ, World:GetName()))
  
  World:SetBlock(BlockX, BlockY, BlockZ + 1, GetDeopBlockType(RelX, RelY, RelZ + 1, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY, RelZ + 1, ChunkX, ChunkZ, World:GetName()))
  World:SetBlock(BlockX, BlockY, BlockZ - 1, GetDeopBlockType(RelX, RelY, RelZ - 1, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY, RelZ - 1, ChunkX, ChunkZ, World:GetName()))
  
  
  
  
  
  World:SetBlock(BlockX + 2, BlockY, BlockZ, GetDeopBlockType(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, World:GetName()))
  World:SetBlock(BlockX - 2, BlockY, BlockZ, GetDeopBlockType(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, World:GetName()))
  
  World:SetBlock(BlockX, BlockY + 2, BlockZ, GetDeopBlockType(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, World:GetName()))
  World:SetBlock(BlockX, BlockY - 2, BlockZ, GetDeopBlockType(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, World:GetName()))
  
  World:SetBlock(BlockX, BlockY, BlockZ + 2, GetDeopBlockType(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, World:GetName()))
  World:SetBlock(BlockX, BlockY, BlockZ - 2, GetDeopBlockType(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, World:GetName()), GetDeopBlockMeta(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, World:GetName()))
  
  
  
  
end
