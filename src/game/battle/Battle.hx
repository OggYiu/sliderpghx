package game.battle;

import firerice.core.Process;
import firerice.common.Helper;
import game.Actor;

class Battle extends Process {
	public var battleActor1( default, null ) : BattleActor = null;
	public var battleActor2( default, null ) : BattleActor = null;
	public var curTurn( default, null ) : BattleTurn = null;
	public var isEnded( default, null ) : Bool = false;

	public function new( p_id : String, p_actor1 : Actor, p_actor2 : Actor ) {
		super( p_id );
		Helper.assert( !p_actor1.isInBattle && !p_actor2.isInBattle, "actor is already in battle" );
		this.battleActor1 = new BattleActor( p_actor1, this );
		this.battleActor2 = new BattleActor( p_actor2, this );

		this.battleActor1.initBattleActor( this.battleActor2 );
		this.battleActor2.initBattleActor( this.battleActor1 );

		// this.battleActor1.isMyTurn = true;
		// this.battleActor1.isTurnEnded = false;
		// this.battleActor2.isMyTurn = false;
		// this.battleActor2.isTurnEnded = true;

		this.battleActor1.owner.isInBattle = this.battleActor2.owner.isInBattle = true;
		trace( "battle begin: " + this.id );
		
		this.battleActor1.beginTurn();
		// this.battleActor2.beginTurn();
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( this.isEnded ) {
			return;
		}

		this.battleActor1.update( dt );
		this.battleActor2.update( dt );

		if( this.battleActor1.owner.isDead || this.battleActor2.owner.isDead ) {
			endBattle();
		} else if( !this.battleActor1.owner.isInBattle || !this.battleActor2.owner.isInBattle ) {
			endBattle();
		}
	}

	function endBattle() {
		trace( "battle end: " + this.id + ", idEnded: " + this.isEnded );
		this.battleActor1.owner.isInBattle = this.battleActor2.owner.isInBattle = false;
		this.isEnded = true;
	}

	override function dispose_() : Void {
		super.dispose_();

		this.battleActor1.dispose();
		this.battleActor2.dispose();
	}
}