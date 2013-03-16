package firerice.components;
import firerice.core.state.action.ActionChangeAnimation;
import firerice.core.state.action.Action;
import firerice.core.Entity;
import firerice.common.Helper;
import firerice.core.state.State;
import firerice.core.state.SubState;
import firerice.core.triggers.TriggerDirection;
import firerice.core.triggers.TriggerKeyPress;
import firerice.types.EDirection;
import nme.geom.Point;
import nme.ui.Keyboard;
/**
 * ...
 * @author oggyiu
 */

class StateComponent extends Component
{
    public static var ID : String = "stateComponent";
    public static var STATE_DEFAULT : String = "stateDefault";
	
	var curState( default, null ) : State = null;
    var states( default, null ) : Hash<State>;

    public function new( p_owner : Entity, p_states : Hash<State> ) {
		//trace( "in new" );
		id = StateComponent.ID;

		super( id, p_owner );
		
        this.states = p_states;
    }
	
    override function init_() : Void {
        super.init_();
        
        changeState( StateComponent.STATE_DEFAULT );
        // if( this.states != null ) {
        //     if( this.states[STATE_DEFAULT]
        // }

//        registerScene( SceneTest.ID, SceneTest );

        //var velocity : Point = new Point( 100, 100 );
        {
            //var subStates : Array<SubState> = new Array<SubState>();
            //subStates.push( new SubState( "idleRight", this.owner, 0, true, null, EDirection.east, new TriggerDirection( EDirection.east ) ) );
            //subStates.push( new SubState( "idleLeft", this.owner, 1, true, null, EDirection.west, new TriggerDirection( EDirection.west ) ) );

            //registerState( new State( "idle", -1, true, new Point( 0, 0 ), null, subStates ) );
//			var actions : Array<Action> = new Array<Action>();
//            actions.push( new ActionChangeAnimation( "change_anim", 0 ) );
//			var subStates : Array<SubState> = new Array<SubState>();
//			registerState( new State( "idle", actions, subStates ) );
		}

        {
            //var subStates : Array<SubState> = new Array<SubState>();
            //subStates.push( new SubState( "walkRightUp", this.owner, 2, true, new Point( velocity.x, -velocity.y ), EDirection.east, new TriggerKeyPress( [Keyboard.RIGHT, Keyboard.UP] ) ) );
            //subStates.push( new SubState( "walkRightDown", this.owner, 2, true, new Point( velocity.x, velocity.y ), EDirection.east, new TriggerKeyPress( [Keyboard.RIGHT, Keyboard.DOWN] ) ) );
            //subStates.push( new SubState( "walkRight", this.owner, 2, true, new Point( velocity.x, 0 ), EDirection.east, new TriggerKeyPress( [Keyboard.RIGHT] ) ) );
//
            //subStates.push( new SubState( "walkLeftUp", this.owner, 3, true, new Point( -velocity.x, -velocity.y ), EDirection.west, new TriggerKeyPress( [Keyboard.LEFT, Keyboard.UP] ) ) );
            //subStates.push( new SubState( "walkLeftDown", this.owner, 3, true, new Point( -velocity.x, velocity.y ), EDirection.west, new TriggerKeyPress( [Keyboard.LEFT, Keyboard.DOWN] ) ) );
            //subStates.push( new SubState( "walkLeft", this.owner, 3, true, new Point( -velocity.x, 0 ), EDirection.west, new TriggerKeyPress( [Keyboard.LEFT] ) ) );
//
            //subStates.push( new SubState( "walkUp", this.owner, -1, true, new Point( 0, -velocity.y ), null, new TriggerKeyPress( [Keyboard.UP] ) ) );
            //subStates.push( new SubState( "walkDown", this.owner, -1, true, new Point( 0, velocity.y ), null, new TriggerKeyPress( [Keyboard.DOWN] ) ) );
//
            //registerState( new State( "walk", -1, true, null, null, subStates ) );
        }

        {
//            var subStates : Array<SubState> = new Array<SubState>();
//            registerState( new State( "walk", -1, true, null, null, subStates ) );
        }
    }

//    public function changeState( state : State ) : Void {
    public function changeState( p_id : String ) : Void {
        var state : State = this.states.get( p_id );
        if( this.curState != null ) {
            if( this.curState.id == p_id ) {
                return;
            }
            this.curState.dispose();
        }

        // trace( "changeState: id: " + p_id );
        this.curState = state;
        this.curState.owner = this.owner;
        this.curState.start();
    }
	
    public function registerState( state : State ) : Void {
        Helper.assert( !states.exists( state.id ), "state: " + state.id + " already existed" );
        state.owner = this.owner;
        state.init();
        states.set( state.id, state );
    }

    override function update_( dt : Float ) : Void {
        super.update_( dt );

        if( this.curState != null ) {
            this.curState.update_( dt );
        }
    }
}
