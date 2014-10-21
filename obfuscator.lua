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
  if #WorldFolderContents < 5 then
    return
  end
  
  if not ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ, World:GetName()) then
    if ChunkHasAllDirectNeigborsGenerated(ChunkX + 1, ChunkZ, World:GetName()) then
      World:RegenerateChunk(ChunkX + 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX - 1, ChunkZ, World:GetName()) then
      World:RegenerateChunk(ChunkX - 1, ChunkZ)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ + 1, World:GetName()) then
      World:RegenerateChunk(ChunkX, ChunkZ + 1)
    end
    
    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ - 1, World:GetName()) then
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