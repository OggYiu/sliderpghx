package game.battle.moves.attack;

import types.EMoveAttack;
import game.battle.BattleActor;

class NormalAttack extends AttackBase {
	public function new( p_battleActor : BattleActor ) {
		super( EMoveAttack.normalAttack, p_battleActor );
	}

	override function beginMove() : Void {
		super.beginMove();

		this.battleActor.owner.animation.target = this;
		this.battleActor.owner.animation.completeHandler = animCompleteHandler;
		this.battleActor.owner.playAttackAnimation();
	}

	function animCompleteHandler() : Void {
		endMove();

		this.battleActor.owner.hurtOthers( this.battleActor.enemy.owner, this.battleActor.owner.damage );
	}
}