package game.entity;

import firerice.core.Process;
import types.EActorState;

class RunState extends ActorState {
	public function new( p_owner : Actor ) {
		super( p_owner, EActorState.run );
	}

	override public function beginState() : Void {
		super.beginState();

		this.owner.playRunAnimation();
	}

	override public function endState() : Void {
		super.endState();
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		this.owner.transform.x += dt * Settings.PLAYER_WALK_SPEED * 3;
	}
}