package firerice.core.triggers;
class TriggerKeyPress extends Trigger {
    var keys( null, null ) : Array<Int> = null;
    public function new( p_keys : Array<Int> ) {
        super();

        this.keys = p_keys;
        // trace( "this.keys: " + this.keys );
    }

    override public function canTrigger() : Bool {
//        trace( "in canTrigger" );
        var inputManager : InputManager = InputManager.getInstance();

//        trace( "this.keys: " + this.keys );
        if( this.keys == null ) {
            if( !inputManager.hasKeyPressed() ) {
//                trace( "this.key 1, true" );
                return true;
            }

//            trace( "this.key 2: " + inputManager.keymap );
            return false;
        } else if( this.keys.length <= 0 ) {
            if( inputManager.hasKeyPressed() ) {
//                trace( "this.key a" );
                return true;
            }

//            trace( "this.key b" );
            return false;
        } else {
//            trace( "this.keys: " + this.keys );
            for( key in this.keys ) {
                if( !inputManager.isKeyOnPress( key ) ) {
//                    trace( "this.key 10" );
                     return false;
                }
            }
//            trace( "this.key 11, " + inputManager.keymap );
            return true;
        }
    }
}
