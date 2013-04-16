package game.ui;

import firerice.core.Entity;
import types.EGemType;
import ru.stablex.ui.UIBuilder;

class GameUI extends Entity {
	public function new( p_id : String, p_parent : Dynamic ) {
		super( p_id, p_parent );

		// init ui
        UIBuilder.init();
        UIBuilder.regClass('SceneGame');
        this.context.addChild( UIBuilder.buildFn('assets/ui/test.xml')( {
        	sceneGame : p_parent
        }) );
	}
}