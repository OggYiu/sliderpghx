package game.actor;

import firerice.common.Helper;
import types.EActor;

class ActorSettings {
	public function new() {
	}

	// public var hp( default, default ) : Float = 0;
	// public var damage( default, default ) : Float = 0;
	// public var defense( default, default ) : Float = 0;
	// public var redGem( default, default ) : Int = 0;
	// public var blueGem( default, default ) : Int = 0;
	// public var greenGem( default, default ) : Int = 0;

	public static function createActorCNS( p_owner : Actor ) : ActorCNS {
		var actorCNS : ActorCNS = new ActorCNS( p_owner );

		switch( p_owner.actorType ) {
			case EActor.jimmy: {
				actorCNS.init(	10,	// hp
								2,	// damage
								2,	// defense
								0,	// exp
								0,	// red gem
								0,	// blueGem
								0	// greenGem
								);
			}
			case EActor.redSlime: {
				actorCNS.init(	10,	// hp
								1,	// damage
								2,	// defense
								10,	// exp
								0,	// red gem
								0,	// blueGem
								0	// greenGem
								);
			}
			default: Helper.assert( false, "unhandled type : " + p_owner.actorType );
		}
		
		return actorCNS;
	}

	public static function getNextLevelExp( p_actor : Actor ) : Int {
		return p_actor.level * p_actor.level * 10;
		// switch( p_actor.actorType ) {
		// 	case EActor.jimmy: actor.
		// 	default: trace( "unhandled type: " + p_actor.actorType );
		// }
	}
}