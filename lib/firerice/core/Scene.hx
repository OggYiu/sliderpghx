package firerice.core;

import firerice.common.Helper;
import firerice.components.TransformComponent;
import firerice.core.Entity;
//import firerice.events.TransformEvent;
import firerice.interfaces.IDisplayable;
import firerice.interfaces.IEntityCollection;
import minimalcomps.Label;
import nme.display.Sprite;
import nme.events.Event;

/**
 * ...
 * @author oggyiu
 */

class Scene extends Process, implements IEntityCollection, implements IDisplayable
{
	public var entities( default, null ) : Hash<Entity> = null;
	public var context( default, null ) : Sprite = null;
    public var camera( default, null ) : Camera = null;

	var parentContext_ : Sprite = null;
	
	public function new( p_id : String, p_parentContext : Sprite ) {
		trace( "scene created: " + p_id );
		super( p_id );
		
		// init
		entities = new Hash<Entity>();
		context = new Sprite();
		// this.camera = new Camera( "camera", this );
		this.camera = new Camera();
		parentContext_ = p_parentContext;
		parentContext_.addChild( context );
		new Label( context, 0, 0, p_id );
		
		//var entity : Entity = new Entity( "testEntity", this );
	}
	
	public function addChild( entity : Entity ) : Void {
		#if debug
		Helper.assert( !entities.exists( entity.id ), "entity already existed: " + entity.id );
		#end
		
		entities.set( entity.id, entity );
		// entity.camera = this.camera;
	}
	
	public function removeChild( entity : Entity ) : Void {
		Helper.assert( entity != null, "invalid entity" );
		Helper.assert( entities.exists( entity.id), "entity not found" );
		// trace( entity.id + " is set to null 1" );
		// entities.set( entity.id, null );
		entities.remove( entity.id );
	}

	override private function update_( dt : Float ) : Void {
		// super.update_( dt );

		for ( entity in this.entities ) {
			entity.update( dt );
			if( entity.destoryed ) {
				// trace( "entity destoryed: " + entity.id );
				entity.dispose();
			}
		}

		this.context.x = -this.camera.x;
		this.context.y = -this.camera.y;
	}
	
	override private function dispose_():Void 
	{
		super.dispose_();
		
		parentContext_.removeChild( context );
	}
}