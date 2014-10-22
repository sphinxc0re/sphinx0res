-----------------------------------
----- OBFUSCATOR ------------------
-----------------------------------

function ObfuscateChunk(World, ChunkX, ChunkZ, ChunkDesc)
  local WorldName = World:GetName()
  if not cFile:IsFolder(SCHEMFOLDER .. "/" .. WorldName) then
    cFile:CreateFolder(SCHEMFOLDER .. "/" .. WorldName)
  end
  
  if not IsChunkGenerated(WorldName, ChunkX, ChunkZ) then
    local ChunkBlockArea = cBlockArea()
    ChunkDesc:ReadBlockArea(ChunkBlockArea, 0, 15, 0, 255, 0, 15)
    ChunkBlockArea:SaveToSchematicFile(GetSchematicFileName(WorldName, ChunkX, ChunkZ))
    -- LOG("[" .. PLUGIN:GetName() .. "] Saved chunk ".. ChunkX .. "#" .. ChunkZ .." to drive!")
  end
  
  
  if not ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ, WorldName) then
    -- LOG("[" .. PLUGIN:GetName() .. "] Executing flower alogrithm!")
    if ChunkHasAllDirectNeigborsGenerated(ChunkX + 1, ChunkZ, WorldName) and not IsObfuscated(WorldName, ChunkX + 1, ChunkZ) then
      World:RegenerateChunk(ChunkX + 1, ChunkZ)
      SetObfuscated(WorldName, ChunkX + 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX - 1, ChunkZ, WorldName) and not IsObfuscated(WorldName, ChunkX - 1, ChunkZ) then
      World:RegenerateChunk(ChunkX - 1, ChunkZ)
      SetObfuscated(WorldName, ChunkX - 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ + 1, WorldName) and not IsObfuscated(WorldName, ChunkX, ChunkZ + 1) then
      World:RegenerateChunk(ChunkX, ChunkZ + 1)
      SetObfuscated(WorldName, ChunkX, ChunkZ + 1)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ - 1, WorldName) and not IsObfuscated(WorldName, ChunkX, ChunkZ - 1) then
      World:RegenerateChunk(ChunkX, ChunkZ - 1)
      SetObfuscated(WorldName, ChunkX, ChunkZ - 1)
    end
    
    return
  end
  
  LOG("[" .. PLUGIN:GetName() .. "] Obfuscating chunk X: " .. ChunkX .. "  Z: " .. ChunkZ)
  for ForCoordY = 1, ChunkDesc:GetMaxHeight() do
    for ForCoordX = 0, 15 do
      for ForCoordZ = 0, 15 do
        if not HasAir(World, ForCoordX, ForCoordY, ForCoordZ, ChunkX, ChunkZ) then
          ChunkDesc:SetBlockType(ForCoordX, ForCoordY, ForCoordZ, g_Ores[math.random(1, g_NumOres)])
        end
      end
    end
  end
  LOG("[" .. PLUGIN:GetName() .. "] Obfuscated chunk X: " .. ChunkX .. "  Z: " .. ChunkZ)
end



function SetObfuscated(WorldName, ChunkX, ChunkZ)
  cFile:Copy(GetSchematicFileName(WorldName, ChunkX, ChunkZ), SCHEMFOLDER .. "/" .. WorldName .. "/_OBCHNK#" .. ChunkX .. "#" .. ChunkZ)
  -- LOG("[" .. PLUGIN:GetName() .. "] Chunk is going to be obfuscated X: " .. ChunkX .. "  Z: " .. ChunkZ)
end


function IsObfuscated(WorldName, ChunkX, ChunkZ)
  return cFile:Exists(SCHEMFOLDER .. "/" .. WorldName .. "/_OBCHNK#" .. ChunkX .. "#" .. ChunkZ)
end



-- Thanks to STR_Warrior for this function
function HasAir(World, RelX, RelY, RelZ, ChunkX, ChunkZ)
  local WorldName = World:GetName()
  if (      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 1, RelY, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 1, RelY, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 1, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 1, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ + 1, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ - 1, ChunkX, ChunkZ, WorldName))     
      ) then
      return true
  end
    return false
end