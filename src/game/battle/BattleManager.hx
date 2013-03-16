package game.battle;

import firerice.core.Process;
import firerice.common.Helper;
import game.GameEntity;

class BattleManager extends Process {
  var battles : Hash<Battle> = null;

	public function new() {
		super( "battleManager" );

    this.battles = new Hash<Battle>();
	}

   	public function beginBattle( p_actor1 : Actor, p_actor2 : Actor ) : Battle {
     var battleKey : String = p_actor1.id + "_vs_" + p_actor2.id;
      Helper.assert( !this.battles.exists( battleKey), "battle " + battleKey + " already existed!" );
      var battle : Battle = new Battle( battleKey, p_actor1, p_actor2 );
      this.battles.set( battle.id, battle );
      return battle;
   	}

   	public function endBattle( battle : Battle ) : Void {
   		// trace( "endBattle endBattle endBattle" );
   	}

   	override function update_( dt : Float ) : Void {
   		super.update_( dt );

      for( battle in this.battles ) {
        battle.update( dt );
      }

      for( battle in this.battles ) {
        if( battle.isEnded ) {
          battle.dispose();
          this.battles.remove( battle.id );
        }
      }
   	}

    static var s_canInit_ : Bool = false;
    static var s_instance_ : BattleManager = null;
    public static function getInstance() : BattleManager {
        if ( s_instance_ == null ) {
            s_canInit_ = true;
            s_instance_ = new BattleManager();
            s_canInit_ = false;
        }

        return s_instance_;
    }
}