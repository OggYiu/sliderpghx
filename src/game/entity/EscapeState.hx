package game.entity;

import firerice.core.Process;
import types.EActorState;
import com.eclecticdesignstudio.motion.Actuate;
import com.eclecticdesignstudio.motion.easing.Linear;

class EscapeState extends ActorState {
	public var targetX( default, null ) : Float = 0;
	public function new( p_owner : Actor ) {
		super( p_owner, EActorState.escape );

		// this.owner.transform.x -= 20;
		this.targetX = this.owner.transform.x - Settings.GRID_SIZE;
	}

	override public function beginState() : Void {
		super.beginState();
		// this.owner.transform.x -= 20;

		// Actuate.tween(	this.owner.transform,
		// 				1,
		// 				{ x : this.owner.transform.x - 20 } ).onComplete(	function() {
		// 																		this.owner.changeState( EActorState.walk );
		// 																	} );
	}

	override public function endState() : Void {
		super.endState();
	}

	override function update_( dt : Float ) : Void {
		super.update_( dt );

		this.owner.transform.x -= dt * 200;
		if( this.owner.transform.x <= this.targetX ) {
			this.owner.changeState( EActorState.walk );
		}
	}
}