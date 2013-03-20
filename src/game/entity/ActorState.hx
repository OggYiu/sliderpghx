package game.entity;

import firerice.core.Process;
import types.EActorState;

class ActorState extends Process {
	public var owner( default, null ) : Actor;
	public var stateType( default, null ) : EActorState;

	public function new( p_owner : Actor, p_stateType : EActorState ) {
		super( p_owner.id + "ActorState" );
		this.stateType = p_stateType;
		this.owner = p_owner;
	}

	public function beginState() : Void {
	}

	public function endState() : Void {
	}
}