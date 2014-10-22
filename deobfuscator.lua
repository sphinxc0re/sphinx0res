---------------------------------------
--------- Deobfuscator-----------------
---------------------------------------

function Deobfuscate(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
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
  
    for CordX = -1, 1 do
      for CordZ = -1, 1 do
        for CordY = -1, 1 do
          World:SetBlock(BlockX + CordX, BlockY + CordY, BlockZ + CordZ, GetDeopBlockType(RelX + CordX, RelY + CordY, RelZ + CordZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX + CordX, RelY + CordY, RelZ + CordZ, ChunkX, ChunkZ, WorldName))
        end
      end
    end
    
  World:SetBlock(BlockX + 2, BlockY, BlockZ, GetDeopBlockType(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX - 2, BlockY, BlockZ, GetDeopBlockType(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, WorldName))
  
  World:SetBlock(BlockX, BlockY + 2, BlockZ, GetDeopBlockType(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX, BlockY - 2, BlockZ, GetDeopBlockType(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, WorldName))
  
  World:SetBlock(BlockX, BlockY, BlockZ + 2, GetDeopBlockType(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, WorldName))
  World:SetBlock(BlockX, BlockY, BlockZ - 2, GetDeopBlockType(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, WorldName), GetDeopBlockMeta(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, WorldName))
  
end


function GetDeopBlockMeta(RelX, RelY, RelZ, ChunkX, ChunkZ, WorldName)
    local BlockChunkX, BlockChunkZ = GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
    local ChunkBlockArea = cBlockArea()
    ChunkBlockArea:LoadFromSchematicFile(GetSchematicFileName(WorldName, BlockChunkX, BlockChunkZ))
    RelX, RelZ = GetRelCoordsFromFalseRelCoords(RelX, RelZ)
    return ChunkBlockArea:GetRelBlockMeta(RelX, RelY, RelZ)
end



function GetDeopBlockType(RelX, RelY, RelZ, ChunkX, ChunkZ, WorldName)
    local BlockChunkX, BlockChunkZ = GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
    local ChunkBlockArea = cBlockArea()
    ChunkBlockArea:LoadFromSchematicFile(GetSchematicFileName(WorldName, BlockChunkX, BlockChunkZ))
    RelX, RelZ = GetRelCoordsFromFalseRelCoords(RelX, RelZ)
    print("BlockType", ChunkX, ChunkZ, RelX, RelY, RelZ) -- For testing purpose
    return ChunkBlockArea:GetRelBlockType(RelX, RelY, RelZ)
end


function GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
  local x = 0
  local z = 0
  
  if (RelX < 0) then
    x = x - 1
  elseif (RelX > 15) then
    x = x + 1
  end
  
  if (RelZ < 0) then
    z = z - 1
  elseif (RelZ > 15) then
    z = z + 1
  end
  
  ChunkX = ChunkX + x
  ChunkZ = ChunkZ + z
  
  return ChunkX, ChunkZ
end


function GetRelCoordsFromFalseRelCoords(RelX, RelZ)
  if (RelX < 0) then
    RelX = RelX + 16
  elseif (RelX > 15) then
    RelX = RelX - 16
  end
  
  if (RelZ < 0) then
    RelZ = RelZ + 16
  elseif (RelZ > 15) then
    RelZ = RelZ - 16
  end
  
  return RelX, RelZ
end
