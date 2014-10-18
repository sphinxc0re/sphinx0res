-----------------------------------
----- OBFUSCATOR ------------------
-----------------------------------

function ObfuscateChunk(ChunkX, ChunkZ, ChunkDesc)
  ChunkBlockArea = cBlockArea()
  ChunkDesc:ReadBlockArea(ChunkBlockArea, 0, 14, 0, (ChunkDesc:GetMaxHeight()), 0, 14)
  -- LOG("READ CHUNK")
  for RelY = 0, ChunkDesc:GetMaxHeight() do
    for RelX = 0, 15 do
      for RelZ = 0, 15 do
        if not HasAir(ChunkDesc, RelX, RelY, RelZ) then
          ChunkDesc:SetBlockType(RelX, RelY, RelZ, g_Ores[math.random(1, g_NumOres)])
        end
      end
    end
  end
  cFile:CreateFolder("SporeSchema")
  ChunkBlockArea:SaveToSchematicFile("SporeSchema/CHUNK#" .. ChunkX .. "#" .. ChunkZ .. ".schematic")
  LOG("[" .. PLUGIN:GetName() .. "] Saved chunk ".. ChunkX .. "#" .. ChunkZ .." to drive!")
end




-- Thanks to STR_Warrior for this function
function HasAir(BlockArea, X, Y, Z)
  if (
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X + 1, Y, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X - 1, Y, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y + 1, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y - 1, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y, Z + 1)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y, Z - 1)) or
      
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y + 1, Z - 1)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y - 1, Z - 1)) or
      
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y + 1, Z + 1)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y - 1, Z + 1)) or
      
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X - 1, Y + 1, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X - 1, Y - 1, Z)) or
      
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X + 1, Y + 1, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X + 1, Y - 1, Z)) or
      
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X + 2, Y, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X - 2, Y, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y + 2, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y - 2, Z)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y, Z + 2)) or
      cBlockInfo:IsTransparent(BlockArea:GetBlockType(X, Y, Z - 2))     
      ) then
      return true
  end
    return false
end