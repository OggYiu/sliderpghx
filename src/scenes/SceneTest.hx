package scenes;
import firerice.core.Scene;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

class SceneTest extends Scene
{
	public static var ID : String = "sceneTest";
	
	public function new( p_parentContext : Sprite ) {
		super( SceneTest.ID, p_parentContext );
    }
}