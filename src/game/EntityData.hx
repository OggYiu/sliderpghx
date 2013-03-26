package game;

import types.EGameEntity;

class EntityData {
	public var entityType( default, default ) : EGameEntity;
	
	
	public function new() {
		this.entityType = EGameEntity.unknown;
	}
}