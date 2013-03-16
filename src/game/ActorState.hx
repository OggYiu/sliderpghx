package game;

class ActorState {
	public var owner( default, null ) : Actor = null;
	public var level( default, null ) : Int = 1;
	public var hp( default, default ) : Float = 0;
	public var damage( default, default ) : Float = 0;
	public var defense( default, default ) : Float = 0;
	public var exp( default, default ) : Int = 0;
	public var redGem( default, default ) : Int = 0;
	public var blueGem( default, default ) : Int = 0;
	public var greenGem( default, default ) : Int = 0;
	public var isDead( default, null ) : Bool = false;

	public function new( p_owner : Actor ) {
		this.owner = p_owner;
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
		var nextLevelExp : Int = game.ActorSettings.getNextLevelExp( this.owner );
	}

	public function gainLeve() : Void {
		
	}
}