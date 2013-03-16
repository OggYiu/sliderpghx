package game;

import scenes.SceneGame;

class Global {
	public var sceneGame( default, default ) : SceneGame = null;
	
	public function new() {
	}
	
    static var s_canInit_ : Bool = false;
    static var s_instance_ : Global = null;
    public static function getInstance() : Global {
        if ( s_instance_ == null ) {
            s_canInit_ = true;
            s_instance_ = new Global();
            s_canInit_ = false;
        }

        return s_instance_;
    }
}