package game;

import firerice.core.Entity;
import firerice.components.TransformComponent;
import firerice.common.Helper;
import nme.display.Graphics;
import game.GameEntity;
import game.actor.Actor;
import game.actor.Monster;
import game.actor.Player;
import types.EGameEntity;
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
		// var cloneTop : Bool = false;
		// var cloneBottom : Bool = false;
		// var topGrid : Grid = null;
		// var bottomGrid : Grid = null;

		// var topExcess : Bool = false;
		// var bottomExcess : Bool = false;
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
		for( grid in this.grids ) {
			// trace( "grid.transform.y: " + grid.transform.y );
				// trace( "grid.transform.y - grid.height: " + ( grid.transform.y - grid.height ) );
			if(	( grid.transform.y + grid.height ) < 0  ||
				( grid.transform.y >= Settings.GAME_HEIGHT ) ) {
				// trace( "false" );
				grid.setVisible( false );
			} else {
				// trace( "true" );
				grid.setVisible( true );
			}
		}
	}

	public function alignToGrid() : Void {
		// trace( "\n" );
		for( grid in this.grids ) {
			// alignY = grid.transform.y % Settings.GRID_SIZE;
			alignY = Math.abs( grid.transform.y );
			// trace( "alignToGrid, alignY: " + alignY );
			if( alignY >= ( Settings.GRID_SIZE / 2 ) ) {
				// trace( "alignToGrid 1" );
				// alignY = -alignY;
				alignY = -( Settings.GRID_SIZE - alignY );
				// alignY = alignY;
			} else {
				// trace( "alignToGrid 2" );
				// alignY = -alignY;
			}
				// trace( "alignToGrid 3: " + alignY );
			// trace( "alignY: " + alignY );
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
			var scrollY = this.alignY * dt * 10;
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
	public function addTopping( gridIndex : Int, entityName : String ) {
		Helper.assert( ( gridIndex >= 0 && gridIndex < this.grids.length ), "invalid gridIndex" );

		var actor : Actor;
		actor = new Monster( "monster", this.grids[gridIndex], "assets/motionwelder/m1" );
		this.grids[gridIndex].addTopping( actor );
		actor.camera = this.camera;
		var targetIndex : Int = ( gridIndex + Settings.ROW_COUNT ) % ( Settings.ROW_COUNT * 2 );
		actor = new Monster( "monster2", this.grids[targetIndex], "assets/motionwelder/m1" );
		actor.camera = this.camera;

		this.grids[targetIndex].addTopping( actor );
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