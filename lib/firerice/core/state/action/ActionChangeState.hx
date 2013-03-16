package firerice.core.state.action;
import firerice.common.Helper;
import firerice.components.StateComponent;
class ActionChangeState extends Action {
    var stateId( default, null ) : String = "";

    public function new( p_id : String, p_owner : Entity, p_stateId : String ) {
        super( p_id, p_owner );

        this.stateId = p_stateId;
    }

    override public function trigger() {
        super.trigger();
        var stateComponent = this.owner.getComponent( StateComponent.ID );
        Helper.assert( stateComponent != null, "invalid stateComponent" );
        stateComponent.changeState( this.stateId );
    }
}
