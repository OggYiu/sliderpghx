package game.battle;

import firerice.core.Process;
import game.actor.Actor;
import game.actor.Player;
import game.battle.moves.attack.AttackBase;
import game.battle.moves.attack.NormalAttack;
import game.battle.moves.attack.MultipleAttack;

class BattleActor extends Process {
	public var owner( default, null ) : Actor = null;
	public var enemy( default, null ) : BattleActor = null;
	public var isMyTurn( default, default ) : Bool = false;
	public var isTurnEnded( default, default ) : Bool = true;
	var battle( default, null ) : Battle = null;
	var curMove( default, null ) : AttackBase = null;

	public function new( p_actor : Actor, p_battle : Battle ) {
		super( "battleActor:" + p_actor.id );

		this.owner = p_actor;
		this.battle = p_battle;
	}

	public function initBattleActor( p_enemy : BattleActor ) : Void {
		this.enemy = p_enemy;
		this.owner.playIdleAnimation();
	}

	public function beginTurn() : Void {
		this.enemy.isTurnEnded = false;
		this.enemy.isMyTurn = true;

		this.curMove = new NormalAttack( this );
		// this.curMove = new MultipleAttack( this );
		this.curMove.beginMove();
	}

	public function endTurn() : Void {
		this.isTurnEnded = true;
		this.isMyTurn = false;

		if( this.curMove != null ) {
			this.curMove.dispose();
			this.curMove = null;
		}

		if( !this.enemy.owner.isDead ) {
			this.enemy.beginTurn();
		}
	}

	override function dispose_() : Void {
		super.dispose_();

		if( this.curMove != null ) {
			this.curMove.dispose();
			this.curMove = null;
		}

		this.owner.animation.resetHandler();

		if( Std.is( this.owner, Player ) ) {
			this.owner.playWalkAnimation();
		} else {
			this.owner.playIdleAnimation();
		}
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( this.curMove != null ) {
			this.curMove.update( dt );
			if( this.curMove.isEnded ) {
				endTurn();
			}
		}
	}
}