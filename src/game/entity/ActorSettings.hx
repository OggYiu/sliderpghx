package game.entity;

import firerice.common.Helper;
import types.EActor;
import types.EGemType;
import types.ESkill;
import types.EGameEntity;
import game.entity.SkillInfo;
import game.entity.ActorCNS;

class ActorSettingInfo extends ActorCNS {
	public var expIncreaseRate( default, default ) : Float = 0;
	public var hpIncreaseRate( default, default ) : Float = 0;
	public var attackIncreaseRate( default, default ) : Float = 0;
	public var defenseIncreaseRate( default, default ) : Float = 0;
	public var criticalIncreaseRate( default, default ) : Float = 0;
	public var parryIncreaseRate( default, default ) : Float = 0;					
}

class ActorSettings {
	var actorInfos : Hash<ActorSettingInfo> = null;

	public function new() {
		this.actorInfos = new Hash<ActorSettingInfo>();
	}

	public function read( p_path : String ) : Void {
		{
			var actorCNSInfo : ActorSettingInfo;

			{
				actorCNSInfo = new ActorSettingInfo();
				actorCNSInfo.name = "jimmy";
				actorCNSInfo.level = 1;
				actorCNSInfo.exp = 15;
				actorCNSInfo.maxHp = actorCNSInfo.hp = 50;
				actorCNSInfo.attack = 6;
				actorCNSInfo.defense = 4;
				actorCNSInfo.critical = 0.1;
				actorCNSInfo.parry = 0.05;
				actorCNSInfo.redGem = 1;
				actorCNSInfo.greenGem = 0;
				actorCNSInfo.blueGem = 0;
				actorCNSInfo.expIncreaseRate = 1.5;
				actorCNSInfo.hpIncreaseRate = 1.5;
				actorCNSInfo.attackIncreaseRate = 1.4;
				actorCNSInfo.defenseIncreaseRate = 1.4;
				actorCNSInfo.criticalIncreaseRate = 1.15;
				actorCNSInfo.parryIncreaseRate = 1.0;

				var skillInfo : SkillInfo = new SkillInfo();
				skillInfo.gemBind = EGemType.green;
				skillInfo.skillType = ESkill.heal;
				skillInfo.hpMod = 10;
				actorCNSInfo.addSkill( skillInfo );
				actorInfos.set( EActor.jimmy + "", actorCNSInfo );
			}

			{
				actorCNSInfo = new ActorSettingInfo();
				actorCNSInfo.name = "m1";
				actorCNSInfo.level = 1;
				actorCNSInfo.exp = 2;
				actorCNSInfo.maxHp = actorCNSInfo.hp = 20;
				actorCNSInfo.attack = 2;
				actorCNSInfo.defense = 2;
				actorCNSInfo.critical = 0.05;
				actorCNSInfo.parry = 0.05;
				actorCNSInfo.redGem = 1;
				actorCNSInfo.greenGem = 0;
				actorCNSInfo.blueGem = 0;
				actorCNSInfo.expIncreaseRate = 2;
				actorCNSInfo.hpIncreaseRate = 2;
				actorCNSInfo.attackIncreaseRate = 1.5;
				actorCNSInfo.defenseIncreaseRate = 1.8;
				actorCNSInfo.criticalIncreaseRate = 1.1;
				actorCNSInfo.parryIncreaseRate = 1.1;
				actorInfos.set( EActor.redSlime + "", actorCNSInfo );
			
				// level	exp	hp	attack	defense	critical	parry		exp_increase_rate	hp_increase_rate	attack_increase_rate	defense_increase_rate	critical_increase_rate	parry_increase_rate
				// 1		2	20	2		2		0.05		0.05		2					2					1.5						1.8	1.1	1.1
			}

			{
				actorCNSInfo = new ActorSettingInfo();
				actorCNSInfo.name = "m2";
				actorCNSInfo.level = 1;
				actorCNSInfo.exp = 2;
				actorCNSInfo.maxHp = actorCNSInfo.hp = 20;
				actorCNSInfo.attack = 2;
				actorCNSInfo.defense = 2;
				actorCNSInfo.critical = 0.05;
				actorCNSInfo.parry = 0.05;
				actorCNSInfo.redGem = 1;
				actorCNSInfo.greenGem = 0;
				actorCNSInfo.blueGem = 0;
				actorCNSInfo.expIncreaseRate = 2;
				actorCNSInfo.hpIncreaseRate = 2;
				actorCNSInfo.attackIncreaseRate = 1.5;
				actorCNSInfo.defenseIncreaseRate = 1.8;
				actorCNSInfo.criticalIncreaseRate = 1.1;
				actorCNSInfo.parryIncreaseRate = 1.1;
				actorInfos.set( EActor.greenSlime + "", actorCNSInfo );
			}

			{
				actorCNSInfo = new ActorSettingInfo();
				actorCNSInfo.name = "m3";
				actorCNSInfo.level = 1;
				actorCNSInfo.exp = 2;
				actorCNSInfo.maxHp = actorCNSInfo.hp = 20;
				actorCNSInfo.attack = 2;
				actorCNSInfo.defense = 2;
				actorCNSInfo.critical = 0.05;
				actorCNSInfo.parry = 0.05;
				actorCNSInfo.redGem = 1;
				actorCNSInfo.greenGem = 0;
				actorCNSInfo.blueGem = 0;
				actorCNSInfo.expIncreaseRate = 2;
				actorCNSInfo.hpIncreaseRate = 2;
				actorCNSInfo.attackIncreaseRate = 1.5;
				actorCNSInfo.defenseIncreaseRate = 1.8;
				actorCNSInfo.criticalIncreaseRate = 1.1;
				actorCNSInfo.parryIncreaseRate = 1.1;
				actorInfos.set( EActor.blueSlime + "", actorCNSInfo );
			}
		}
	}

	public function createActorCNS( p_entityType : EGameEntity, p_actorType : EActor, p_level : Int ) : ActorCNS {
		var actorCNS : ActorCNS = this.actorInfos.get( p_actorType + "" ).clone();
		actorCNS.actorType = p_actorType;
		actorCNS.entityType = p_entityType;
		setLevel( actorCNS, p_level );
		return actorCNS;
	}

	public function setLevel( p_actorCNS : ActorCNS, p_level : Int ) : Void {
		// trace( "raiseLevel" );
		var actorSettingInfo : ActorSettingInfo = this.actorInfos.get( p_actorCNS.actorType + "" );
		
		// var targetLevel : Int = p_actorCNS.level + p_level;
		var targetLevel : Int = p_level;
		if( targetLevel <= 0 ) {
			return ;
		}

		var expIncreaseRate : Float = Math.pow( actorSettingInfo.expIncreaseRate, targetLevel -1 );
		var hpIncreaseRate : Float = Math.pow( actorSettingInfo.hpIncreaseRate, targetLevel -1 );
		var attackIncreaseRate : Float = Math.pow( actorSettingInfo.attackIncreaseRate, targetLevel -1 );
		var defenseIncreaseRate : Float = Math.pow( actorSettingInfo.defenseIncreaseRate, targetLevel -1 );
		var criticalIncreaseRate : Float = Math.pow( actorSettingInfo.criticalIncreaseRate, targetLevel -1 );
		var parryIncreaseRate : Float = Math.pow( actorSettingInfo.parryIncreaseRate, targetLevel -1 );
		
		p_actorCNS.level = targetLevel;
		p_actorCNS.exp = Math.ceil( actorSettingInfo.exp * expIncreaseRate );
		p_actorCNS.hp = p_actorCNS.maxHp = Math.ceil( actorSettingInfo.maxHp * hpIncreaseRate );
		// p_actorCNS.hp = 0;
		p_actorCNS.attack = Math.ceil( actorSettingInfo.attack * attackIncreaseRate );
		p_actorCNS.defense = Math.ceil( actorSettingInfo.defense * defenseIncreaseRate );
		p_actorCNS.critical = ( actorSettingInfo.critical * criticalIncreaseRate );
		p_actorCNS.parry = ( actorSettingInfo.parry * parryIncreaseRate );

		p_actorCNS.redGem = 0;
		p_actorCNS.blueGem = 0;
		p_actorCNS.greenGem = 0;

		trace( p_actorCNS + "" );
		// p_actorCNS.skills( default, null ) : Hash<SkillInfo> = null;
	}

	public static function getNextLevelExp( p_actorCNS : ActorCNS ) : Int {
		return p_actorCNS.level * p_actorCNS.level * 10;
		// switch( p_actor.actorType ) {
		// 	case EActor.jimmy: actor.
		// 	default: trace( "unhandled type: " + p_actor.actorType );
		// }
	}

    static var s_canInit_ : Bool = false;
    static var s_instance_ : ActorSettings = null;
    public static function getInstance() : ActorSettings {
        if ( s_instance_ == null ) {
            s_canInit_ = true;
            s_instance_ = new ActorSettings();
            s_canInit_ = false;
        }

        return s_instance_;
    }
}