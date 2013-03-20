package game.entity;

import firerice.core.Process;
import types.EActorState;
import com.eclecticdesignstudio.motion.Actuate;

class InstanceTriggerState extends ActorState {
	public function new( p_owner : Actor ) {
		super( p_owner, EActorState.instanceTrigger );
	}

	override public function beginState() : Void {
		super.beginState();

		Actuate.timer(1).onComplete(	function() {
											this.owner.changeState( EActorState.walk );
										} );
	}

	override public function endState() : Void {
		super.endState();
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );
	}
}