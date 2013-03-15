package firerice.core;
import nme.ui.Keyboard;
import firerice.components.AnimationComponent;
import firerice.components.CommandComponent;
import firerice.common.Helper;
import firerice.core.Entity;
import firerice.core.Scene;
import firerice.types.EUserInterface;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.types.EOrientation;
import nme.Assets;
import nme.Lib;
import nme.geom.Point;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;

class InputManager {
    public var keysJustActive( default, null ) : Hash<Bool> = null;
    public var keymap( default, null ) : Hash<Bool> = null;
    public var mousePos( default, null ) : Point = null;
    public var mouseDown( default, null ) : Bool = false;
//    var limit( default, default ) : Int = 5;
//    public var historys( default, null ) : Array<Hash<Bool>>;
//    var someKeyPressed( null, null ) : Bool = false;l;

    public function new() {
        this.keymap = new Hash<Bool>();
        this.mousePos = new Point( 0, 0 );
//        this.historys = new Array<Hash<Bool>>();

        Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Lib.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        Lib.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        Lib.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown );
        Lib.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp );
    }


    function onKeyDown(event:KeyboardEvent) : Void {
        if( this.keysJustActive == null ) {
            this.keysJustActive = new Hash<Bool>();
        }

        keymap.set( event.keyCode + "", true );
        keysJustActive.set( event.keyCode + "", true );
//        someKeyPressed = true;
    }

    function onKeyUp(event:KeyboardEvent) : Void {
        if( this.keysJustActive == null ) {
            this.keysJustActive = new Hash<Bool>();
        }

        keymap.set( event.keyCode + "", false );
        keysJustActive.set( event.keyCode + "", false );

//        someKeyPressed = true;
    }

    function onMouseMove( event : MouseEvent ) : Void {
        mousePos.x = event.stageX;
        mousePos.y = event.stageY;
    }

    function onMouseDown( event : MouseEvent ) : Void {
        mouseDown = true;
    }

    function onMouseUp( event : MouseEvent ) : Void {
        mouseDown = false;
    }

    public function isKeyOnPress( keycode : Int ) : Bool {
        return keymap.get( keycode + "" );
    }

    public function hasKeyPressed() : Bool {
        for( elem in keymap ) {
            if( elem ) {
                return true;
            }
        }

        return false;
    }

    public function update( dt : Float ) : Void {
//        if( someKeyPressed )
//        {
//            this.historys.push( this.keysJustActive );
//            while( this.historys.length > this.limit ) {
//                this.historys = this.historys.splice(1, this.historys.length-1 );
//            }
//
//            someKeyPressed = false;
//
//        }

        this.keysJustActive = null;
    }

    static var s_canInit_ : Bool = false;
    static var s_instance_ : InputManager = null;
    public static function getInstance() : InputManager {
        if ( s_instance_ == null ) {
            s_canInit_ = true;
            s_instance_ = new InputManager();
            s_canInit_ = false;
        }

        return s_instance_;
    }

}