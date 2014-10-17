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
        if not HasAir(ChunkBlockArea, RelX, RelY, RelZ) then
          ChunkBlockArea:SetRelBlockType(RelX, RelY, RelZ, g_Ores[math.random(1, g_NumOres)])
        end
      end
    end
  end
  cFile:CreateFolder("SporeSchema")
  ChunkBlockArea:SaveToSchematicFile("SporeSchema/CHUNK#" .. ChunkX .. "#" .. ChunkZ .. ".schematic")
  LOG("Saved obfuscated chunk ".. ChunkX .. "#" .. ChunkZ .." to drive!")
end