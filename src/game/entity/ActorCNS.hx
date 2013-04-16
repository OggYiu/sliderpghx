package game.entity;

import firerice.common.Helper;
import types.EGemType;
import types.ESkill;
import types.EActor;
import game.entity.ActorSettings;

class ActorCNS extends EntityCNS {
	// public var owner( default, default ) : Actor = null;
	public var actorType( default, default ) : EActor;
	public var name( default, default ) : String = "";
	public var level( default, default ) : Int = 1;
	public var maxHp( default, default ) : Float = 0;
	public var hp( default, default ) : Float = 0;
	public var attack( default, default ) : Float = 0;
	public var defense( default, default ) : Float = 0;
	public var critical( default, default ) : Float = 0;
	public var parry( default, default ) : Float = 0;
	public var exp( default, default ) : Int = 0;
	public var redGem( default, default ) : Int = 0;
	public var blueGem( default, default ) : Int = 0;
	public var greenGem( default, default ) : Int = 0;
	// public var isDead( default, null ) : Bool = false;
	public var skills( default, null ) : Hash<SkillInfo> = null;

	public function new() {
		super();
		
		this.skills = new Hash<SkillInfo>();
	}
	
	public function addSkill( p_skillInfo : SkillInfo ) : Void {
		Helper.assert( !this.skills.exists( p_skillInfo.skillType + "" ), "skill " + p_skillInfo.skillType + " already existed" );
		for( skill in this.skills ) {
			if( skill.gemBind == p_skillInfo.gemBind ) {
				Helper.assert( false, "gemBind : " + skill.gemBind + " already existed" );
				break;
			}
		}
		this.skills.set( p_skillInfo.skillType + "", p_skillInfo );
	}

	public function getSkill( p_gemType : EGemType ) : SkillInfo {
		var skillInfo : SkillInfo = null;

		for( skill in this.skills ) {
			if( skill.gemBind == p_gemType ) {
				skillInfo = skill;
				break;
			}
		}
		return skillInfo;
	}

	public function clone() : ActorCNS {
		var actorCNS : ActorCNS = new ActorCNS();
		// actorCNS.owner = this.owner;
		actorCNS.actorType = this.actorType;
		actorCNS.name = this.name;
		actorCNS.level = this.level;
		actorCNS.maxHp = this.maxHp;
		actorCNS.hp = this.hp;
		actorCNS.attack = this.attack;
		actorCNS.defense = this.defense;
		actorCNS.critical = this.critical;
		actorCNS.parry = this.parry;
		actorCNS.exp = this.exp;
		actorCNS.redGem = this.redGem;
		actorCNS.blueGem = this.blueGem;
		actorCNS.greenGem = this.greenGem;

		for( skillInfo in this.skills ) {
			actorCNS.addSkill( skillInfo.clone() );
		}

		return actorCNS;
	}

	public function setLevel( p_level : Int ) : Void {
		ActorSettings.getInstance().setLevel( this, p_level );
	}

	public function toString() : String {
		var output : String = "";

		output += "\n";
		// output += "owner: " + this.owner.id + "\n";
		output += "actorType: " + this.actorType + "\n";
		output += "name: " + this.name + "\n";
		output += "level: " + this.level + "\n";
		output += "maxHp: " + this.maxHp + "\n";
		output += "hp: " + this.hp + "\n";
		output += "attack: " + this.attack + "\n";
		output += "defense: " + this.defense + "\n";
		output += "critical: " + this.critical + "\n";
		output += "parry: " + this.parry + "\n";
		output += "exp: " + this.exp + "\n";
		output += "redGem: " + this.redGem + "\n";
		output += "blueGem: " + this.blueGem + "\n";
		output += "greenGem: " + this.greenGem + "\n";

		output += "skills:\n";
		for( skill in this.skills ) {
			output += skill + "\n";
		}

		return output;
	}
}