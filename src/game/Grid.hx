package game;

import firerice.core.Entity;
import firerice.core.Kernal;
import firerice.components.TransformComponent;
import nme.display.Graphics;
import minimalcomps.Label;
import scenes.SceneGame;
import types.EGameEntity;
import types.EItem;
import game.Column;
import game.entity.Actor;
import game.entity.GameEntity;
import game.entity.ActorCNS;

class Grid extends GameEntity {
	// public var pos( default, default ) : Int = 0;
	public var width( default, null ) : Int;
	public var height( default, null ) : Int;
	public var topping( default, null ) : GameEntity = null;
	public var parentColumn( default, null ) : Column = null;
	var label : Label = null;

	public function new( p_id : String, p_width : Int, p_height : Int, p_parent : Column ) {
		super( p_id, p_parent, EGameEntity.grid );

		// this.gameEntityType = EGameEntity.grid;
		// this.pos = p_pos;
		this.width = p_width;
		this.height = p_height;
		this.parentColumn = p_parent;
		this.camera = this.parentColumn.camera;

		this.sensor = game.Global.getInstance().sceneGame.createSensor( this, this.width - 1, this.height - 1 );
		// this.topping = Std.int( Math.random() * 100 );

		// this.addComponent( new TransformComponent( this, 0, 0 ) );

		var graphics : Graphics = this.context.graphics;
		graphics.lineStyle( 1, 0xFF0000 );
		graphics.drawRect( 0, 0, p_width - 1, p_height - 1 );

		this.label = new Label( this.context, 0, 0, "", 8, 0x000000 );
		refreshLabel();
	}

	public function refreshLabel() : Void {
		this.label.text = this.id; // + ", " + this.topping;
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
	}

	override function dispose_() : Void {
		super.dispose_();
	}

	public function clone( p_id : String ) : Entity {
		return new Grid( p_id, this.width, this.height, this.parent );
	}

	// public function addToppingItem( p_type : EItem, p_level : Int ) : Item {
	// 	var item : Item = new Item( "item_on_" + this.id, this.parent, p_level );
	// 	return item;
	// }

	// public function addToppingItem( p_item : Item ) : Void {
	// 	this.topping = p_item;
	// }

	public function addTopping( gameEntity : GameEntity ) {
		// this.grids[0].addTopping( new Monster( "monster1", this.grids[0], "assets/motionwelder/m1" ) );
		this.topping = gameEntity;
	}
	// public function setTopping( p_topping : Int ) : Void {
	// 	this.topping = p_topping;
	// }
}