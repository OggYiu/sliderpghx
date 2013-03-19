package firerice.core;

import firerice.components.StateComponent;
import firerice.types.EDirection;
import firerice.core.state.State;
import firerice.common.Helper;
import firerice.components.Component;
import firerice.components.TransformComponent;
import firerice.components.AnimationComponent;
import firerice.components.CommandComponent;
import firerice.components.PhysicsComponent;
import firerice.core.Process;
import firerice.interfaces.IComponentContainer;
import firerice.interfaces.IDisplayable;
import firerice.interfaces.IEntityCollection;
import firerice.types.EEntityType;
import haxe.xml.Fast;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.geom.Point;
import nme.events.Event;
import nme.events.IEventDispatcher;
import minimalcomps.Label;

/**
 * ...
 * @author oggyiu
 */

class Entity extends Process, implements IEntityCollection, implements IComponentContainer, implements IDisplayable, implements IEventDispatcher
{
	public var context( default, null ) : Sprite = null;
	public var entities( default, null ) : Hash<Entity> = null;
	public var entityType( default, null ) : EEntityType;
	public var parent( default, null ) : Dynamic = null;
    public var direction( default, default ) : EDirection;
    public var destoryed( default, default ) : Bool = false;
	public var components( default, null ) : Hash<Component> = null;
	public var camera( default, default ) : Camera = null;

    // components
    public var transform( default, null ) : TransformComponent = null;
    public var animation( default, null ) : AnimationComponent = null;
    public var command( default, null ) : CommandComponent = null;
    public var physics( default, null ) : PhysicsComponent = null;
    public var state( default, null ) : StateComponent = null;
   	public var contextPos( getContextPos, null ) : Point;
	
	public function new( p_id : String, ?p_parent : Dynamic ) {
		super( p_id );

		//type = EntityType.unknown;
		this.parent = p_parent;
        this.direction = EDirection.none;

		if ( this.context == null ) {
            this.context = new Sprite();

            // testing
            // new Label( this.context, 0, 0, p_id, 8, 0x000000 );
		}

		// trace( "parent : " + p_parent );
		// trace( "Std.is( this.parent, IEntityCollection: " + Std.is( this.parent, IEntityCollection ) );
        if ( this.parent != null ) {
           // trace( "parent 1" );
			if ( Std.is( this.parent, IEntityCollection ) ) {
               // trace( "parent 2" );
                this.parent.addChild( this );
			}
			if ( Std.is( this.parent, IDisplayable ) ) {
               // trace( "parent 3" );
                this.parent.context.addChild( this.context );
			}
		}
		
		//this.context.addEventListener( Event.RENDER, onRender );
		//CEntityCollection.setAddChild( this );

        this.entities = new Hash<Entity>();
        this.components = new Hash<Component>();

        // this.context.addEventListener( Event.RENDER, onRender );
	}
	
	override function update_( dt : Float ) : Void {
		if( this.transform != null ) {
			this.transform.refreshContextPos();
		}
		for( component in this.components ) {
			component.update( dt );
		}
		
		for ( entity in this.entities ) {
			entity.update( dt );
			if( entity.destoryed ) {
				// trace( "entity destoryed: " + entity.id );
				entity.dispose();
			}
		}

        if( this.state != null ) {
			this.state.update( dt );
		}

        // trace( "this.owner.context.x: " + this.owner.context.x );
        // trace( "this.owner.context.y: " + this.owner.context.y );
	}
	
	public function addComponent( component : Component ) : Component {
		#if debug
		if ( components.get( component.id ) != null ) {
			Helper.assert( false, "<Entity::addComponent>, component: " + component.id + " already existed!" );
			return null;
		}
		#end

        component.owner = this;
        component.init();
		components.set( component.id, component );

		switch( component.id ) {
			case TransformComponent.ID: this.transform = cast( component, TransformComponent );
			case AnimationComponent.ID: this.animation = cast( component, AnimationComponent );
			case CommandComponent.ID: this.command = cast( component, CommandComponent );
			case PhysicsComponent.ID: this.physics = cast( component, PhysicsComponent );
			case StateComponent.ID: this.state = cast( component, StateComponent );
			default: Helper.assert( false, "<addComponent>, unhandled case : " + component.id );
		}
		return component;
	}
	
	public function hasComponent( componentId : String ) : Bool {
		return components.exists( componentId );
	}
	
	public function getComponent( componentId : String ) : Dynamic {
		return components.get( componentId );
	}

	override function dispose_() : Void {
		// trace( "\n" );
		// trace( "dispose: " + this.id );
		// trace( "parent: " + this.parent.id );
		for( entity in entities ) {
			entity.dispose();
		}

        if ( this.parent != null ) {
			// trace( "Std.is( this.parent, IDisplayable ): " + Std.is( this.parent, IDisplayable ) );
			if ( Std.is( this.parent, IDisplayable ) ) {
				// trace( "parent is displayable" );
				for( i in 0 ... this.parent.context.numChildren ) {
					if( this.parent.context.getChildAt( i ) == this.context ) {
						this.parent.context.removeChildAt( i );
				// trace( "this.parent.context.removeChildAt " + i );
						// trace( "child removed 2" );
						break;
					}
				}
			} else {
				// trace( "this.parent: " + this.parent );
			}

			if ( Std.is( this.parent, IEntityCollection ) ) {
				// trace( "remove child" );
				// trace( "this.parent: " + this.parent.id );
                this.parent.removeChild( this );
			}
		}
	}

	public function addChild( entity : Entity ) : Void {
		Helper.assert( !entities.exists( entity.id ), "entity already existed: " + entity.id );
		
		entities.set( entity.id, entity );
		// entity.camera = this.camera;
	}

	public function removeChild( entity : Entity ) : Void {
		Helper.assert( entity != null, "invalid entity" );
		Helper.assert( entities.exists( entity.id), "entity not found" );
		// this.entities.set( entity.id, null );

		// trace( entity.id + " is set to null 2" );
		// entities.set( entity.id, null );
		entities.remove( entity.id );
	}
	
	public function addEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void {
	// public function addEventListener(type : String, listener : Dynamic->Void, ?useCapture : Bool = false, ?priority : Int = 0, ?useWeakReference : Bool = false) : Void {
		this.context.addEventListener( type , listener , useCapture , priority , useWeakReference );
	}
	
	public function dispatchEvent(event : Event) : Bool {
		return this.context.dispatchEvent( event );
	}
	
	public function hasEventListener(type : String) : Bool {
		return this.context.hasEventListener( type );
	}

	public function removeEventListener(type : String, listener : Dynamic -> Void, useCapture : Bool = false) : Void {
	// public function removeEventListener(type : String, listener : Dynamic->Void, ?useCapture : Bool = false) : Void {
		this.context.removeEventListener( type , listener , useCapture );
	}
	
	public function willTrigger(type : String) : Bool {
		return this.context.willTrigger( type );
	}

	public function setVisible( p_visible : Bool ) : Void {
		this.context.visible = p_visible;
	}

	function getContextPos() : Point {
		var point : Point;
		point = this.context.localToGlobal( new Point( 0, 0 ) );
		return point;
	}

	// public function clone() : Entity {
	// 	var cloneEntity : Entity = new Entity( this.id = "_clone", this.parent );
	// 	return cloneEntity;
	// }
}