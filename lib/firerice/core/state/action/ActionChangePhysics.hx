package firerice.core.state.action;

import firerice.common.Helper;
import firerice.components.PhysicsComponent;
import firerice.types.EPhysics;
import firerice.types.EDirection;
class ActionChangePhysics extends Action {
    var physics( default, null ) : EPhysics;
    public function new( p_id : String, p_owner : Entity, p_physics : EPhysics ) {
        super( p_id, p_owner );

        this.physics = p_physics;
    }

    override public function trigger() {
        super.trigger();

        var physicsComponent = this.owner.getComponent( PhysicsComponent.ID );
        Helper.assert( physicsComponent != null, "invalid PhysicsComponent" );
        physicsComponent.physics = this.physics;
    }
}
