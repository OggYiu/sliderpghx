package firerice.components;
import firerice.core.Process;
import firerice.core.Entity;

/**
 * ...
 * @author oggyiu
 */

enum ComponentType {
	none;
	transform;
}
class Component extends Process
{
	public var owner( default, default ) : Entity = null;
	public var type( default, null ) : ComponentType;
	
	public function new( p_id : String, p_owner : Entity ) {
		super( p_id );

        this.owner = p_owner;
	}
	
	// override this function to resolve the relationship with the other component
	public function resolve( component : Component ) : Void {
		
	}
}