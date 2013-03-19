package game.actor;

import firerice.common.Helper;
import firerice.components.AnimationComponent;
import firerice.types.EOrientation;
import firerice.core.motionwelder.MReader;
import types.EGameEntity;
import types.EActor;
import types.EActorState;
import game.battle.BattleManager;

class Player extends Actor {
	public function new( p_id : String, p_parent : Dynamic, animPath : String ) {
		super( p_id, p_parent, EGameEntity.player, EActor.jimmy );

		// this.gameEntityType = EGameEntity.player;
        this.addComponent( new AnimationComponent( this, animPath ) );
	
		Global.getInstance().sceneGame.createSensor( this, ( Settings.GRID_SIZE * 3 ) / 4, ( Settings.GRID_SIZE * 3 ) / 4 );

		this.changeState( EActorState.walk );
	}

	override public function beginContactHandler( entity : GameEntity ) : Void {
		// trace( "beginContactHandler: " + this.id + ", " + entity.id );
		switch( entity.gameEntityType ) {
			case EGameEntity.grid: {
				this.curGrid = cast( entity, Grid );
				this.curGrid.parentColumn.isTouchLocked = true;
				Global.getInstance().sceneGame.endColumnScrolling();
			}
			case EGameEntity.monster: {
				var monster : Monster = cast( entity, Monster );
				BattleManager.getInstance().beginBattle( this, monster );
			}
			case EGameEntity.item : {
				trace( "item touched" );
				var item : Item = cast( entity, Item );
				item.receivedHandler( this );
			}
			default: Helper.assert( false, "unhandled type : " + entity.gameEntityType );
		}
	}

	override public function endContactHandler( entity : GameEntity ) : Void {
		switch( entity.gameEntityType ) {
			case EGameEntity.grid: {
				var grid : Grid = cast( entity, Grid );
				// trace( "endContactHandler, grid: " + grid.id );
				if( grid.contextPos.x <= this.contextPos.x ) {
					// trace( "grid.transform.x: " + grid.transform.x );
					// trace( "this.transform.x: " + this.transform.x );
					// grid.parentColumn.releaseColumn();
				}
			}
			default:
		}
	}

	override public function playWalkAnimation() : Void {
		// trace( "playWalkAnimation playWalkAnimation" );
		this.animation.animator.play(	3,
										EOrientation.none,
										WrapMode.loop,
										true );
	}
}