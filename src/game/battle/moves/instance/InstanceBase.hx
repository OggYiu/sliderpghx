package game.battle.moves.attack;

import types.EMoveInstance;
import game.battle.BattleActor;

class InstanceBase extends MoveBase {
	public function new( p_moveType : EMoveInstance, p_battleActor : BattleActor ) {
		super( p_moveType + "", p_battleActor );
	}

	override public function beginMove() : Void {
		super.beginMove();
	}

	override public function endMove() : Void {
		super.endMove();
	}
}