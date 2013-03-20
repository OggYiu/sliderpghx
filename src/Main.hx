package ;

import core.AKernal;
import firerice.log.ConsoleSender;
import firerice.log.RayTrace;
import haxe.Timer;
import nme.display.Sprite;
import nme.events.Event;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.Lib;
import game.Settings;

/**
 * ...
 * @author oggyiu
 */

class Main extends Sprite 
{
	var lastUpdateTime_ : Float = 0;
	var updated_ : Bool = false;
	var kernal_ : AKernal = null;
	
	public function new() 
	{
		super();

		// #if flash
		var console_sender_ : ConsoleSender;
    	console_sender_ = new ConsoleSender();
	    trace ( RayTrace.COMMAND_CLEAR );
	 //    #end

		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) {
//        trace( "main.hx init" );
        Lib.stage.addEventListener( Event.ENTER_FRAME, update );

		var stage = Lib.current.stage;
		stage.align = StageAlign.TOP_LEFT;
		stage.scaleMode = StageScaleMode.SHOW_ALL;

		Settings.SCREEN_WIDTH = Std.int( stage.stageWidth );
		Settings.SCREEN_HEIGHT = Std.int( stage.stageHeight );

		kernal_ = new AKernal( this );

		// trace( "Lib.stage.width: " + Lib.stage.width + ", Lib.stage.height: " + Lib.stage.height );
		// trace( "Lib.stage.stageWidth: " + Lib.stage.stageWidth + ", Lib.stage.stageHeight: " + Lib.stage.stageHeight );
	}

	private function update( event : Event ) : Void {
        // trace( "Main.hx update" );
		var dt : Float = 0;
		if ( !updated_ ) {
			updated_ = true;
		} else {
			dt = Timer.stamp() - lastUpdateTime_;
		}
		lastUpdateTime_ = Timer.stamp();

		kernal_.update( dt );
	}
	
	static public function main() 
	{
		// var stage = Lib.current.stage;
		// stage.scaleMode = nme.display.StageScaleMode.EXACT_FIT;
		// stage.scaleMode = nme.display.StageScaleMode.NO_BORDER;
		// stage.scaleMode = nme.display.StageScaleMode.SHOW_ALL;
		// stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		// stage.align = nme.display.StageAlign.TOP_LEFT;

		// stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		// stage.addEventListener(Event.RESIZE, stage_resize);

		// var dpi = stage.dpiScale;
		// Lib.current.scaleX = Lib.current.scaleY = dpi;


		Lib.current.addChild(new Main());
	}
	
}
