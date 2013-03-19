package game;

import types.EItem;

class ItemSettings {
	public function new() {
	}

	// public var hp( default, default ) : Float = 0;
	// public var damage( default, default ) : Float = 0;
	// public var defense( default, default ) : Float = 0;
	// public var redGem( default, default ) : Int = 0;
	// public var blueGem( default, default ) : Int = 0;
	// public var greenGem( default, default ) : Int = 0;

	public static function createItemCNS( p_itemType : EItem, p_level : Int ) : ItemCNS {
		var itemCNS : ItemCNS = new ItemCNS();
		itemCNS.type = p_itemType;
		itemCNS.level = p_level;
		itemCNS.value = 10;

		// switch( p_itemType ) {
		// 	case EItem.potion:
		// 	default: Helper.assert( false, "unhandled type : " + p_owner.actorType );
		// }

		return itemCNS;
	}
}