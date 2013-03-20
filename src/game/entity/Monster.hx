package game.entity;

import firerice.components.AnimationComponent;
import types.EGameEntity;
import types.EActor;
import types.EActorState;

class Monster extends Actor {
	public function new( p_id : String, p_parent : Dynamic, animPath : String ) {
		super( p_id, p_parent, EGameEntity.monster, EActor.redSlime );

		this.sensor = game.Global.getInstance().sceneGame.createSensor( this, Settings.GRID_SIZE - 1, Settings.GRID_SIZE - 1 );

		// this.gameEntityType = EGameEntity.monster;
        this.addComponent( new AnimationComponent( this, animPath ) );
        
		this.changeState( EActorState.idle );
	}
}