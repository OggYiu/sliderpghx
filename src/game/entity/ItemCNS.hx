package game.entity;

import types.EItem;
import game.entity.EntityCNS;

class ItemCNS extends EntityCNS {
	public var itemType( default, default ) : EItem;
	public var level( default, default ) : Int = 0;
	public var value( default, default ) : Float = 0;

	public function new() {
		super();
	}
}