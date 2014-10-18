
-- ChunkGenerated
function OnChunkGenerated(World, ChunkX, ChunkZ, ChunkDesc)
  ObfuscateChunk(ChunkX, ChunkZ, ChunkDesc)
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
  DeobBlockArea:LoadFromSchematicFile("SporeSchema/CHUNK#" .. ChunkX .. "#" .. ChunkZ .. ".schematic")
  
  DeobBlockArea:SetRelBlockTypeMeta(RelX, RelY, RelZ, 0, 0)
  DeobBlockArea:SaveToSchematicFile("SporeSchema/CHUNK#" .. ChunkX .. "#" .. ChunkZ .. ".schematic")
  
  World:SetBlock(BlockX + 1, BlockY, BlockZ, DeobBlockArea:GetRelBlockType(RelX + 1, RelY, RelZ), DeobBlockArea:GetRelBlockMeta(RelX + 1, RelY, RelZ))
  World:SetBlock(BlockX - 1, BlockY, BlockZ, DeobBlockArea:GetRelBlockType(RelX - 1, RelY, RelZ), DeobBlockArea:GetRelBlockMeta(RelX - 1, RelY, RelZ))
  
  World:SetBlock(BlockX, BlockY + 1, BlockZ, DeobBlockArea:GetRelBlockType(RelX, RelY + 1, RelZ), DeobBlockArea:GetRelBlockMeta(RelX, RelY + 1, RelZ))
  World:SetBlock(BlockX, BlockY - 1, BlockZ, DeobBlockArea:GetRelBlockType(RelX, RelY - 1, RelZ), DeobBlockArea:GetRelBlockMeta(RelX, RelY - 1, RelZ))
  
  World:SetBlock(BlockX, BlockY, BlockZ + 1, DeobBlockArea:GetRelBlockType(RelX, RelY, RelZ + 1), DeobBlockArea:GetRelBlockMeta(RelX, RelY, RelZ + 1))
  World:SetBlock(BlockX, BlockY, BlockZ - 1, DeobBlockArea:GetRelBlockType(RelX, RelY, RelZ - 1), DeobBlockArea:GetRelBlockMeta(RelX, RelY, RelZ - 1))
  
end
