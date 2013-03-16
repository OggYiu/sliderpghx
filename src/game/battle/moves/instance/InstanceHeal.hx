package game.battle.moves.instance;

import types.EMoveAttack;
import game.battle.BattleActor;

class InstanceHeal extends InstanceBase {
	public function new( p_battleActor : BattleActor ) {
		super( types.EMoveInstance.heal, p_battleActor );
	}

	override function beginMove() : Void {
		super.beginMove();
	}

	function animCompleteHandler() : Void {
		endMove();
	}
}