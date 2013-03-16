package firerice.core.state;

import firerice.core.state.action.Action;
import firerice.core.triggers.Trigger;
import nme.geom.Point;
import firerice.types.EOrientation;
import firerice.types.EDirection;
import firerice.components.AnimationComponent;
import firerice.core.motionwelder.MReader.WrapMode;

class StateBase extends Process {
    public var owner( default, default ) : Entity = null;
    var curSubState( null, null ) : SubState = null;
//    var subStates( null, null ) : Array<SubState> = null;
	var actions( null, null ) : Array<Action> = null;
    public var hasControl( default, null ) : Bool = true;
//    var triggers( null, null ) : Array<Trigger> = null;

    //public var animId( default, null ) : Int = 0;
    //public var hasControl( default, null ) : Bool = false;
    //public var velocity( null, null ) : Point = null;
    //public var direction( default, null ) : EDirection;
	
	public function new( p_id : String,
						 p_actions : Array<Action> )
	{
        super( p_id );
        this.actions = p_actions;
	}

    function reset() : Void {
        this.curSubState = null;
        this.hasControl = true;

        for( action in this.actions ) {
            action.reset();
        }
    }
    //public function new(    p_id : String,
                            //p_animId : Int,
                            //p_hasControl : Bool,
                            //p_velocity : Point,
                            //p_direction : EDirection ) {
        //super( p_id );
//
        //this.animId = p_animId;
        //this.hasControl = p_hasControl;
        //this.velocity = p_velocity;
        //this.direction = p_direction;
    //}

    public function start() : Void {
        reset();
//        trace( "substate: " + this.id + "started" );
//        this.disposed_ = false;

        for( action in this.actions ) {
            // trace( "action : " + action );
            action.trigger();
        }
//        if( this.animId >= 0 ) {
//            var animComponent = this.owner.getComponent( AnimationComponent.ID );
//            if( animComponent != null && this.animId >= 0 ) {
//                animComponent.animator.play( this.animId, EOrientation.none, WrapMode.loop, true );
//            }
//        }
//
//        if( this.direction != null ) {
//            this.owner.direction = this.direction;
//        }
    }
}
