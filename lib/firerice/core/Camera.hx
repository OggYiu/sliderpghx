package firerice.core;

import firerice.core.Entity;
import firerice.components.TransformComponent;
import nme.display.Sprite;

// class Camera extends Entity {
class Camera extends Process {
	public var x( default, default ) : Float = 0;
	public var y( default, default ) : Float = 0;
	public var entity( default, null ) : Entity = null;

	// public function new( p_id : String, p_parent : Dynamic ) {
	public function new( p_id : String, p_targetEntity : Entity ) {
		super( p_id );

		this.entity = p_targetEntity;
		// this.addComponent( new TransformComponent( this, 0, 0 ) );
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		if( this.entity != null ) {
			this.entity.context.x = this.entity.transform.x - this.x;
			this.entity.context.y = this.entity.transform.y - this.y;
		}
	}
}