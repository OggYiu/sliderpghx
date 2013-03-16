package game.actor;

import firerice.core.Process;
import types.EActorState;

class ActorStateMachine extends Process {
	public var owner( default, null ) : Actor;
	// public var curState( default, null ) : ActorState;

	public function new( p_owner : Actor ) {
		super( p_owner.id + "ActorStateMachine" );
	}

	public function changeState( stateType : EActorState ) : Void {
	}
}