package game.battle.moves;

import firerice.core.Process;
import game.battle.BattleActor;

class MoveBase extends Process {
	public var battleActor( default, null ) : BattleActor;
	public var isEnded( default, null ) : Bool = false;

	public function new( p_id : String, p_battleActor : BattleActor ) {
		super( p_id );

		this.battleActor = p_battleActor;
	}

	public function beginMove() : Void {
		this.isEnded = false;
	}

	public function endMove() : Void {
		this.isEnded = true;
		this.battleActor.owner.playIdleAnimation();
	}
}