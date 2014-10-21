---------------------------------------
--------- Deobfuscator-----------------
---------------------------------------

function Deobfuscate()
    
end


function GetDeopBlockMeta(RelX, RelY, RelZ, ChunkX, ChunkZ, WorldName)
    BlockChunkX, BlockChunkZ = GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
    ChunkBlockarea = cBlockArea()
    ChunkBlockArea:LoadFromSchematicFile(GetSchematicFileName(WorldName, BlockChunkX, BlockChunkZ))
    RelX, RelZ = GetRelCoordsFromFalseRelCoords(RelX, RelZ)
    return ChunkBlockArea:GetRelBlockMeta(RelX, RelY, RelZ)
end



function GetDeopBlockType(RelX, RelY, RelZ, ChunkX, ChunkZ, WorldName)
    BlockChunkX, BlockChunkZ = GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
    ChunkBlockarea = cBlockArea()
    ChunkBlockArea:LoadFromSchematicFile(GetSchematicFileName(WorldName, BlockChunkX, BlockChunkZ))
    RelX, RelZ = GetRelCoordsFromFalseRelCoords(RelX, RelZ)
    return ChunkBlockArea:GetRelBlockType(RelX, RelY, RelZ)
end


function GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
  x = 0
  z = 0
  
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
