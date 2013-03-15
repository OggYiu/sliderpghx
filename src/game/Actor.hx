package game;

import types.EActor;

class Actor extends GameEntity {
	public var actorType( default, null ) : EActor;
	public var curGrid( default, default ) : Grid = null;
	public var isInBattle( default, default ) : Bool = false;
	public var isDead( default, default ) : Bool = false;
	public var actorState( default, null ) : ActorState;
	
	public function new( p_id : String, p_parent : Dynamic, p_actorType : EActor ) {
		super( p_id, p_parent );

		this.actorType = p_actorType;
		this.actorState = ActorSettings.createActorState( this.actorType );
	}
}