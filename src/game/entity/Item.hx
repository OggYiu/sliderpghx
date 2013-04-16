package game.entity;

import firerice.common.Helper;
import types.EItem;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.Assets;
import nme.geom.Point;
import game.entity.Player;
import game.entity.ItemCNS;
import com.eclecticdesignstudio.motion.Actuate;
import box2D.common.math.B2Vec2;

class Item extends GameEntity {
	public var itemType( getItemType, null ) : EItem;
	var itemCNS : ItemCNS = null;

	public function new( p_id : String, p_parent : Dynamic, p_itemCNS : ItemCNS ) {
		super( p_id, p_parent, types.EGameEntity.item );

		this.itemCNS = p_itemCNS;
		// this.itemCNS.owner = this;

		var imagePath : String = Settings.ITEM_IMAGE_PATH + "" + this.itemCNS.itemType + "" + this.itemCNS.level + ".png";
		// trace( "imagePath: " + imagePath );

		var bitmapData : BitmapData = Assets.getBitmapData( imagePath );
		var bitmap : Bitmap = new Bitmap( bitmapData );
		this.context.addChild( bitmap );

		this.sensor = game.Global.getInstance().sceneGame.createSensor( this, Settings.GRID_SIZE - 1, Settings.GRID_SIZE - 1 );
	}

	public function receivedHandler( p_player : Player ) : Void {
		switch( this.itemType ) {
			case EItem.potion: p_player.heal( this.itemCNS.value );
			case EItem.weapon:
			case EItem.shield:
			default: Helper.assert( false, "unhandled type : " + this.itemType );
		}

		Actuate.tween( this.context, 2, { alpha: 0 } ).onComplete( completeHandler );
		Actuate.tween( this.context, 1, { y : this.context.y - 20 } );
	}

	override function updateSensorPos() : Void {
		var worldPos : Point = this.context.localToGlobal( new Point( 0, 0 ) );
		worldPos.x -= sensorWidth;
		sensor.setPosition( new B2Vec2(	worldPos.x, worldPos.y ) );
	}

	function completeHandler() : Void {
		this.destoryed = true;
	}

	function getItemType() : EItem {
		return this.itemCNS.itemType;
	}

	// override public function beginContactHandler( entity : GameEntity ) : Void {
	// 	trace( "beginContactHandler: " + this.id );
	// }

	// override public function endContactHandler( entity : GameEntity ) : Void {
	// 	trace( "endContactHandler: " + this.id );
	// }
}