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
}