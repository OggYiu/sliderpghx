package game;

import nme.display.Sprite;
import nme.display.Graphics;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Quad;
import minimalcomps.Label;

class EffectManager {
	public var context( default, default ) : Sprite = null;
	
	public function new() {
	}

	public function showText( p_x : Float, p_y : Float, p_text : String, p_size : Int, p_color : Int = 0x000000 ) : Void {
		var sprite : Sprite = new Sprite();
		new Label( sprite, 0, 0, p_text, p_size, p_color );
		sprite.x = p_x;
		sprite.y = p_y;
		Actuate.tween( sprite, 1, { y : sprite.y - 50 } ).ease( Quad.easeOut );
		Actuate.tween( sprite, 1, { alpha : 0 } ).ease( Quad.easeOut ).delay( 1 ).onComplete( completeHandler, [ sprite ] );
		this.context.addChild( sprite );
	}

	function completeHandler( sprite : Sprite ) : Void {
		this.context.removeChild( sprite );
	}

    static var s_canInit_ : Bool = false;
    static var s_instance_ : EffectManager = null;
    public static function getInstance() : EffectManager {
        if ( s_instance_ == null ) {
            s_canInit_ = true;
            s_instance_ = new EffectManager();
            s_canInit_ = false;
        }

        return s_instance_;
    }

}