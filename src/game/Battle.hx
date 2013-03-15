package game;

import firerice.core.Process;
import firerice.common.Helper;
import game.Actor;

class Battle extends Process {
	public var actor1( default, null ) : Actor = null;
	public var actor2( default, null ) : Actor = null;
	public var curTurn( default, null ) : BattleTurn = null;
	public var isEnded( default, null ) : Bool = false;

	public function new( p_id : String, p_actor1 : Actor, p_actor2 : Actor ) {
		super( p_id );
		Helper.assert( !p_actor1.isInBattle && !p_actor2.isInBattle, "actor is already in battle" );
		this.actor1 = p_actor1;
		this.actor2 = p_actor2;

		this.actor1.isInBattle = this.actor2.isInBattle = true;
		trace( "battle begin: " + this.id );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( this.isEnded ) {
			return;
		}

		if( this.actor1.isDead || this.actor2.isDead ) {
			endBattle();
		} else if( !this.actor1.isInBattle || !this.actor2.isInBattle ) {
			endBattle();
		}
	}

	function endBattle() {
		trace( "battle end: " + this.id );
		this.actor1.isInBattle = this.actor2.isInBattle = false;
		this.isEnded = true;
	}
}