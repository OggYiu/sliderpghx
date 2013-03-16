package firerice.core.state;
import firerice.core.state.action.Action;
import firerice.types.EDirection;
//import firerice.core.motionwelder.MReader.WrapMode;
//import firerice.types.EOrientation;
//import firerice.components.AnimationComponent;
import nme.geom.Point;
import firerice.components.TransformComponent;

class State extends StateBase {
    public var XML_ID : String = "state";
    
    var subStates( null, null ) : Array<SubState> = null;

	public function new( p_id : String,
						 p_actions : Array<Action>,
						 p_subStates : Array<SubState> ) {
		super( p_id, p_actions );

        this.subStates = p_subStates;
	}

    override function reset() : Void {
        super.reset();

        for( state in this.subStates ) {
            state.reset();
        }
    }
    //public function new(    p_id : String,
                            //p_animId : Int,
                            //p_hasControl : Bool,
                            //p_velocity : Point,
                            //p_direction : EDirection,
                            //p_subStates : Array<SubState> ) {
        //super( p_id, p_animId, p_hasControl, p_velocity, p_direction );
//
        //this.subStates = p_subStates;
    //}

//    override public function start() : Void {
//        super.start();
//         if( this.subStates != null ) {
//             for( subState in this.subStates ) {
//                 subState.owner = this.owner;
// //                trace( "sequence: " + subState.id );
//             }
//             for( subState in this.subStates ) {
//                 if( subState.canTrigger() ) {
//                     if( this.curSubState != null && this.curSubState.id != subState.id ) {
//                     } else {
//                         subState.start();
//                         this.curSubState = subState;
//                         break;
//                     }
//                 }
//             }
//         }

//    }

    override function dispose_() : Void {
        this.curSubState = null;
    }

    override public function update_( dt : Float ) : Void {
        super.update_( dt );

//        if( velocity != null ) {
//            if( velocity.length > 0 ) {
//                var transform = this.owner.getComponent( TransformComponent.ID );
//                transform.pos.x += velocity.x * dt;
//                transform.pos.y += velocity.y * dt;
//            }
//        }
//
        if( this.curSubState != null ) {
            this.curSubState.update( dt );
        }

        for( action in this.actions ) {
//            trace( "action : " + action );
            action.update( dt );
        }
//
        var needUpdate : Bool = true;
        if( this.curSubState != null && !this.curSubState.hasControl) {
            needUpdate = false;
        }
//
        if( needUpdate ) {
            for( subState in this.subStates ) {
                if( subState.canTrigger() ) {
                    // trace( "subState.canTrigger" );
                    var startSubState : Bool = true;
                    if( this.curSubState != null ) {
                        // trace( "this.curSubState: " + this.curSubState );
                        if( this.curSubState.id == subState.id ) {
                            // trace( "ignroe : this.curSubState.id: " + this.curSubState.id + " same" );
                            startSubState = false;
                        }
                    }

                    if( startSubState ) {
                        subState.start();
                        this.curSubState = subState;
                        break;
                    }
                }
            }
        }
    }
}
