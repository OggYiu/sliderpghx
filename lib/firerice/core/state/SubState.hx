package firerice.core.state;
import firerice.core.state.action.Action;
import firerice.components.TransformComponent;
import firerice.types.EDirection;
import firerice.core.triggers.Trigger;
//import firerice.core.motionwelder.MReader.WrapMode;
//import firerice.types.EOrientation;
//import firerice.components.AnimationComponent;
import nme.geom.Point;
class SubState extends StateBase {
    public var triggers( default, null ) : Array<Trigger> = null;

    public function new(    ?p_id : String,
//                            p_owner : Entity,
//                            p_animId : Int,
//                            p_hasControl : Bool,
//                            p_velocity : Point,
//                            p_direction : EDirection,
                            p_actions : Array<Action>,
                            p_triggers : Array<Trigger> ) {
        super( p_id, p_actions );

        this.triggers = p_triggers;
    }

    override function init_() : Void {
        super.init_();

        for( trigger in triggers ) {
            trigger.owner = this.owner;
        }
    }

    public function canTrigger() : Bool {
        for( trigger in this.triggers ) {
            if( trigger.canTrigger() ) {
                return true;
            }
        }
        return false;
    }

    override function update_( dt : Float ) : Void {
        super.update_( dt );

//        if( velocity != null ) {
//            if( velocity.length > 0 ) {
//                var transform = this.owner.getComponent( TransformComponent.ID );
//                transform.pos.x += velocity.x * dt;
//                transform.pos.y += velocity.y * dt;
//            }
//        }
    }
}
