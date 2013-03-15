package firerice.core.triggers;
import firerice.types.EDirection;
class Trigger {
    public var owner( default, default ) : Entity = null;

    public function new() {
    }

    public function canTrigger() : Bool {
        return false;
    }
}
