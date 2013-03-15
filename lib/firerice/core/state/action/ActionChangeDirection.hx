package firerice.core.state.action;
import firerice.types.EDirection;
class ActionChangeDirection extends Action {
    var direction( default, null ) : EDirection;

    public function new( p_id : String, p_owner : Entity, p_direction : EDirection ) {
        super( p_id, p_owner );

        this.direction = p_direction;
    }

    override public function trigger() {
        super.trigger();
        this.owner.direction = this.direction;
    }
}
