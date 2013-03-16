package firerice.components;
import firerice.core.Entity;
import firerice.core.motionwelder.MAnimationSet;
import firerice.core.motionwelder.MReader;
import firerice.core.motionwelder.MSpriteData;
import firerice.core.motionwelder.MSpriteLoader;
import firerice.core.motionwelder.ResourceLoader;
import firerice.interfaces.IDisplayable;
import firerice.types.EOrientation;
import nme.display.Bitmap;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

class AnimationComponent extends Component, implements IDisplayable
{
	public static var ID : String = "animationComponent";
	
	public var animator( default, null ) : MAnimationSet;
	public var context( default, null ) : Sprite;
    public var dataPath( default, null ) : String = "";
    public var imgPath( default, null ) : String = "";
   	public var target( default, default ) : Dynamic = null;
   	public var completeHandler( default, default ) : Void -> Void;
   	public var frameHandler( default, null ) : AnimationEnterFrameDelegate = null;
	var contextBitmap_ : Bitmap = null;
	
	public function new( p_owner : Entity, p_dataPath : String, ?p_imagePath : String ) {
        if( p_imagePath == null ) {
            p_imagePath = p_dataPath;
        }

        target = null;
		completeHandler = null;

		super( AnimationComponent.ID, p_owner );
        this.dataPath = p_dataPath;
        this.imgPath = p_imagePath;
	}

    override function init_() : Void {
        this.context = new Sprite();
        contextBitmap_ = new Bitmap();
        this.context.addChild( contextBitmap_ );
        this.owner.context.addChild( this.context );

        var spriteData : MSpriteData;
        spriteData = MSpriteLoader.getInstance().loadMSprite( this.dataPath, this.imgPath, true, ResourceLoader.getInstance() );
        this.animator = MReader.read( spriteData );
        this.animator.setEventReceiver( this, AnimationCompleteHandler, AnimationEventHandler );
        this.animator.play(0, EOrientation.none, WrapMode.loop, true );
    }
	
	override private function update_(dt:Float):Void 
	{
		super.update_(dt);
		this.animator.update( dt );
	}
	
	function AnimationCompleteHandler(	animationSet : MAnimationSet,
										clipId : Int) : Void {
//		 trace( "<MGameEntity::AnimationCompleteHandler>" );

		if ( this.target != null && this.completeHandler != null ) {
			Reflect.callMethod( this.target, this.completeHandler, [] );
		}
	}

	function AnimationEventHandler(	animationSet : MAnimationSet,
									animation : MAnimation,
									frame : MFrame,
									unknown : Int ) : Void {
//		trace( "<MGameEntity::AnimationEventHandler>" );
		contextBitmap_.bitmapData = frame.frameImages[0].bitmapdata;
		contextBitmap_.x = frame.frameImages[0].xPos;
		contextBitmap_.y = frame.frameImages[0].yPos;

		if ( this.target != null && this.frameHandler != null ) {
			// animationEventDelegate( this, currentAnimation_, currentAnimation_.frames[0], 0 );
			Reflect.callMethod( this.target, frameHandler, [ animationSet, animation, frame, unknown ] );
		}
		 //trace( "<MGameEntity::AnimationEventHandler>, contextBitmap_.bitmapData: " + contextBitmap_.bitmapData );
	}

	public function resetHandler() : Void {
   		this.target = null;
   		this.completeHandler = null;
   		this.frameHandler = null;
	}
}