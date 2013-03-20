package game;

import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2ContactImpulse;
import box2D.collision.B2Manifold;
import game.entity.GameEntity;

class ContactListener extends B2ContactListener {	
	public function new () {
		super();
	}
	
	
	/**
	 * Called when two fixtures begin to touch.
	 */
	override public function beginContact(contact:B2Contact):Void {
		var entityA : GameEntity = contact.getFixtureA().getBody().getUserData();
		var entityB : GameEntity = contact.getFixtureB().getBody().getUserData();
		entityA.beginContactHandler( entityB );
		entityB.beginContactHandler( entityA );

		// if( Settings.SHOW_CONTACT_INFO )
		// {
		// 	trace( "\n" );
		// 	trace( "beginContact" );
		// 	trace( "entityA: " + entityA.gameEntityType + ", " + entityA.id );
		// 	trace( "entityB: " + entityB.gameEntityType + ", " + entityB.id );
		// }
	}

	/**
	 * Called when two fixtures cease to touch.
	 */
	override public function endContact(contact:B2Contact):Void {
		var entityA : GameEntity = contact.getFixtureA().getBody().getUserData();
		var entityB : GameEntity = contact.getFixtureB().getBody().getUserData();
		entityA.endContactHandler( entityB );
		entityB.endContactHandler( entityA );
	}

	/**
	 * This is called after a contact is updated. This allows you to inspect a
	 * contact before it goes to the solver. If you are careful, you can modify the
	 * contact manifold (e.g. disable contact).
	 * A copy of the old manifold is provided so that you can detect changes.
	 * Note: this is called only for awake bodies.
	 * Note: this is called even when the number of contact points is zero.
	 * Note: this is not called for sensors.
	 * Note: if you set the number of contact points to zero, you will not
	 * get an EndContact callback. However, you may get a BeginContact callback
	 * the next step.
	 */
	override public function preSolve(contact:B2Contact, oldManifold:B2Manifold):Void {
		trace( "preSolve" );
	}

	/**
	 * This lets you inspect a contact after the solver is finished. This is useful
	 * for inspecting impulses.
	 * Note: the contact manifold does not include time of impact impulses, which can be
	 * arbitrarily large if the sub-step is small. Hence the impulse is provided explicitly
	 * in a separate data structure.
	 * Note: this is only called for contacts that are touching, solid, and awake.
	 */
	override public function postSolve(contact:B2Contact, impulse:B2ContactImpulse):Void {
		trace( "postSolve" );
	}

}