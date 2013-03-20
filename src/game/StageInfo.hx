package game;

import firerice.common.E4X;
import nme.Assets;
import game.entity.EntityCNS;

class StageInfo {
	public var entitiesInfo : Array<EntityCNS> = null;
	var level : Int = 0;
	public function new() {
		// Settings.ROW_COUNT * Settings.COLUMN_COUNT

		// testing
	}

	public function read( xmlPath : String ) {
		this.entitiesInfo = new Array<EntityCNS>();

		var xml : Xml = Xml.parse( Assets.getText( xmlPath ) );
		
		// var nodes:Iterator<Xml> = E4X.x(xml.child("data"));

		// trace( "haha" );
		var nodes : Iterator<Xml>;
		nodes = E4X.x( xml.child( "level" ) );
		// var nodes : Iterator<Xml> = E4X.x( xml.child() );
		// trace( nodes.next().firstChild().nodeValue );	
		this.level = Std.parseInt( nodes.next().firstChild().nodeValue );
		
		nodes = E4X.x( xml.child( "data" ).child( "grid" ) );
		trace( nodes );
		var element : Xml;
		// trace( element = nodes.next() );
		while( ( element = nodes.next() ) != null ) {
			// trace( element.nodeName );
			trace( element.get( "id" ) );
		}
		// var element : Xml;
		// while( ( element = nodes.next() ) != null ) {
		// 	trace( element.nodeName );
		// 	trace( element.firstChild().nodeValue );
		// 	// trace( element.nodeValue );
		// }
		// var element : Xml;
		// while( ( element = nodes.next() ) != null ) {
		// 	if( element.nodeType == Xml.PCData ) {
		// 	}
		// 	else if( element.nodeType == Xml.Element ) {
		// 		switch( element.nodeName ) {
		// 			case "level":
		// 			case "data": {
		// 				trace( element );
		// 			}
		// 		}
		// 	}
		// }
	}
}