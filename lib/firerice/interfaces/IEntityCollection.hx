package firerice.interfaces;

import firerice.core.Entity;
import nme.display.Sprite;

/**
 * ...
 * @author oggyiu
 */

interface IEntityCollection
{
	var entities( default, null ) : Hash<Entity>;
	
	function addChild( entity : Entity ) : Void;
	function removeChild( entity : Entity ) : Void;
//}
//
//class CEntityCollection {
	//public static function setAddChild( entityCollection : IEntityCollection ) : Void {
		//var addChildFunc : Entity -> Void;
		//function f( entity : Entity ) : Void { trace( "CEntityCollection addChild" ); }
		//addChildFunc = f;
		//Reflect.setProperty( entityCollection, "addChild", addChildFunc );
	//}
	//function f( entity : Entity ) : Void { }
}