package game.battle;

import firerice.core.Process;
import firerice.common.Helper;
import game.entity.Actor;
import game.entity.Player;
import types.EActorState;

class Battle extends Process {
	public var battleActor1( default, null ) : BattleActor = null;
	public var battleActor2( default, null ) : BattleActor = null;
	public var curTurn( default, null ) : BattleTurn = null;
	public var isEnded( default, null ) : Bool = false;

	public function new( p_id : String, p_actor1 : Actor, p_actor2 : Actor ) {
		super( p_id );
		Helper.assert(	p_actor1.curState != EActorState.battle &&
						p_actor2.curState != EActorState.battle,
						"actor is already in battle" );
		this.battleActor1 = new BattleActor( p_actor1, this );
		this.battleActor2 = new BattleActor( p_actor2, this );

		this.battleActor1.initBattleActor( this.battleActor2 );
		this.battleActor2.initBattleActor( this.battleActor1 );

		// this.battleActor1.isMyTurn = true;
		// this.battleActor1.isTurnEnded = false;
		// this.battleActor2.isMyTurn = false;
		// this.battleActor2.isTurnEnded = true;

		// this.battleActor1.owner.isInBattle = this.battleActor2.owner.isInBattle = true;
		this.battleActor1.owner.changeState( EActorState.battle );
		this.battleActor2.owner.changeState( EActorState.battle );
		Helper.log( "battle begin: " + this.id );
		
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

			if( Std.is( this.battleActor1.owner, Player ) ) {
				this.battleActor1.owner.changeState( EActorState.walk );
			}
			if( Std.is( this.battleActor2.owner, Player ) ) {
				this.battleActor2.owner.changeState( EActorState.walk );
			}
		} else if( 	this.battleActor1.owner.curState != EActorState.battle ||
					this.battleActor2.owner.curState != EActorState.battle ) {
			endBattle();
		}

		if( this.isEnded ) {
			if( !Std.is( this.battleActor1.owner, Player ) ) {
				this.battleActor1.owner.changeState( EActorState.idle );
			}
			if( !Std.is( this.battleActor2.owner, Player ) ) {
				this.battleActor2.owner.changeState( EActorState.idle );
			}
		}
	}

	function endBattle() {
		Helper.log( "battle end: " + this.id + ", idEnded: " + this.isEnded );
		// this.battleActor1.owner.isInBattle = this.battleActor2.owner.isInBattle = false;

		this.isEnded = true;
	}

	override function dispose_() : Void {
		super.dispose_();

		this.battleActor1.dispose();
		this.battleActor2.dispose();
	}
}