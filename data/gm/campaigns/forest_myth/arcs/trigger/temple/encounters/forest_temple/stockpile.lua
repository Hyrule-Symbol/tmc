local Point2 = _radiant.csg.Point2
local Point3 = _radiant.csg.Point3
local Stockpile = class()

function Stockpile:initialize(piece)
	self._sv.piece = piece
	self.__saved_variables:mark_changed()
end

function Stockpile:start(ctx, info)
	self._ctx  = ctx
	self._info = info
	assert(ctx.npc_player_id)
	local size = self._sv.piece.info.script_info.stockpile_size
	local stockpile_location = ctx.enemy_location + Point3(self._sv.piece.position.x-(size.w/2), 1, self._sv.piece.position.y-(size.h/2))
	self:_create_stockpile(stockpile_location, size.w, size.h)
end

function Stockpile:_create_stockpile(location, w, h)
	stonehearth.inventory:get_inventory(self._ctx.npc_player_id):create_stockpile(location, Point2(w,h))
	local contents = self._sv.piece.info.script_info.stockpile_contents
	if contents then
		radiant.terrain.place_entity_cluster(contents, location, (w>=2 and 2) or w, (h>=2 and 2) or h)
	end
end

return Stockpile