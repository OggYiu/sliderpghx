package firerice.core.state.action;

// import firerice.components.AnimationComponent;
/**
 * ...
 * @author oggyiu
 */

import firerice.types.EOrientation;
import firerice.core.motionwelder.MReader.WrapMode;
import firerice.components.AnimationComponent;
class ActionChangeAnimation extends Action
{
//    public function new( p_id : String, p_owner : Entity ) {
//        super( p_id, p_owner );
//    }

    var animId( default, null ) : Int = 0;
    var overrideAnim( default, null ) : Bool = false;
    var wrapMode( default, null ) : WrapMode;

    public function new( p_id : String, p_owner : Entity, p_animId : Int, p_wrapMode : WrapMode, p_overrideAnim : Bool ) {
        super( p_id, p_owner );

        this.animId = p_animId;
        this.overrideAnim = p_overrideAnim;
        this.wrapMode = p_wrapMode;
    }
	
	override public function trigger() {
        super.trigger();
		//this.animationComponent = this.owner.
        // trace( "trigger" );
        var animationComponent : Dynamic = this.owner.getComponent( AnimationComponent.ID );
            // trace( "animation played, this.owner: " + this.owner );
            // trace( "animationComponent: " + animationComponent );
        if( animationComponent != null ) {
            // trace( "animation played, : " + this.animId );
            animationComponent.animator.play( this.animId, EOrientation.none, this.wrapMode, this.overrideAnim );
        }
	}
}