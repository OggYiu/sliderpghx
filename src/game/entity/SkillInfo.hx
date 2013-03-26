package game.entity;

import types.ESkill;
import types.EGemType;
import types.ESkill;
import types.EMoveType;

class SkillInfo {
	public var skillType( default, default ) : ESkill;
	public var level( default, default ) : Int = 0;
	public var gemBind( default, default ) : EGemType;
	public var hpMod( default, default ) : Int = 0;

	public function new() {
		this.skillType = ESkill.unknown;
		this.gemBind = EGemType.unknown;
	}

	public static function getMoveType( p_skillType : ESkill ) : EMoveType {
		switch( p_skillType ) {
			case ESkill.heal: return EMoveType.instance;
			default:
		}

		return EMoveType.unknown;
	}

	public function clone() : SkillInfo {
		var skillInfo : SkillInfo = new SkillInfo();
		skillInfo.skillType = this.skillType;
		skillInfo.level = this.level;
		skillInfo.gemBind = this.gemBind;
		skillInfo.hpMod = this.hpMod;

		return skillInfo;
	}

	public function toString() : String {
		var output : String = "";
		output += "skillType: " + skillType + "\n";
		output += "level: " + level + "\n";
		output += "gemBind: " + gemBind + "\n";
		output += "hpMod: " + hpMod + "\n";
		return output;
	}
}