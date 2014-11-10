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
    end

    if ChunkHasAllDirectNeigborsGenerated(ChunkX - 1, ChunkZ, WorldName) and not IsObfuscated(WorldName, ChunkX - 1, ChunkZ) then
      World:RegenerateChunk(ChunkX - 1, ChunkZ)
    end

    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ + 1, WorldName) and not IsObfuscated(WorldName, ChunkX, ChunkZ + 1) then
      World:RegenerateChunk(ChunkX, ChunkZ + 1)
    end

    if ChunkHasAllDirectNeigborsGenerated(ChunkX, ChunkZ - 1, WorldName) and not IsObfuscated(WorldName, ChunkX, ChunkZ - 1) then
      World:RegenerateChunk(ChunkX, ChunkZ - 1)
    end


    if ChunkHasAllDirectNeigborsGenerated(ChunkX + 1, ChunkZ + 1, WorldName) and not IsObfuscated(WorldName, ChunkX + 1, ChunkZ + 1) then
      World:RegenerateChunk(ChunkX + 1, ChunkZ + 1)
    end

    if ChunkHasAllDirectNeigborsGenerated(ChunkX + 1, ChunkZ - 1, WorldName) and not IsObfuscated(WorldName, ChunkX + 1, ChunkZ - 1) then
      World:RegenerateChunk(ChunkX + 1, ChunkZ - 1)
    end

    if ChunkHasAllDirectNeigborsGenerated(ChunkX - 1, ChunkZ - 1, WorldName) and not IsObfuscated(WorldName, ChunkX - 1, ChunkZ - 1) then
      World:RegenerateChunk(ChunkX - 1, ChunkZ - 1)
    end

    if ChunkHasAllDirectNeigborsGenerated(ChunkX - 1, ChunkZ + 1, WorldName) and not IsObfuscated(WorldName, ChunkX - 1, ChunkZ + 1) then
      World:RegenerateChunk(ChunkX - 1, ChunkZ + 1)
    end

    return
  end

  local SmallChunkCache = cSmallChunkCache:NewFromChunkPos(World, ChunkX, ChunkZ)
c
  -- LOG("[" .. PLUGIN:GetName() .. "] Obfuscating chunk X: " .. ChunkX .. "  Z: " .. ChunkZ)
  for RelY = 2, (ChunkDesc:GetMaxHeight() - 2) do
    for RelX = 0, 15 do
      for RelZ = 0, 15 do
        if not HasAir(World, RelX, RelY, RelZ, ChunkX, ChunkZ, SmallChunkCache) then
          ChunkDesc:SetBlockType(RelX, RelY, RelZ, g_Ores[math.random(1, g_NumOres)])
        end
      end
    end
  end
  SetObfuscated(WorldName, ChunkX, ChunkZ)
  -- LOG("[" .. PLUGIN:GetName() .. "] Obfuscated chunk X: " .. ChunkX .. "  Z: " .. ChunkZ)
end





function SetObfuscated(WorldName, ChunkX, ChunkZ)
  cFile:Copy(GetSchematicFileName(WorldName, ChunkX, ChunkZ), SCHEMFOLDER .. "/" .. WorldName .. "/_OBCHNK#" .. ChunkX .. "#" .. ChunkZ)
  -- LOG("[" .. PLUGIN:GetName() .. "] Chunk is going to be obfuscated X: " .. ChunkX .. "  Z: " .. ChunkZ)
end





function IsObfuscated(WorldName, ChunkX, ChunkZ)
  return cFile:Exists(SCHEMFOLDER .. "/" .. WorldName .. "/_OBCHNK#" .. ChunkX .. "#" .. ChunkZ)
end





function HasAir(World, RelX, RelY, RelZ, ChunkX, ChunkZ, SmallChunkCache)
  local WorldName = World:GetName()

  for i=1, g_NumRelativeOffset do
    if cBlockInfo:IsTransparent(GetDeopBlockType(RelX + g_RelativeOffset[i][1], RelY + g_RelativeOffset[i][2], RelZ + g_RelativeOffset[i][3], ChunkX, ChunkZ, WorldName, SmallChunkCache)) then
      return true
    end
  end
  return false
end
