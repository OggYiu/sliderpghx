package game.entity;

class NPC extends Actor {
	public var npcCns( default, null ) : NPCCNS = null;

	public function new( p_id : String, p_parent : Dynamic, animPath : String, p_actorType : EActor ) {
		super( p_id, p_parent, EGameEntity.npc, p_actorType );
		
	}
}