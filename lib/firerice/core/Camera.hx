package firerice.core;

import firerice.core.Entity;
import firerice.components.TransformComponent;

// class Camera extends Entity {
class Camera {
	public var x( default, default ) : Float = 0;
	public var y( default, default ) : Float = 0;
	// public function new( p_id : String, p_parent : Dynamic ) {
	public function new() {
		// super( p_id, p_parent );
		// this.addComponent( new TransformComponent( this, 0, 0 ) );
	}
}