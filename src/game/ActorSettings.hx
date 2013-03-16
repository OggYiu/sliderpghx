package game;

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

	public static function createActorState( p_owner : Actor ) : ActorState {
		var actorState : ActorState = new ActorState( p_owner );

		switch( p_owner.actorType ) {
			case EActor.jimmy: {
				actorState.hp = 10;
				actorState.damage = 2;
				actorState.defense = 2;
				actorState.exp = 0;
				actorState.redGem = 0;
				actorState.blueGem = 0;
				actorState.greenGem = 0;
			}
			case EActor.redSlime: {
				actorState.hp = 10;
				actorState.damage = 1;
				actorState.defense = 0;
				actorState.exp = 10;
				actorState.redGem = 0;
				actorState.blueGem = 0;
				actorState.greenGem = 0;
			}
			default: Helper.assert( false, "unhandled type : " + p_owner.actorType );
		}
		return actorState;
	}

	public static function getNextLevelExp( p_actor : Actor ) : Int {
		return p_actor.level * p_actor.level * 10;
		// switch( p_actor.actorType ) {
		// 	case EActor.jimmy: actor.
		// 	default: trace( "unhandled type: " + p_actor.actorType );
		// }
	}
}