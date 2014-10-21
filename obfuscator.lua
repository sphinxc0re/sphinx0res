-----------------------------------
----- OBFUSCATOR ------------------
-----------------------------------

function ObfuscateChunk(World, ChunkX, ChunkZ, ChunkDesc)
  if not cFile:IsFolder(SCHEMFOLDER .. "/" .. World:GetName()) then
    cFile:CreateFolder(SCHEMFOLDER .. "/" .. World:GetName())
  end
  
  if not cFile:Exists(GetSchematicFileName(World:GetName(), ChunkX, ChunkZ)) then
    local ChunkBlockArea = cBlockArea()
    ChunkDesc:ReadBlockArea(ChunkBlockArea, 0, 15, 0, 255, 0, 15)
    ChunkBlockArea:SaveToSchematicFile(GetSchematicFileName(World:GetName(), ChunkX, ChunkZ))
    -- LOG("[" .. PLUGIN:GetName() .. "] Saved chunk ".. ChunkX .. "#" .. ChunkZ .." to drive!")
  end
  
  WorldFolderContents = cFile:GetFolderContents(SCHEMFOLDER .. "/" .. World:GetName())
  if #WorldFolderContents < 6 then
    return
  end
  
  if not ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ, World:GetName()) then
    LOG("[" .. PLUGIN:GetName() .. "] Executing flower alogrithm!")
    if ChunkHasAllDirectNeigborsGenerated(ChunkX + 1, ChunkZ, World:GetName()) and not IsObfuscated(World:GetName(), ChunkX + 1, ChunkZ) then
      World:RegenerateChunk(ChunkX + 1, ChunkZ)
      SetObfuscated(World:GetName(), ChunkX + 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX - 1, ChunkZ, World:GetName()) and not IsObfuscated(World:GetName(), ChunkX - 1, ChunkZ) then
      World:RegenerateChunk(ChunkX - 1, ChunkZ)
      SetObfuscated(World:GetName(), ChunkX - 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ + 1, World:GetName()) and not IsObfuscated(World:GetName(), ChunkX, ChunkZ + 1) then
      World:RegenerateChunk(ChunkX, ChunkZ + 1)
      SetObfuscated(World:GetName(), ChunkX, ChunkZ + 1)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ - 1, World:GetName()) and not IsObfuscated(World:GetName(), ChunkX, ChunkZ - 1) then
      World:RegenerateChunk(ChunkX, ChunkZ - 1)
      SetObfuscated(World:GetName(), ChunkX, ChunkZ - 1)
    end

    return
  end
  
  LOG("[" .. PLUGIN:GetName() .. "] Obfuscating chunk X: " .. ChunkX .. "  Z: " .. ChunkZ)
  for RelY = 2, 253 do
    for RelX = 0, 15 do
      for RelZ = 0, 15 do
        if not HasAir(World, RelX, RelY, RelZ, ChunkX, ChunkZ) then
          ChunkDesc:SetBlockType(RelX, RelY, RelZ, g_Ores[math.random(1, g_NumOres)])
        end
      end
    end
  end
end



function SetObfuscated(WorldName, ChunkX, ChunkZ)
  cFile:Copy(GetSchematicFileName(WorldName, ChunkX, ChunkZ), SCHEMFOLDER .. "/" .. WorldName .. "/_OBCHNK#" .. ChunkX .. "#" .. ChunkZ)
  LOG("[" .. PLUGIN:GetName() .. "] Chunk is going to be obfuscated X: " .. ChunkX .. "  Z: " .. ChunkZ)
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
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ - 1, ChunkX, ChunkZ, WorldName)) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 1, RelZ - 1, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 1, RelZ - 1, ChunkX, ChunkZ, WorldName)) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 1, RelZ + 1, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 1, RelZ + 1, ChunkX, ChunkZ, WorldName)) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 1, RelY + 1, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 1, RelY - 1, RelZ, ChunkX, ChunkZ, WorldName)) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 1, RelY + 1, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 1, RelY - 1, RelZ, ChunkX, ChunkZ, WorldName)) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, WorldName)) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, WorldName))     
      ) then
      return true
  end
    return false
end