-- Implementation of the cSmallChunkCache class





cSmallChunkCache = {}





function cSmallChunkCache:new(a_Obj)
	local a_Obj = a_Obj or {}
	setmetatable(a_Obj, cSmallChunkCache)
	self.__index = self

	-- Initialize the object members:
	a_Obj.MiddleChunk = cBlockArea()
	a_Obj.NorthChunk = cBlockArea()
	a_Obj.EastChunk = cBlockArea()
	a_Obj.SouthChunk = cBlockArea()
	a_Obj.WestChunk = cBlockArea()
	a_Obj.NorthEastChunk = cBlockArea()
	a_Obj.SouthEastChunk = cBlockArea()
	a_Obj.SouthWestChunk = cBlockArea()
	a_Obj.NorthWestChunk = cBlockArea()
	a_Obj.OriginX = 0
	a_Obj.OriginZ = 0

	return a_Obj
end





function cSmallChunkCache.NewFromChunkPos(a_world, a_chunkX, a_chunkZ)
	local a_Obj = cSmallChunkCache:new()
	local WorldName = a_world:GetName()
	a_Obj.OriginX = a_chunkX
	a_Obj.OriginZ = a_chunkZ
	a_Obj.MiddleChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX, a_chunkZ))

	a_Obj.SouthChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX, a_chunkZ + 1))
	a_Obj.NorthChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX, a_chunkZ - 1))
	a_Obj.EastChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX + 1, a_chunkZ))
	a_Obj.WestChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX - 1, a_chunkZ))

	a_Obj.NorthEastChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX + 1, a_chunkZ - 1))
	a_Obj.SouthEastChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX + 1, a_chunkZ + 1))
	a_Obj.NorthWestChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX - 1, a_chunkZ - 1))
	a_Obj.SouthWestChunk:LoadFromSchematicFile(GetSchematicFileName(WorldName, a_chunkX - 1, a_chunkZ + 1))

	return a_Obj
end





function cSmallChunkCache:GetRelToOrigin(a_RelX, a_RelZ)
	if a_RelX == 0 and a_RelZ == 0 then
		return self.MiddleChunk
	elseif a_RelX == 1 then
		if a_RelZ == 0 then
			return self.EastChunk
		elseif a_RelZ == 1 then
			return self.SouthEastChunk
		else -- -1
			return self.NorthEastChunk
		end
	elseif a_RelX == 0 then
		if a_RelZ == 1 then
			return self.SouthChunk
		else -- -1
			return self.NorthChunk
		end
	else
		if a_RelZ == 0 then
			return self.WestChunk
		elseif a_RelZ == 1 then
			return self.SouthWestChunk
		else
			return self.NorthWestChunk
		end
	end
end
