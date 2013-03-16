package game.actor;

class ActorState {
	public var owner( default, null ) : Actor = null;
	public var level( default, null ) : Int = 1;
	public var maxHp( default, null ) : Float = 0;
	public var hp( default, null ) : Float = 0;
	public var damage( default, null ) : Float = 0;
	public var defense( default, null ) : Float = 0;
	public var exp( default, null ) : Int = 0;
	public var redGem( default, null ) : Int = 0;
	public var blueGem( default, null ) : Int = 0;
	public var greenGem( default, null ) : Int = 0;
	public var isDead( default, null ) : Bool = false;

	public function new( p_owner : Actor ) {
		this.owner = p_owner;
	}

	public function init(	p_hp : Float,
							p_damage : Float,
							p_defense : Float,
							p_exp : Int,
							p_redGem : Int,
							p_greenGem : Int, 
							p_blueGem : Int ) : Void {
		this.isDead = false;

		this.maxHp = this.hp = p_hp;
		this.damage = p_damage;
		this.defense = p_defense;
		this.exp = p_exp;
		this.redGem = p_redGem;
		this.greenGem = p_greenGem;
		this.blueGem = p_blueGem;
	}

	public function reduceHp( p_value : Float ) : Void {
		if( this.isDead ) {
			return ;
		}

		this.hp -= p_value;
		if( this.hp <= 0 ) {
			this.hp = 0;
			this.isDead = true;

			this.owner.deadHandler();
		}
	}

	public function gainExp( p_value : Int ) : Void {
		var nextLevelExp : Int = game.actor.ActorSettings.getNextLevelExp( this.owner );
	}

	public function gainLeve() : Void {
	}

	public function heal( p_value : Float ) : Void {
		this.hp += p_value;
		if( this.hp > this.maxHp ) {
			this.hp = this.maxHp;
		}
	}
}