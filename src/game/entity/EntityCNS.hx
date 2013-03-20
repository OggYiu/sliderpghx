package game.entity;

import types.EGameEntity;

class EntityCNS {
	public var entityType( default, default ) : EGameEntity;

	public function new() {
		this.entityType = EGameEntity.unknown;
	}
}