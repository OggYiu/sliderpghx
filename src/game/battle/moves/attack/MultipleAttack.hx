package game.battle.moves.attack;

import types.EMoveAttack;
import game.battle.BattleActor;

class MultipleAttack extends AttackBase {
	public var attackCount( default, null ) : Int = 2;
	public function new( p_battleActor : BattleActor ) {
		super( EMoveAttack.multiAttack, p_battleActor );
	}

	override function beginMove() : Void {
		super.beginMove();

		this.battleActor.owner.animation.target = this;
		this.battleActor.owner.animation.completeHandler = animCompleteHandler;
		this.battleActor.owner.playAttackAnimation();
	}

	function animCompleteHandler() : Void {
		--attackCount;

			this.battleActor.owner.hurtOthers( this.battleActor.enemy.owner, this.battleActor.owner.damage );

		if( attackCount > 0 ) {
			beginMove();
		} else {
			endMove();
		}
	}
}