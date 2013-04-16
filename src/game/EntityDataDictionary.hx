package game;

class EntityDataDictionary {
    var entityDataCollection : Hash<>;
    
	public function new() {
	}

    static var s_canInit_ : Bool = false;
    static var s_instance_ : EntityDataDictionary = null;
    public static function getInstance() : EntityDataDictionary {
        if ( s_instance_ == null ) {
            s_canInit_ = true;
            s_instance_ = new EntityDataDictionary();
            s_canInit_ = false;
        }

        return s_instance_;
    }
}