package game;

import firerice.common.Helper;
import types.EItem;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.Assets;
import game.actor.Player;
import com.eclecticdesignstudio.motion.Actuate;

class Item extends GameEntity {
	public var itemType( getItemType, null ) : EItem;
	var itemCNS : ItemCNS = null;

	public function new( p_id : String, p_parent : Dynamic, p_type : EItem, p_level : Int ) {
		super( p_id, p_parent, types.EGameEntity.item );

		this.itemCNS = ItemSettings.createItemCNS( p_type, p_level );
		// this.itemCNS.owner = this;

		var imagePath : String = "assets/img/item/" + p_type + "" + p_level + ".png";
		trace( "imagePath: " + imagePath );

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

	function completeHandler() : Void {
		this.destoryed = true;
	}

	function getItemType() : EItem {
		return this.itemCNS.type;
	}

	// override public function beginContactHandler( entity : GameEntity ) : Void {
	// 	trace( "beginContactHandler: " + this.id );
	// }

	// override public function endContactHandler( entity : GameEntity ) : Void {
	// 	trace( "endContactHandler: " + this.id );
	// }
}