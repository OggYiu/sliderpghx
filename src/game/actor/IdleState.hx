package game.actor;

import firerice.core.Process;
import types.EActorState;

class IdleState extends ActorState {
	public function new( p_owner : Actor ) {
		super( p_owner, EActorState.idle );
	}

	override public function beginState() : Void {
		super.beginState();
	}

	override public function endState() : Void {
		super.endState();
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
	}
}