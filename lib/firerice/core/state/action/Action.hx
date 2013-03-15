package firerice.core.state.action;
import firerice.core.Entity;
import firerice.types.EAction;

/**
 * ...
 * @author oggyiu
 */

class Action
{
	public var owner( default, null ) : Entity = null;
	public var id( default, null ) : String = "";
    public var type( default, null ) : EAction;
//    public var isTriggered( default, null ) : Bool = false;

//    public function new( p_id : String, p_owner : Entity ) {
//        this.id = p_id;
//        this.owner = p_owner;
//    }

    public function new( p_id : String, p_owner : Entity ) {
        this.id = p_id;
        this.owner = p_owner;
    }

    public function reset() : Void {
//        this.isTriggered = false;
    }

	public function trigger() : Void {
//        this.isTriggered = true;
	}

    public function update( dt : Float ) : Void {
    }
}