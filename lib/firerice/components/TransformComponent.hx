package firerice.components;
import nme.geom.Point;
import firerice.core.Entity;
import firerice.core.Kernal;
import firerice.core.Camera;
import firerice.core.Scene;
//import firerice.events.TransformEvent;
import nme.events.Event;
import nme.display.Stage;
import nme.Lib;

/**
 * ...
 * @author oggyiu
 */

class TransformComponent extends Component
{
    public static var ID : String = "transformComponent";
    public var pos( default, null ) : Point = null;
    public var x( getX, setX ) : Float;
    public var y( getY, setY ) : Float;
    
    public function new( p_owner : Entity, ?p_x :Float, ?p_y :Float )
    {
        //trace( "in new" );
        id = TransformComponent.ID;
        
        super( id, p_owner );

        if( p_x == null ) {
            p_x = 0;
        }
        if( p_y == null ) {
            p_y = 0;
        }
        this.pos = new Point( p_x, p_y );
        refreshContextPos();
    }

    override function init_() : Void {
    }

    public function refreshContextPos() : Void {
        // var camera : Camera = Kernal.getInstance().curCamera;
        // var camera : Camera = this.owner.camera;
        // trace( "camera: " + camera );
        // if( camera != null && camera != this.owner ) {
        // if( camera != null ) {
        //     // trace( "this.x: " + this.x );
        //     // trace( "this.y: " + this.y );
        //     // trace( "camera.x: " + camera.x );
        //     // trace( "camera.y: " + camera.y );
        //     // this.owner.context.x = this.x - camera.transform.x;
        //     // this.owner.context.y = this.y - camera.transform.y;
        //     // this.owner.context.x = this.x - camera.x;
        //     // this.owner.context.y = this.y - camera.y;
        //     this.owner.context.x = this.x - camera.x;
        //     this.owner.context.y = this.y - camera.y;
        //     // trace( "this.owner.context.x: " + this.owner.context.x );
        //     // trace( "this.owner.context.y: " + this.owner.context.y );
        // } else 
        {
            // trace( "1: " + ( camera != null ) + ", " + ( camera != this.owner ) );
            this.owner.context.x = this.x;
            this.owner.context.y = this.y;
        }
    }

    function setX( p_x : Float ) : Float {
        this.pos.x = p_x;
        refreshContextPos();

        return this.pos.x;
    }

    function getX() : Float {
        return this.pos.x;
    }

    function setY( p_y : Float ) : Float {
        this.pos.y = p_y;
        refreshContextPos();
        return this.pos.x;
    }

    function getY() : Float {
        return this.pos.y;
    }
}