package game;

import types.EActor;
import firerice.types.EOrientation;
import firerice.core.motionwelder.MReader;
import nme.geom.Point;

class Actor extends GameEntity {
	public var actorType( default, null ) : EActor;
	public var curGrid( default, default ) : Grid = null;
	public var isInBattle( default, default ) : Bool = false;
	public var isDead( getIsDead, null ) : Bool;
	public var level( getLevel, null ) : Int;
	public var exp( getExp, null ) : Int;
	public var damage( getDamage, null ) : Float;
	public var actorState( default, null ) : ActorState;
	
	public function new( p_id : String, p_parent : Dynamic, p_actorType : EActor ) {
		super( p_id, p_parent );

		this.actorType = p_actorType;
		this.actorState = ActorSettings.createActorState( this );
	}

	public function playAttackAnimation() : Void {
		this.animation.animator.play(	1,
										EOrientation.none,
										WrapMode.once,
										true );
	}

	public function playIdleAnimation() : Void {
		this.animation.animator.play(	0,
										EOrientation.none,
										WrapMode.loop,
										true );
		
	}

	public function playWalkAnimation() : Void {
	}

	public function playHurtAnimation() : Void {
		this.animation.animator.play(	2,
										EOrientation.none,
										WrapMode.loop,
										true );
	}

	public function heal( p_value : Float ) : Void {
		this.actorState.heal( p_value );
	}

	public function hurtOthers( p_victim : Actor, p_damage : Float ) : Void {
		p_victim.hurtByOthers( this, p_damage );

		if( p_victim.isDead ) {
			gainExp( p_victim.exp );
		}
	}

	public function hurtByOthers( p_attacker : Actor, p_damage : Float ) : Void {
		this.actorState.reduceHp( p_damage );

		var pos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		game.EffectManager.getInstance().showText( pos.x, pos.y, "-" + p_damage + "", 24 );
	}

	public function deadHandler() : Void {
		this.destoryed = true;
	}

	public function levelUpHandler() : Void {
		var pos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		game.EffectManager.getInstance().showText( pos.x, pos.y, "level up", 24, 0x00FF00 );
	}

	function getIsDead() : Bool {
		return this.actorState.isDead;
	}

	function gainExp( p_value : Int ) : Void {
		this.actorState.gainExp( p_value );

		var pos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		game.EffectManager.getInstance().showText( pos.x, pos.y, "+" + p_value, 24, 0x00FF00 );
	}

	function getLevel() : Int {
		return this.actorState.level;
	}

	function getExp() : Int {
		return this.actorState.exp;
	}

	function getDamage() : Float {
		return this.actorState.damage;
	}
}