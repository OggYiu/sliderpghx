package game.entity;

import firerice.core.Process;
import types.EActorState;

class BattleState extends ActorState {
	public function new( p_owner : Actor ) {
		super( p_owner, EActorState.battle );
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