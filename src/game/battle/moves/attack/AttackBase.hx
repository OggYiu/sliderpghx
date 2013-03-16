package game.battle.moves.attack;

import types.EMoveAttack;
import game.battle.BattleActor;

class AttackBase extends MoveBase {
	public function new( p_moveType : EMoveAttack, p_battleActor : BattleActor ) {
		super( p_moveType + "", p_battleActor );
	}

	override public function beginMove() : Void {
		super.beginMove();
	}

	override public function endMove() : Void {
		super.endMove();
	}
}