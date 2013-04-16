package game.entity;

import firerice.components.AnimationComponent;
import types.EGameEntity;
import types.EActor;
import types.EActorState;
import game.entity.ActorCNS;

class Monster extends Actor {
	public function new( p_id : String, p_parent : Dynamic, p_actorCNS : ActorCNS ) {
		super( p_id, p_parent, EGameEntity.monster, p_actorCNS );
		
		this.sensor = game.Global.getInstance().sceneGame.createSensor( this, Settings.GRID_SIZE - 1, Settings.GRID_SIZE - 1 );
        
		this.changeState( EActorState.idle );
	}
}