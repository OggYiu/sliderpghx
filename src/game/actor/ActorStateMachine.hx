package game.actor;

import firerice.core.Process;
import firerice.common.Helper;
import types.EActorState;
import game.actor.Player;
import game.actor.WalkState;

class ActorStateMachine extends Process {
	public var owner( default, null ) : Actor = null;
	public var curState( default, null ) : ActorState = null;

	public function new( p_owner : Actor ) {
		super( p_owner.id + "ActorStateMachine" );
		this.owner = p_owner;
	}

	function releaseCurState() : Void {
		if( this.curState != null ) {
			this.curState.endState();
			this.curState.dispose();
			this.curState = null;
		}
	}

	public function changeState( stateType : EActorState ) : Void {
		if( this.curState != null ) {
			releaseCurState();
		}

		if( Std.is( this.owner, Player ) ) {
			switch( stateType ) {
				case EActorState.idle: this.curState = new IdleState( this.owner );
				case EActorState.walk: this.curState = new WalkState( this.owner );
				case EActorState.run: this.curState = new RunState( this.owner );
				case EActorState.battle: this.curState = new BattleState( this.owner );
				default: Helper.assert( false, "unhandled type : " + stateType );
			}
		} else {
			switch( stateType ) {
				case EActorState.idle: this.curState = new IdleState( this.owner );
				// case EActorState.walk: Helper.assert( false, "monster dont know how to walk" );
				case EActorState.battle: this.curState = new BattleState( this.owner );
				default: Helper.assert( false, "unhandled type : " + stateType );
			}
		}

		if( this.curState != null ) {
			this.curState.beginState();
		}
	}

	override function dispose_() : Void {
		super.dispose_();
		releaseCurState();
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( this.curState != null ) {
			this.curState.update( dt );
		}
	}
}