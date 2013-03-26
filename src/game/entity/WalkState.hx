package game.entity;

import firerice.core.Process;
import types.EActorState;
import game.Settings;

class WalkState extends ActorState {
	public function new( p_owner : Actor ) {
		super( p_owner, EActorState.walk );
	}

	override public function beginState() : Void {
		super.beginState();

		this.owner.playWalkAnimation();
	}

	override public function endState() : Void {
		super.endState();
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		this.owner.transform.x += dt * Settings.PLAYER_WALK_SPEED;
	}
}