package firerice.components;
import nme.geom.Point;
import firerice.common.Helper;
import firerice.core.Entity;
import firerice.types.EPhysics;
class PhysicsComponent extends Component {
    public static var ID : String = "physicsComponent";

    public var physics( default, default ) : EPhysics;
    public function new( p_owner : Entity, p_physics : EPhysics )
    {
        super( PhysicsComponent.ID, p_owner );
        this.physics = p_physics;
    }

    override function init_() : Void {
    }

    override function update_( dt : Float ) : Void {
        super.update_( dt );

        switch( this.physics ) {
            case none:
            case normal: {
                var transformComponent : Dynamic = this.owner.getComponent( TransformComponent.ID );
                Helper.assert( transformComponent != null, "invalid transformComponent" );
                transformComponent.pos.y -= dt * 100;
            }
        }
    }
}
