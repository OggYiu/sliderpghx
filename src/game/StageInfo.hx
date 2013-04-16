package game;

import firerice.common.E4X;
import nme.Assets;
import game.entity.EntityCNS;
import game.entity.ActorCNS;
import game.entity.ItemCNS;
import game.entity.ActorSettings;
import game.entity.ItemSettings;
import types.EItem;

class StageInfo {
	public var entitiesInfo : Array<EntityCNS> = null;
	var level : Int = 0;
	public function new() {
		// Settings.ROW_COUNT * Settings.COLUMN_COUNT

		// testing
	}

	public function read( xmlPath : String ) {
		this.entitiesInfo = new Array<EntityCNS>();
		test();
	}

	function test() {
		// var xml : Xml = Xml.parse( Assets.getText( xmlPath ) );
		
		// var nodes : Iterator<Xml>;
		// nodes = E4X.x( xml.child( "level" ) );
		// this.level = Std.parseInt( nodes.next().firstChild().nodeValue );
		
		// nodes = E4X.x( xml.child( "data" ).child( "grid" ) );
		// trace( nodes );
		// var element : Xml;
		// while( ( element = nodes.next() ) != null ) {
		// 	trace( element.get( "id" ) );
		// }

		var actorCNS : ActorCNS;
		var itemCNS : ItemCNS;

		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}

		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}

		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}
		
		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}

		{
			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.redSlime, 2 );
			this.entitiesInfo.push( actorCNS );
			
			this.entitiesInfo.push( null );

			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.greenSlime, 1 );
			this.entitiesInfo.push( actorCNS );

			this.entitiesInfo.push( null );

			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.blueSlime, 1 );
			this.entitiesInfo.push( actorCNS );
		}


		{
			this.entitiesInfo.push( null );
		
			itemCNS = ItemSettings.createItemCNS( EItem.shield, 1 );
			this.entitiesInfo.push( itemCNS );

			this.entitiesInfo.push( null );

			itemCNS = ItemSettings.createItemCNS( EItem.weapon, 1 );
			this.entitiesInfo.push( itemCNS );

			this.entitiesInfo.push( null );
		}

		{
			itemCNS = ItemSettings.createItemCNS( EItem.potion, 1 );
			this.entitiesInfo.push( itemCNS );

			this.entitiesInfo.push( null );

			itemCNS = ItemSettings.createItemCNS( EItem.potion, 1 );
			this.entitiesInfo.push( itemCNS );

			this.entitiesInfo.push( null );

			itemCNS = ItemSettings.createItemCNS( EItem.potion, 1 );
			this.entitiesInfo.push( itemCNS );
		}

		{
			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.redSlime, 2 );
			this.entitiesInfo.push( actorCNS );
			
			this.entitiesInfo.push( null );

			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.redSlime, 1 );
			this.entitiesInfo.push( actorCNS );

			this.entitiesInfo.push( null );

			itemCNS = ItemSettings.createItemCNS( EItem.shield, 1 );
			this.entitiesInfo.push( itemCNS );
		}

		{
			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.blueSlime, 1 );
			this.entitiesInfo.push( actorCNS );
			
			this.entitiesInfo.push( null );

			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.blueSlime, 2 );
			this.entitiesInfo.push( actorCNS );

			this.entitiesInfo.push( null );

			itemCNS = ItemSettings.createItemCNS( EItem.weapon, 1 );
			this.entitiesInfo.push( itemCNS );
		}

		{
			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.greenSlime, 2 );
			this.entitiesInfo.push( actorCNS );
			
			this.entitiesInfo.push( null );

			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.greenSlime, 1 );
			this.entitiesInfo.push( actorCNS );

			this.entitiesInfo.push( null );

			itemCNS = ItemSettings.createItemCNS( EItem.potion, 1 );
			this.entitiesInfo.push( itemCNS );
		}

		{
			this.entitiesInfo.push( null );

			this.entitiesInfo.push( null );

			this.entitiesInfo.push( null );

			this.entitiesInfo.push( null );

			this.entitiesInfo.push( null );
		}

		{
			this.entitiesInfo.push( null );

			this.entitiesInfo.push( null );

			actorCNS = ActorSettings.getInstance().createActorCNS( types.EGameEntity.monster, types.EActor.greenSlime, 1 );
			this.entitiesInfo.push( actorCNS );

			this.entitiesInfo.push( null );

			this.entitiesInfo.push( null );
		}
		
		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}

		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}

		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}

		{
			for( i in 0 ... 5 ) {
				this.entitiesInfo.push( null );
			}
		}
		
		{
			this.entitiesInfo.push( null );
		}
    // int mapData[][3] = {
    //     {MO, CH_RED, 1} , {EM}          ,{IT, IT_POT}   ,{MO, CH_RED, 2}, {MO, CH_BLU, 1}   , {MO, CH_GRE, 2}   ,   {EM},       {EM}            ,
    //     {NP, NP_PRI}    , {IT, IT_SHI}  ,{EM}           ,{EM}           , {EM}              , {EM}              ,   {EM},       {EM}            ,
    //     {MO, CH_GRE, 1} , {EM}          ,{IT, IT_POT}   ,{MO, CH_RED, 1}, {MO, CH_BLU, 2}   , {MO, CH_GRE, 1}   ,   {EM},       {BO, CH_BOS, 3} ,
    //     {NP, NP_INN}    , {IT, IT_WEA}  ,{EM}           ,{EM}           , {EM}              , {EM}              ,   {EM},       {EM}            ,
    //     {MO, CH_BLU, 1} , {EM}          ,{IT, IT_POT}   ,{IT, IT_SHI}   , {IT, IT_WEA}      , {IT, IT_POT}      ,   {EM},       {EM}            ,
    // };


		// fill the rest missing entitiesInfo
		var appendCount : Int = 0;
		appendCount = this.entitiesInfo.length % Settings.ROW_COUNT;
		for( i in 0 ... appendCount ) {
			this.entitiesInfo.push( null );
		}

		trace( "len: " + this.entitiesInfo.length );
	}
}