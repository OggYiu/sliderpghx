package game.battle;

import firerice.core.Process;
import game.entity.Actor;

class BattleTurn extends Process {
	public var attacker( default, null ) : Actor = null;
	public var defender( default, null ) : Actor = null;
	public var isEnded( default, null ) : Bool = false;

	public function new( p_attacker : Actor, p_defender : Actor, targetMove : Move ) {
		super( "battleTurn:" + p_attacker.id + ":" + p_defender.id );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
	}
}