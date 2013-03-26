package game.entity;

import types.EActor;
import types.EActorState;
import types.EGemType;
import types.ESkill;
import types.EGameEntity;
import types.EMoveType;
import firerice.types.EOrientation;
import firerice.core.motionwelder.MReader;
import firerice.components.AnimationComponent;
import firerice.common.Helper;
import nme.geom.Point;
import game.entity.ActorStateMachine;
import game.entity.SkillInfo;
import game.entity.ActorCNS;
import game.entity.ActorSettings;

class Actor extends GameEntity {
	public var actorType( getActorType, null ) : EActor;
	public var curGrid( default, default ) : Grid = null;
	// public var isInBattle( default, default ) : Bool = false;
	public var level( getLevel, null ) : Int;
	public var exp( getExp, null ) : Int;
	public var attack( getAttack, null ) : Float;
	public var curState( getCurState, null ) : EActorState;
	public var actorCNS( default, null ) : ActorCNS;
	public var actorStateMachine( default, null ) : ActorStateMachine = null;
	// public var isDead( getIsDead, setIsDead ) : Bool = false;
	public var isDead( default, null ) : Bool = false;
	
	public function new( p_id : String, p_parent : Dynamic, p_gameEntityType : EGameEntity, p_actorCNS : ActorCNS ) {
		super( p_id, p_parent, p_gameEntityType );

		// trace( animPath );
		this.actorCNS = p_actorCNS;
		var animPath : String = Settings.MOTIONWELDER_PATH + this.actorCNS.name;
        this.addComponent( new AnimationComponent( this, animPath ) );
        
		this.actorStateMachine = new ActorStateMachine( this );
		// this.actorType = p_actorType;
		// this.actorCNS = ActorSettings.createActorCNS( this );
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

	public function hurtOthers( p_victim : Actor, p_damage : Float ) : Void {
		p_victim.hurtByOthers( this, p_damage );

		if( p_victim.isDead ) {
			gainExp( p_victim.exp );
		}
	}

	public function reduceHp( p_value : Float ) : Void {
		if( this.isDead ) {
			return ;
		}

		this.actorCNS.hp -= p_value;
		if( this.actorCNS.hp <= 0 ) {
			this.actorCNS.hp = 0;
			this.isDead = true;

			this.deadHandler();
		}
	}

	public function hurtByOthers( p_attacker : Actor, p_damage : Float ) : Void {
		this.reduceHp( p_damage );

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

	function getLevel() : Int {
		return this.actorCNS.level;
	}

	function getExp() : Int {
		return this.actorCNS.exp;
	}

	function getAttack() : Float {
		return this.actorCNS.attack;
	}

	public function addSkill( p_skillInfo : SkillInfo ) : Void {
		this.actorCNS.addSkill( p_skillInfo );
		// Helper.assert( !this.skills.exists( p_skillInfo.skillType + "" ), "skill " + p_skillInfo.skillType + " already existed" );
		// for( skill in this.skills ) {
		// 	if( skill.gemBind == p_skillInfo.gemBind ) {
		// 		Helper.assert( false, "gemBind : " + skill.gemBind + " already existed" );
		// 		break;
		// 	}
		// }
		// this.skills.set( p_skillInfo.skillType + "", p_skillInfo );
	}

	public function gainExp( p_value : Int ) : Void {
		var expValue : Int = p_value;
		this.actorCNS.exp += expValue;
		// if( 
		var nextLevelExp : Int = game.entity.ActorSettings.getNextLevelExp( this.actorCNS );

		var pos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		game.EffectManager.getInstance().showText( pos.x, pos.y, "+" + p_value, 24, 0x00FF00 );
	}

	public function gainLeve() : Void {
	}

	public function heal( p_value : Float ) : Void {
		this.actorCNS.hp += p_value;
		if( this.actorCNS.hp > this.actorCNS.maxHp ) {
			this.actorCNS.hp = this.actorCNS.maxHp;
		}

		var pos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		game.EffectManager.getInstance().showText( pos.x, pos.y, p_value + "", 24, 0x00FF00 );
	}

	public function getSkill( p_gemType : EGemType ) : SkillInfo {
		return this.actorCNS.getSkill( p_gemType );
		// var skillInfo : SkillInfo = null;

		// for( skill in this.skills ) {
		// 	if( skill.gemBind == p_gemType ) {
		// 		skillInfo = skill;
		// 		break;
		// 	}
		// }
		// return skillInfo;
	}

	function getActorType() : EActor {
		return this.actorCNS.actorType;
	}

	// function getActorType() : EActor {
	// 	return this.actorCNS.
	// }
}