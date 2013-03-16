package game;

import firerice.core.Entity;
import firerice.components.TransformComponent;
import box2D.dynamics.B2Body;
import box2D.common.math.B2Vec2;
import game.Settings;
import nme.geom.Point;
import types.EGameEntity;

class GameEntity extends Entity {
	public var gameEntityType( default, null ) : EGameEntity;
	public var sensor( default, default ) : B2Body = null;
	public var sensorWidth( default, default ) : Float = 0;
	public var sensorHeight( default, default ) : Float = 0;

	public function new( p_id : String, p_parent : Dynamic ) {
		super( p_id, p_parent );

		this.gameEntityType = EGameEntity.unknown;
		this.addComponent( new TransformComponent( this, 0, 0 ) );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if ( sensor != null ) {
			// sensor.setPosition( new B2Vec2( this.transform.x, this.transform.y ) );
			// if( this.camera != null ) {
				// sensor.setPosition( new B2Vec2(	this.transform.x + Settings.GAME_WORLD_X - this.context.width / 2,
				// 								this.transform.y + Settings.GAME_WORLD_Y - this.context.height / 2 ) );
				// sensor.setPosition( new B2Vec2(	this.context.x - this.context.width / 2,
				// 								this.context.y - this.context.height / 2 ) );
				var worldPos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
				worldPos.x += sensorWidth / 2 + this.camera.x;
				worldPos.y += sensorHeight / 2 + this.camera.y;

				// worldPos.x 
				// sensor.setPosition( new B2Vec2(	this.context.x, this.context.y ) );
				sensor.setPosition( new B2Vec2(	worldPos.x, worldPos.y ) );
				// sensor.setPosition( new B2Vec2(	this.transform.x, this.transform.y ) );
				// this.context.loc
				// trace( this.context.x + ", " + this.context.y );
				// trace( this.camera );

				// trace( "Settings.GAME_WORLD_X: " + Settings.GAME_WORLD_X + ", " + Settings.GAME_WORLD_Y );
			// }
			// sensor.setPosition( new B2Vec2( 0, 0 ) );

			// trace( "this: " + this.transform.x + ", " + this.transform.y );
			// trace( "this: " + this.context.width + ", " + this.context.height );
		}
	}

	override function dispose_() : Void {
		super.dispose_();
		
		Global.getInstance().sceneGame.removeSensor( this );
	}

	public function beginContactHandler( entity : GameEntity ) : Void {
		// trace( "beginContactHandler: " + this.gameEntityType + " vs " + entity.gameEntityType );
	}

	public function endContactHandler( entity : GameEntity ) : Void {
		// trace( "endContactHandler: " + this.gameEntityType + " vs " + entity.gameEntityType );
	}
}