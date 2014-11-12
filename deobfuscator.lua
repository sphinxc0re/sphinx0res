---------------------------------------
--------- Deobfuscator-----------------
---------------------------------------





function Deobfuscate(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
	local RelX = BlockX % 16
	local ChunkX = (BlockX - RelX) / 16
	local RelZ = BlockZ % 16
	local ChunkZ = (BlockZ - RelZ) / 16
	local RelY = BlockY

	local World = Player:GetWorld()
	local WorldName = World:GetName()
	local PlayerName = Player:GetName()


	local PlayerChunks = g_PlayerChunkCaches[PlayerName]
	PlayerChunks.MiddleChunk:SetRelBlockTypeMeta(RelX, RelY, RelZ, 0, 0)

	local DeobBlockArea = cBlockArea()
	DeobBlockArea:LoadFromSchematicFile(GetSchematicFileName(WorldName, ChunkX, ChunkZ))
	DeobBlockArea:SetRelBlockTypeMeta(RelX, RelY, RelZ, 0, 0)
	DeobBlockArea:SaveToSchematicFile(GetSchematicFileName(WorldName, ChunkX, ChunkZ))

	for i=1, g_NumRelativeOffset do
		World:SetBlock(BlockX + g_RelativeOffset[i][1], BlockY + g_RelativeOffset[i][2], BlockZ + g_RelativeOffset[i][3], GetDeopBlockType(RelX + g_RelativeOffset[i][1], RelY + g_RelativeOffset[i][2], RelZ + g_RelativeOffset[i][3], ChunkX, ChunkZ, WorldName, PlayerChunks), GetDeopBlockMeta(RelX + g_RelativeOffset[i][1], RelY + g_RelativeOffset[i][2], RelZ + g_RelativeOffset[i][3], ChunkX, ChunkZ, WorldName, PlayerChunks))
	end
end





function GetDeopBlockMeta(RelX, RelY, RelZ, ChunkX, ChunkZ, WorldName, SmallChunkCache)
	local BlockChunkX, BlockChunkZ = GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
	local RelChunkX = BlockChunkX - ChunkX
	local RelChunkZ = BlockChunkZ - ChunkZ
	local ChunkBlockArea = SmallChunkCache:GetRelToOrigin(RelChunkX, RelChunkZ)
	local RightRelX, RightRelZ = GetRelCoordsFromFalseRelCoords(RelX, RelZ)
	return ChunkBlockArea:GetRelBlockMeta(RightRelX, RelY, RightRelZ)
end





function GetDeopBlockType(RelX, RelY, RelZ, ChunkX, ChunkZ, WorldName, SmallChunkCache)
	local BlockChunkX, BlockChunkZ = GetChunkCoordsFromRelBlockCoords(RelX, RelZ, ChunkX, ChunkZ)
	local RelChunkX = BlockChunkX - ChunkX
	local RelChunkZ = BlockChunkZ - ChunkZ
	local ChunkBlockArea = SmallChunkCache:GetRelToOrigin(RelChunkX, RelChunkZ)
	local RightRelX, RightRelZ = GetRelCoordsFromFalseRelCoords(RelX, RelZ)
	return ChunkBlockArea:GetRelBlockType(RightRelX, RelY, RightRelZ)
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
