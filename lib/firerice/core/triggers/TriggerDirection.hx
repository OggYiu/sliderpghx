package firerice.core.triggers;
import firerice.core.Entity;
import firerice.types.EDirection;
class TriggerDirection extends Trigger {
    public var direction( default, default ) : EDirection;

    public function new( p_direction : EDirection ) {
        super();
        this.direction = p_direction;
    }

    override public function canTrigger() : Bool {
//        trace( "direction canTrigger :" + this.direction + ", this.owner.direction: " + this.owner.direction  );
        if( this.direction != null ) {
//            trace( "direction canTrigger 1" );
//            trace( "this.owner.direction: " + this.owner.direction );
//            trace( "this.direction: " + this.direction );
            if( this.owner.direction == this.direction ) {
//                trace( "direction canTrigger 2" );
                return true;
            }
        }
//        trace( "direction canTrigger3" );
        return false;
    }
}
