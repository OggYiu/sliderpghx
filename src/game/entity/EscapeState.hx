package game.entity;

import firerice.core.Process;
import types.EActorState;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;

class EscapeState extends ActorState {
	public function new( p_owner : Actor ) {
		super( p_owner, EActorState.escape );
	}

	override public function beginState() : Void {
		super.beginState();


		// Actuate.tween( this.context, 2, { alpha: 0 } ).onComplete( completeHandler );
		Actuate.tween(	this.owner.transform,
						1,
						{ x : this.owner.transform.x - 20 } ).onComplete(	function() {
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