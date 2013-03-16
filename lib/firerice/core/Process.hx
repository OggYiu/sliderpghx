package firerice.core;
import firerice.common.Helper;
import nme.events.EventDispatcher;
import nme.events.IEventDispatcher;

/**
 * ...
 * @author oggyiu
 */
class Process
{
    var disposed_ : Bool = false;
    var inited_ : Bool = false;

	public var id( default, null ) : String = "";

	//public var args( default, null ) : Dynamic;

	public function new( p_id : String ) {
        if( p_id == null ) {
            p_id = "";
        }
		id = p_id;
	}

    public function init() : Void {
        Helper.assert( !inited_, "process is already inited: " + this.id );
        if( !inited_ ) {
            init_();
            inited_ = true;
        }
    }

    function init_() : Void {
    }

	public function update( dt : Float ) : Void {
		update_( dt );
	}
	
	// please override this function
	private function update_( dt : Float ) : Void {
	}
	
	public function dispose() : Void {
		if ( !disposed_ ) {
			dispose_();
			disposed_ = true;
		}
	}
	private function dispose_() : Void {
	}
}