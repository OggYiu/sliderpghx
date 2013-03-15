package game;

import firerice.common.Helper;
import types.EActor;

class ActorSettings {
	public function new() {
	}

	public static function createActorState( p_actorType : EActor ) : ActorState {
		var actorState : ActorState = new ActorState();

		switch( p_actorType ) {
			case EActor.jimmy:
			case EActor.redSlime:
			default: Helper.assert( false, "unhandled type : " + p_actorType );
		}
		return actorState;
	}
}