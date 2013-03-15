package core;

import firerice.core.Kernal;
import scenes.SceneGame;
import scenes.SceneTest;
import nme.display.Sprite;

class AKernal extends Kernal {
	public function new( p_canvas : Sprite ) {
		super( p_canvas );
		registerScene( SceneTest.ID, SceneTest );
		registerScene( SceneGame.ID, SceneGame );
		
		// var startSceneId : String = SceneTest.ID;
		var startSceneId : String = SceneGame.ID;
		changeScene( startSceneId );
	}

    override function update_( dt : Float ) : Void {
        super.update_( dt );


    }
}