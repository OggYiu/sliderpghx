package game.actor;

import types.EActor;
import types.EActorState;
import types.EGemType;
import types.ESkill;
import types.EMoveType;
import firerice.types.EOrientation;
import firerice.core.motionwelder.MReader;
import firerice.common.Helper;
import nme.geom.Point;
import game.actor.ActorStateMachine;
import game.actor.SkillInfo;

class Actor extends GameEntity {
	public var actorType( default, null ) : EActor;
	public var curGrid( default, default ) : Grid = null;
	// public var isInBattle( default, default ) : Bool = false;
	public var isDead( getIsDead, null ) : Bool;
	public var level( getLevel, null ) : Int;
	public var exp( getExp, null ) : Int;
	public var damage( getDamage, null ) : Float;
	public var curState( getCurState, null ) : EActorState;
	public var actorCNS( default, null ) : ActorCNS;
	public var actorStateMachine( default, null ) : ActorStateMachine = null;
	
	public function new( p_id : String, p_parent : Dynamic, p_actorType : EActor ) {
		super( p_id, p_parent );

		this.actorStateMachine = new ActorStateMachine( this );

		this.actorType = p_actorType;
		this.actorCNS = ActorSettings.createActorCNS( this );
	}

	public function useSkill( p_gemType : EGemType ) : Void {
		var skillInfo : SkillInfo = this.actorCNS.getSkill( p_gemType );
		// trace( "useSkill : " + skillType );

		if( skillInfo != null && skillInfo.skillType != ESkill.unknown ) {
			var moveType : EMoveType = SkillInfo.getMoveType( skillInfo.skillType );
			if( moveType == EMoveType.instance ) {
				switch( skillInfo.skillType ) {
					case ESkill.heal: heal( skillInfo.hpMod );
					default: Helper.assert( false, "unhandled type : " + skillInfo.skillType );
				}
			}
		}
	}

	public function changeState( stateType : EActorState ) : Void {
		this.actorStateMachine.changeState( stateType );
	}

	function getCurState() : EActorState {
		return this.actorStateMachine.curState.stateType;
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		this.actorStateMachine.update( dt );
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
		this.actorCNS.heal( p_value );

		var pos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		game.EffectManager.getInstance().showText( pos.x, pos.y, p_value + "", 24, 0x00FF00 );
	}

	public function hurtOthers( p_victim : Actor, p_damage : Float ) : Void {
		p_victim.hurtByOthers( this, p_damage );

		if( p_victim.isDead ) {
			gainExp( p_victim.exp );
		}
	}

	public function hurtByOthers( p_attacker : Actor, p_damage : Float ) : Void {
		this.actorCNS.reduceHp( p_damage );

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
		return this.actorCNS.isDead;
	}

	function gainExp( p_value : Int ) : Void {
		this.actorCNS.gainExp( p_value );

		var pos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		game.EffectManager.getInstance().showText( pos.x, pos.y, "+" + p_value, 24, 0x00FF00 );
	}

	function getLevel() : Int {
		return this.actorCNS.level;
	}

	function getExp() : Int {
		return this.actorCNS.exp;
	}

	function getDamage() : Float {
		return this.actorCNS.damage;
	}
}