package scenes;
import firerice.core.Scene;
import firerice.core.Kernal;
import firerice.core.Entity;
import firerice.common.Helper;
import firerice.components.TransformComponent;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.Graphics;
import nme.Assets;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.Lib;
import minimalcomps.Label;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

import game.GameEntity;
import game.ContactListener;
import game.Grid;
import game.Column;
import game.Settings;
import game.actor.Monster;
import game.actor.Player;
import game.Camera;
import game.DebugDraw;
import types.EGameEntity;
import types.EActorState;
import types.EGemType;
import game.Global;
import game.battle.BattleManager;
import ru.stablex.ui.UIBuilder;

/**
 * ...
 * @author oggyiug
 */

class SceneGame extends Scene
{
	public static var ID : String = "sceneGame";

	var world : B2World = null;
	var debugSprite : Sprite = null;
	var contactListener : ContactListener = null;
	var columns : Array<Column> = null;
	var clickedColumn : Column = null;
	var lastMouseX : Float = 0;
	var lastMouseY : Float = 0;
	var gameWorld : Entity = null;
	var bgs : Array<Sprite> = null;
	var botBgs : Array<Sprite> = null;
	var topBgs : Array<Sprite> = null;
	var topFgs : Array<Sprite> = null;
	var topFogs : Array<Sprite> = null;
	var botFogs : Array<Sprite> = null;
	var player : Player = null;
	var keymap : Hash<Bool> = null;
	var isPaused : Bool = false;

	public function new( p_parentContext : Sprite ) {
		super( SceneGame.ID, p_parentContext );

		game.EffectManager.getInstance().context = this.context;
		game.Global.getInstance().sceneGame = this;
		
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );

		this.keymap = new Hash<Bool>();

		// world = new B2World( new B2Vec2 (0, 10.0), true );
		world = new B2World( new B2Vec2 (0, 0), false );
		debugSprite = new Sprite();

		var debugDraw = new DebugDraw ();
		debugDraw.setSprite( debugSprite );
		debugDraw.setDrawScale( 1 );
		debugDraw.setFlags( B2DebugDraw.e_shapeBit );
		
		world.setDebugDraw( debugDraw );

		contactListener = new ContactListener();
		world.setContactListener( contactListener );

		// Settings.GAME_WIDTH = Std.int( Settings.SCREEN_WIDTH );
		// Settings.GAME_HEIGHT = Std.int( ( Settings.SCREEN_HEIGHT * 3 ) / 4 );
		Settings.COLUMN_COUNT = Math.ceil( Settings.GAME_WIDTH / Settings.GRID_SIZE );
		Settings.ROW_COUNT = Math.ceil( Settings.GAME_HEIGHT / Settings.GRID_SIZE );

		// Settings.log();
		// createSensor (50, 50, 30, 30, true);
		// createSensor (70, 50, 30, 30, true);

		{
			this.bgs = new Array<Sprite>();
			var bg1 : Sprite = new Sprite();
			bg1.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/plain.png" ) ) );
			var bg2 : Sprite = new Sprite();
			bg2.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/plain.png" ) ) );
			bg2.x = bg1.x + bg1.width;
			this.bgs.push( bg1 );
			this.bgs.push( bg2 );
			this.context.addChild( bg1 );
			this.context.addChild( bg2 );
		}
		
		{
			this.botBgs = new Array<Sprite>();
			var bg1 : Sprite = new Sprite();
			bg1.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase1_bottom_fg_1.png" ) ) );
			var bg2 : Sprite = new Sprite();
			bg2.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase1_bottom_fg_2.png" ) ) );
			bg2.x = bg1.x + bg1.width;
			bg2.y = bg1.y = Settings.SCREEN_HEIGHT - bg1.height;
			this.botBgs.push( bg1 );
			this.botBgs.push( bg2 );
			this.context.addChild( bg1 );
			this.context.addChild( bg2 );
		}

		{
			this.topBgs = new Array<Sprite>();
			var bg1 : Sprite = new Sprite();
			bg1.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase2_top_bg_1.png" ) ) );
			var bg2 : Sprite = new Sprite();
			bg2.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase2_top_bg_2.png" ) ) );
			bg2.x = bg1.x + bg1.width;
			this.topBgs.push( bg1 );
			this.topBgs.push( bg2 );
			this.context.addChild( bg1 );
			this.context.addChild( bg2 );
		}

		{
			this.topFgs = new Array<Sprite>();
			var bg1 : Sprite = new Sprite();
			bg1.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase2_top_fg_1.png" ) ) );
			var bg2 : Sprite = new Sprite();
			bg2.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase2_top_fg_2.png" ) ) );
			bg2.x = bg1.x + bg1.width;
			this.topFgs.push( bg1 );
			this.topFgs.push( bg2 );
			this.context.addChild( bg1 );
			this.context.addChild( bg2 );
		}

		{
			this.topFogs = new Array<Sprite>();
			var bg1 : Sprite = new Sprite();
			bg1.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase1_smoke_top.png" ) ) );
			var bg2 : Sprite = new Sprite();
			bg2.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase1_smoke_top.png" ) ) );
			bg2.x = bg1.x + bg1.width;
			bg2.y = bg1.y = - bg1.height / 2;
			this.topFogs.push( bg1 );
			this.topFogs.push( bg2 );
			this.context.addChild( bg1 );
			this.context.addChild( bg2 );
		}

		{
			this.botFogs = new Array<Sprite>();
			var bg1 : Sprite = new Sprite();
			bg1.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase1_smoke_bottom.png" ) ) );
			var bg2 : Sprite = new Sprite();
			bg2.addChild( new Bitmap( nme.Assets.getBitmapData( "assets/img/bg/phase1_smoke_bottom.png" ) ) );
			bg2.x = bg1.x + bg1.width;
			bg2.y = bg1.y = Settings.SCREEN_HEIGHT - bg1.height / 2;
			this.botFogs.push( bg1 );
			this.botFogs.push( bg2 );
			this.context.addChild( bg1 );
			this.context.addChild( bg2 );
		}
		
		// {
		// 	for( sprite in bgs ) {
		// 		sprite.visible = false;
		// 	}
		// 	for( sprite in botBgs ) {
		// 		sprite.visible = false;
		// 	}
		// 	for( sprite in topBgs ) {
		// 		sprite.visible = false;
		// 	}
		// 	for( sprite in topFgs ) {
		// 		sprite.visible = false;
		// 	}
		// 	for( sprite in topFogs ) {
		// 		sprite.visible = false;
		// 	}
		// 	for( sprite in botFogs ) {
		// 		sprite.visible = false;
		// 	}
		// }

		this.gameWorld = new Entity( "gameWorld", this );
		this.gameWorld.addComponent( new TransformComponent( this.gameWorld, 0, 0 ) );
		this.gameWorld.transform.x = Settings.GAME_WORLD_X;
		this.gameWorld.transform.y = Settings.GAME_WORLD_Y;
		// this.context.addChild( debug );

		this.columns = new Array<Column>();
		for( i in 0 ... Settings.COLUMN_COUNT ) {
			var id : String = "column" + ( i + 1 );
			var column : Column = new Column( id, this.gameWorld );
			column.transform.x = i * Settings.GRID_SIZE;
			this.columns.push( column );
		}
		this.columns[2].addTopping( 2, "m1" );

		this.player = new Player( "player", this.gameWorld, "assets/motionwelder/jimmy" );
		// this.player.changeState( types.EActorState.walk );
		// this.player.playWalkAnimation();
		this.player.transform.y = Math.floor( Settings.ROW_COUNT / 2 ) * Settings.GRID_SIZE;
		this.player.camera = this.camera;
		// trace( this.player.gameEntityType );
		// this.player.camera = this.camera;

		var debug : Sprite = new Sprite();
		var graphics : Graphics = debug.graphics;
		graphics.lineStyle( 1, 0x00FF00 );
		graphics.drawRect( 0, 0, Settings.GAME_WIDTH - 1, Settings.GAME_HEIGHT - 1 );
		this.context.addChild( debug );
		debug.x = this.gameWorld.transform.x;
		debug.y = this.gameWorld.transform.y;

		// Kernal.getInstance().curCamera = this.camera;
		// this.camera.x = Settings.GRID_SIZE / 2;

		// createSensor( 10, 10, 100, 50, true );
		
		// debug sprite in the toppest level
		this.context.addChild( debugSprite );

		// init ui
        UIBuilder.init();
        UIBuilder.regClass('SceneGame');
        this.context.addChild( UIBuilder.buildFn('assets/ui/test.xml')( {
        	sceneGame : this
        }) );
    }

	// public function createSensor (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):B2Body {
	// 	var bodyDefinition = new B2BodyDef ();
	// 	bodyDefinition.position.set (x * 1, y * 1);
		
	// 	if (dynamicBody) {
			
	// 		bodyDefinition.type = B2Body.b2_dynamicBody;
			
	// 	}
		
	// 	var polygon = new B2PolygonShape ();
	// 	polygon.setAsBox ((width / 2) * 1, (height / 2) * 1);
		
	// 	var fixtureDefinition = new B2FixtureDef ();
	// 	fixtureDefinition.shape = polygon;
	// 	fixtureDefinition.isSensor = true;
		
	// 	var body = world.createBody( bodyDefinition );
	// 	body.createFixture (fixtureDefinition);
	// 	return body;
	// }

	public function createSensor( gameEntity : GameEntity, width : Float, height : Float ) : B2Body {
		var x : Float = gameEntity.transform.x;
		var y : Float = gameEntity.transform.y;
		// var width : Float = gameEntity.context.width;
		// var height : Float = gameEntity.context.height;
		// var width : Float = ( Settings.GRID_SIZE * 3 ) / 4;
		// var height : Float = ( Settings.GRID_SIZE * 3 ) / 4;
		// trace( "createSensor: " + x + ", " + y + ", " + width + ", " + height );

		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * 1, y * 1);
		
		// if (dynamicBody) {
			
			bodyDefinition.type = B2Body.b2_dynamicBody;
			
		// }
		
		var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) * 1, (height / 2) * 1);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.isSensor = true;
		
		var body = world.createBody( bodyDefinition );
		body.createFixture (fixtureDefinition);
		gameEntity.sensor = body;
		gameEntity.sensorWidth = width;
		gameEntity.sensorHeight = height;
		body.setUserData( gameEntity );
		return body;
	}

	public function removeSensor( gameEntity : GameEntity ) : Void {
		if( gameEntity.sensor == null ) {
			return ;
		}

		this.world.destroyBody( gameEntity.sensor );
		gameEntity.sensor = null;
	}

	function scrollBg( sprites : Array<Sprite>, dt : Float, speed : Float ) : Void {
		if( ( sprites[0].x  - this.camera.x ) > 0 ) {
			var lastSprite : Sprite = sprites[sprites.length-1];
			lastSprite.x = sprites[0].x - sprites[0].width;
			sprites.sort( sortBg );
		}

		for( sprite in sprites ) {
			if( ( sprite.x + sprite.width - this.camera.x ) < 0 ) {
				var lastSprite : Sprite = sprites[sprites.length-1];
				sprite.x = lastSprite.x + lastSprite.width;
				sprites.sort( sortBg );
				break;
			}
		}

		sprites[0].x -= dt * speed;
		var nextX : Float = sprites[0].x;
		for( sprite in sprites ) {
			sprite.x = nextX;
			nextX += sprite.width;
		}
	}

	function sortBg( s1 : Sprite, s2 : Sprite ) : Int {
		if( s1.x == s2.x ) {
			return 0;
		} else if( s1.x < s2.x ) {
			return -1;
		} else {
			return 1;
		}
	}

    override function update_( dt : Float ) : Void {
        super.update_( dt );

        if( this.isPaused ) {
        	return;
        }

		world.step( 1 / 30, 10, 10 );
		world.clearForces ();
		// world.drawDebugData ();

		BattleManager.getInstance().update( dt );

		// this.scrollBg( this.bgs, dt, 20 );
		this.scrollBg( this.botBgs, dt, 35 );
		this.scrollBg( this.topBgs, dt, 15 );
		this.scrollBg( this.topFgs, dt, 20 );
		this.scrollBg( this.topFogs, dt, 20 );
		this.scrollBg( this.botFogs, dt, 20 );

		// update entities with camera pos
		var distanceTolerance : Float = 10;
		for( column in this.columns ) {
			if( Math.abs( column.transform.x - this.player.transform.x ) <= distanceTolerance ) {
				column.isTouchLocked = true;
				this.endColumnScrolling();
			} 
		}

		// this.camera.x = this.player.transform.x;
		// this.camera.x += dt * 20;

		var cameraSpeed : Float = 200;
		if( this.keymap.exists( "37" ) && this.keymap.get( "37" ) ) {
			this.camera.x -= dt * cameraSpeed;
		}
		if( this.keymap.exists( "38" ) && this.keymap.get( "38" ) ) {
			this.camera.y -= dt * cameraSpeed;
		}
		if( this.keymap.exists( "39" ) && this.keymap.get( "39" ) ) {
			this.camera.x += dt * cameraSpeed;
		}
		if( this.keymap.exists( "40" ) && this.keymap.get( "40" ) ) {
			this.camera.y += dt * cameraSpeed;
		}
    }

    function onMouseDown( e : MouseEvent ) : Void {
    	// trace( "onMouseDown" );
    	// var x : Float = e.stageX - this.gameWorld.transform.x;
    	// var y : Float = e.stageY - this.gameWorld.transform.y;
    	var x : Float = e.stageX - this.gameWorld.transform.x + this.camera.x;
    	var y : Float = e.stageY - this.gameWorld.transform.y + this.camera.y;
    	// trace( this.camera.transform.x );

	    this.lastMouseX = x;
	    this.lastMouseY = y;
    	for( column in this.columns ) {
    		// if( column.isTouched( x + this.camera.transform.x, y ) ) {
    		if( column.isTouched( x, y ) ) {
    			this.clickedColumn = column;
    			this.clickedColumn.resetAlignY();
    			break;
    		}
    	}
    }

    public function endColumnScrolling() {
    	if( this.clickedColumn == null ) {
    		return ;
    	}

    	if( this.clickedColumn.isTouchLocked ) {
	    	this.clickedColumn.alignToGrid();
    		this.clickedColumn.alignNow();
    		this.clickedColumn = null;
    		return ;
    	}
    }

    function onMouseUp( _ ) : Void {
    	if( this.clickedColumn != null ) {
	    	this.clickedColumn.alignToGrid();
	    	this.clickedColumn = null;
	    }
    }

    function onMouseMove( e : MouseEvent ) : Void {
    	if( this.clickedColumn == null ) {
    		return ;
    	}

    	var x : Float = e.stageX - this.gameWorld.transform.x + this.camera.x;
    	var y : Float = e.stageY - this.gameWorld.transform.y + this.camera.y;
    	// var dx : Float = x - this.lastMouseX;
    	var dy : Float = y - this.lastMouseY;
    	// if( Helper.isZero( dx ) 
    	// if( dx > dy ) {
    	// 	if( dx > 0 ) {
    	// 		trace( "+x" );
    	// 	} else {
    	// 		trace( "-x" );
    	// 	}
    	// } else {
    	// 	if( dy > 0 ) {
    	// 		trace( "+y" );
    	// 	} else {
    	// 		trace( "-y" );
    	// 	}
    	// }

    	this.clickedColumn.scroll( dy );

	    this.lastMouseX = x;
	    this.lastMouseY = y;
    }

    function onKeyDown( event : KeyboardEvent ) {
    	this.keymap.set( event.keyCode + "", true );
    	if( event.keyCode == 32 ) {
    		this.isPaused = !this.isPaused;
    	} 
    	// trace( "event.keycode: " + event.keyCode + ", true" );
    }

    function onKeyUp( event : KeyboardEvent ) {
    	this.keymap.set( event.keyCode + "", false );
    	// trace( "event.keycode: " + event.keyCode + ", false" );
    }

	override function dispose_() {
		super.dispose_();
		
		Global.getInstance().sceneGame = null;
	}

	function inputEscapeHandler() : Void {
		trace( "inputEscapeHandler" );
	}

	function inputRunBeginHandler() : Void {
		Helper.assert( this.player.curState != EActorState.run, "player is already running" );
		if( this.player.curState != EActorState.run &&
			this.player.curState != EActorState.battle ) {
			this.player.changeState( EActorState.run );
		}
	}

	function inputRunEndHandler() : Void {
		if( this.player.curState == EActorState.run ) {
			this.player.changeState( EActorState.walk );
		}
	}

	function inputGemHandler( p_gemType : EGemType ) : Void {
		trace( "inputGemHandler: " + p_gemType );
	}
}