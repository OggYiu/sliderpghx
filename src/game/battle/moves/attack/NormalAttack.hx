package game.battle.moves.attack;

import types.EMoveAttack;
import game.battle.BattleActor;
import nme.Assets;
import nme.media.Sound;
import nme.media.SoundChannel;

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
		var sound : Sound = Assets.getSound ("assets/audio/sound/swordSlash.mp3");
		sound.play( 0, 1 );

		this.battleActor.owner.hurtOthers( this.battleActor.enemy.owner, this.battleActor.owner.attack );
	}
}