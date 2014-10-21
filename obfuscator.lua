-----------------------------------
----- OBFUSCATOR ------------------
-----------------------------------

function ObfuscateChunk(World, ChunkX, ChunkZ, ChunkDesc)
  cFile:CreateFolder(SCHEMFOLDER .. "/" .. World:GetName())
  ChunkBlockArea = cBlockArea()
  ChunkDesc:ReadBlockArea(ChunkBlockArea, 0, 15, 0, (ChunkDesc:GetMaxHeight()), 0, 15)
  ChunkBlockArea:SaveToSchematicFile(GetSchematicFileName(World:GetName(), ChunkX, ChunkZ))
  LOG("[" .. PLUGIN:GetName() .. "] Saved chunk ".. ChunkX .. "#" .. ChunkZ .." to drive!")
  WorldFolderContents = cFile:GetFolderContents(SCHEMFOLDER .. "/" .. World:GetName())
  if #WorldFolderContents < 6 then
    return
  end
  
  if not ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ, World:GetName()) then
    LOG("[" .. PLUGIN:GetName() .. "] Executing flower alogrithm!")
    if ChunkHasAllDirectNeigborsGenerated(ChunkX + 1, ChunkZ, World:GetName()) and not IsObfuscated(ChunkX + 1, ChunkZ) then
      World:RegenerateChunk(ChunkX + 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX - 1, ChunkZ, World:GetName()) and not IsObfuscated(ChunkX - 1, ChunkZ) then
      World:RegenerateChunk(ChunkX - 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ + 1, World:GetName()) and not IsObfuscated(ChunkX, ChunkZ + 1) then
      World:RegenerateChunk(ChunkX, ChunkZ + 1)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ - 1, World:GetName()) and not IsObfuscated(ChunkX, ChunkZ - 1) then
      World:RegenerateChunk(ChunkX, ChunkZ - 1)
    end
    return
  end
  
  for RelY = 0, ChunkDesc:GetMaxHeight() do
    for RelX = 0, 15 do
      for RelZ = 0, 15 do
        if not HasAir(World, RelX, RelY, RelZ, ChunkX, ChunkZ) then
          ChunkDesc:SetBlockType(RelX, RelY, RelZ, g_Ores[math.random(1, g_NumOres)])
        end
      end
    end
  end
  SetObfuscated(World:GetName(), ChunkX, ChunkZ)
end



function SetObfuscated(WorldName, ChunkX, ChunkZ)
  cFile:Copy(GetSchematicFileName(WorldName, ChunkX, ChunkZ), SCHEMFOLDER .. "/OBCHNK#" .. ChunkX .. "#" .. ChunkZ)
end


function IsObfuscated(ChunkX, ChunkZ)
  return cFile.Exists(SCHEMFOLDER .. "/OBCHNK#" .. ChunkX .. "#" .. ChunkZ)
end



-- Thanks to STR_Warrior for this function
function HasAir(World, RelX, RelY, RelZ, ChunkX, ChunkZ)
  if (
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 1, RelY, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 1, RelY, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 1, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 1, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ + 1, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ - 1, ChunkX, ChunkZ, World:GetName())) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 1, RelZ - 1, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 1, RelZ - 1, ChunkX, ChunkZ, World:GetName())) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 1, RelZ + 1, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 1, RelZ + 1, ChunkX, ChunkZ, World:GetName())) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 1, RelY + 1, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 1, RelY - 1, RelZ, ChunkX, ChunkZ, World:GetName())) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 1, RelY + 1, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 1, RelY - 1, RelZ, ChunkX, ChunkZ, World:GetName())) or
      
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX + 2, RelY, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX - 2, RelY, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY + 2, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY - 2, RelZ, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ + 2, ChunkX, ChunkZ, World:GetName())) or
      cBlockInfo:IsTransparent(GetDeopBlockType(RelX, RelY, RelZ - 2, ChunkX, ChunkZ, World:GetName()))     
      ) then
      return true
  end
    return false
end