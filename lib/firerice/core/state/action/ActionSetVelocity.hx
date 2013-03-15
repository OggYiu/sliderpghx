package firerice.core.state.action;
import firerice.common.Helper;
import firerice.components.TransformComponent;
import flash.geom.Point;
import firerice.types.EDirection;
class ActionSetVelocity extends Action {
    var velocity( default, null ) : Point;

    public function new( p_id : String, p_owner : Entity, p_velocity : Point ) {
        super( p_id, p_owner );

        this.velocity = p_velocity;
    }

    override public function trigger() {
        super.trigger();
    }

    override public function update( dt : Float ) {
//        trace( "update: " + this.isTriggered );
//        if( this.isTriggered )
        {
//            trace( "ActionSetVelocity" );
            var transformComponent = this.owner.getComponent( TransformComponent.ID );
            Helper.assert( transformComponent != null, "invalid transformComponent" );
            transformComponent.pos.x += dt * this.velocity.x;
            transformComponent.pos.y += dt * this.velocity.y;
        }
    }
}
