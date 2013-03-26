package game;

import firerice.core.Entity;
import firerice.components.TransformComponent;
import firerice.common.Helper;
import nme.display.Graphics;
import nme.geom.Point;
import game.entity.GameEntity;
import game.entity.Actor;
import game.entity.Monster;
import game.entity.Item;
import game.entity.Player;
import game.entity.ActorCNS;
import game.entity.EntityCNS;
import game.entity.ItemCNS;
import types.EGameEntity;
import types.EItem;
import types.EActor;
import com.eclecticdesignstudio.motion.Actuate;

class Column extends Entity {
	public var grids( default, null ) : Array<Grid> = null;
	public var width( default, null ) : Int = 0;
	public var height( default, null ) : Int = 0;
	public var isTouchLocked( default, default ) : Bool = false;
	var alignY : Float = 0;
	// var topClone : Grid = null;
	// var bottomClone : Grid = null;
	public function new( p_id : String, p_parent : Dynamic ) {
		super( p_id, p_parent );

		this.addComponent( new TransformComponent( this, 0, 0 ) );
		this.camera = game.Global.getInstance().sceneGame.camera;

		// create grids
		this.grids = new Array<Grid>();
		var id : String = "";
		var targetGrid : Grid = null;
		for( i in 0 ... Settings.ROW_COUNT * 2 ) {
			id = "grid" + ( i + 1 ) + "";
			targetGrid = new game.Grid( id, Settings.GRID_SIZE, Settings.GRID_SIZE, this );
			targetGrid.transform.y = Settings.GRID_SIZE * i;
			this.grids.push( targetGrid );
		}

		this.width = Settings.GRID_SIZE;
		this.height = Settings.GRID_SIZE * Settings.ROW_COUNT;

		refreshGridsVisibility();
	}

	public function isTouched( p_x : Float, p_y : Float ) : Bool {
		if( this.isTouchLocked ) {
			return false;
		}
		// trace( this.id + ": " + this.transform.x + ", " + this.transform.y + ", " + this.width + ", " + this.height );
		return hitTest( p_x, p_y, 1, 1,
						this.transform.x, this.transform.y, this.width, this.height );
	}

	function hitTest( x_1 : Float, y_1 : Float, width_1 : Float, height_1 : Float, x_2 : Float, y_2 : Float, width_2 : Float, height_2 : Float ) : Bool {
		return !(x_1 >= x_2+width_2 || x_1+width_1 <= x_2 || y_1 >= y_2+height_2 || y_1+height_1 <= y_2);
	}

	public function scroll( dy : Float ) : Void {
		var grid : Grid = null;
		for( i in 0 ... this.grids.length ) {
			grid = this.grids[i];
			grid.transform.y += dy;
		}

		var index : Int = 0;
		while( index < this.grids.length ) {
			grid = this.grids[index];
			if( index == 0 ) {
				if( grid.transform.y > 0 ) {
					// bottomGrid = this.grids[ this.grids.length - 1];
					// topExcess = true;
					var botGrid : Grid = this.grids[ this.grids.length - 1 ];
					botGrid.transform.y = grid.transform.y - Settings.GRID_SIZE;
					this.grids.sort( sortGrids );
					index = -1;
					// trace( this );
				}
			}
			if( index == ( this.grids.length - 1 ) ) {
				if( ( grid.transform.y + grid.height ) < Settings.GAME_HEIGHT ) {
					var topGrid : Grid = this.grids[0];
					topGrid.transform.y = grid.transform.y + Settings.GRID_SIZE;
					this.grids.sort( sortGrids );
					index = -1;
					// topGrid = this.grids[0];
					// bottomExcess = true;
				}
			}

			++index;

		}

		refreshGridsVisibility();
		// if( cloneTop ) {
		// 	var topGrid = this.grids[0];
		// 	var grid = bottomGrid.clone( topGrid.id + "clone" );
		// 	grid.transform.y = topGrid.transform.y - Settings.GRID_SIZE;
		// 	this.grids.insert( 0, grid );
		// 	grid.setTopping( bottomGrid.topping );
		// 	grid.refreshLabel();
		// }

		// if( cloneBottom ) {
		// 	var bottomGrid = this.grids[ this.grids.length - 1 ];
		// 	var grid = topGrid.clone( bottomGrid.id + "clone" );
		// 	grid.transform.y = bottomGrid.transform.y + Settings.GRID_SIZE;
		// 	this.grids.insert( this.grids.length, grid );
		// 	grid.setTopping( topGrid.topping );
		// 	grid.refreshLabel();
		// }
	}

	function refreshGridsVisibility() {
		// for( grid in this.grids ) {
		// 	if(	( grid.transform.y + grid.height ) < 0.1  ||
		// 		Helper.isZero( grid.transform.y + grid.height ) ||
		// 		( grid.transform.y >= Settings.GAME_HEIGHT ) ) {
		// 		grid.setVisible( false );
		// 	} else {
		// 		grid.setVisible( true );
		// 	}
		// }

		var zeroPos : Point = new Point( 0, 0 );
		var pos : Point = new Point( 0, 0 );
		for( grid in this.grids ) {
			pos = grid.context.localToGlobal( zeroPos );
			if( pos.y < Settings.GAME_WORLD_Y ) {
				grid.context.alpha = ( pos.y + grid.height - Settings.GAME_WORLD_Y ) / Settings.GRID_SIZE;
			} else if( ( pos.y + grid.context.height - 1 ) > ( Settings.GAME_HEIGHT + Settings.GAME_WORLD_Y ) ) {
				// grid.context.alpha = ( ( pos.y + grid.context.height ) - Settings.GAME_HEIGHT - Settings.GAME_WORLD_Y ) / Settings.GRID_SIZE;
				var diff : Float = ( pos.y + grid.context.height ) - ( Settings.GAME_HEIGHT + Settings.GAME_WORLD_Y );
				if( diff <= Settings.GRID_SIZE ) {
					grid.context.alpha = ( Settings.GRID_SIZE - diff ) / Settings.GRID_SIZE;
				} else {
					grid.context.alpha = 0;
				}
			} else {
				grid.context.alpha = 1;
			}
			// grid.context.alpha = ( grid.transform.y + grid.height );
			// if( grid.context.alpha > 1 ) {
			// 	grid.context.alpha = 1;
			// }
		}
	}

	public function alignToGrid() : Void {
		// trace( "\n" );
		for( grid in this.grids ) {
			alignY = Math.abs( grid.transform.y );
			alignY %= Settings.GRID_SIZE;
			if( alignY >= ( Settings.GRID_SIZE / 2 ) ) {
				alignY = -( Settings.GRID_SIZE - alignY );
			} else {
			}

			// trace( "alignY: "  + alignY );
			break;
		}
	}

	public function alignNow() {
		// trace( "align now: " + this.alignY  );
		if( Helper.isZero( this.alignY ) ) {
			return ;
		}
		this.scroll( this.alignY );
		this.alignY = 0;
	}

	public function resetAlignY() : Void {
		this.alignY = 0;
	}

	// function reIndexGrids() : Void {
	// }

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( !Helper.isZero( alignY ) ) {
			var scrollY = this.alignY * dt * Settings.COLUMN_SCROLL_SPEED;
			if( Math.abs( scrollY ) > Math.abs( this.alignY ) ) {
				scrollY = this.alignY;
			}

			this.scroll( scrollY );
			this.alignY -= scrollY;
		}
	}

	function sortGrids( grid1 : Grid, grid2 : Grid ) : Int {
		if( grid1.transform.y < grid2.transform.y ) {
			return -1;
		} else if( grid1.transform.y > grid2.transform.y ) {
			return 1;
		} else {
			return 0;
		}
	}

	// public function addTopping( gridIndex : Int, gameEntityType : EGameEntity ) {
	public function addToppingMonster( gridIndex : Int, p_actorCNS : ActorCNS ) {
		Helper.assert( ( gridIndex >= 0 && gridIndex < this.grids.length ), "invalid gridIndex" );
		
		var targetIndex : Int = gridIndex;
		var actor : Actor;
		actor = new Monster( "monster1", this.grids[targetIndex], p_actorCNS );
		this.grids[gridIndex].addTopping( actor );
		actor.camera = this.camera;
		targetIndex = ( gridIndex + Settings.ROW_COUNT ) % ( Settings.ROW_COUNT * 2 );
		actor = new Monster( "monster2", this.grids[targetIndex], p_actorCNS );
		actor.camera = this.camera;

		this.grids[targetIndex].addTopping( actor );
	}

	public function addToppingItem( gridIndex : Int, p_itemCNS : ItemCNS ) : Void {
		Helper.assert( ( gridIndex >= 0 && gridIndex < this.grids.length ), "invalid gridIndex" );

		var targetGrid : Grid = null;
		var item : Item = null;

		targetGrid = this.grids[gridIndex];
		item = new Item( "item_on_" + targetGrid.id, targetGrid, p_itemCNS );
		this.grids[gridIndex].addTopping( item );
		item.camera = this.camera;

		targetGrid = this.grids[( gridIndex + Settings.ROW_COUNT ) % ( Settings.ROW_COUNT * 2 )];
		item = new Item( "item_on_" + targetGrid.id, targetGrid, p_itemCNS );
		this.grids[gridIndex].addTopping( item );
		item.camera = this.camera;
	} 

	public function removeTopping( gridIndex : Int ) {
	}

	public function releaseColumn() : Void {
		// trace( "releaseColumn: " + this.id );
		var completeHandler = function() { this.destoryed = true; };
		Actuate.tween( this.context, 2, { alpha: 0 } ).onComplete( completeHandler );
		// actuate.tween (MySprite, 1, { alpha: 1 } ).onComplete (trace, "Hello World!");
	}

	public function toString() : String {
		var output : String = "";
		for( grid in this.grids ) {
			output += ( "grid: " + grid.transform.x + ", " + grid.transform.y + "\n" );
		}
		return output;
	}
}