package firerice.common;
import firerice.core.Process;
import firerice.core.Entity;
import firerice.interfaces.IDisplayable;
import firerice.types.EDirection;
import nme.display.Sprite;
import nme.geom.Point;
import game.entities.GameEntity;
import game.entities.Water;
import game.entities.House;
import game.entities.Ground;
import game.Projectile;
import game.types.EGameEntity;

class CollisionManager extends Process, implements IDisplayable {
	public var collisionBoxes( default, null ) : Array<CollisionBox> = null;
	public var context( default, null ) : Sprite;
	public var target( default, default ) : Dynamic = null;
	public var handler( default, default ) : CollisionBox -> CollisionBox -> Void = null;

	var lastSize_ : Int = 0;

	public function new() {
		super( "collisionManager" );
		collisionBoxes = new Array<CollisionBox>();
		context = new Sprite();
		target = null;
		handler = null;
	}

	public function addCollisionBox( collisionBox : CollisionBox ) : Void {
		collisionBoxes.push( collisionBox );
	}

	public function removeCollisionBox( p_owner : GameEntity ) : Void {
		var index : Int = 0;
		var box : CollisionBox;
		while( index < collisionBoxes.length ) {
			box = collisionBoxes[index];
			if( box.owner == p_owner ) {
				collisionBoxes.remove( box );
				--index;
			}

			++index;
		}

		// collisionBoxs.push( collisionBox );
	}

	public function reset() : Void {
		this.target = null;
		this.handler = null;
		collisionBoxes.splice( 0, collisionBoxes.length );
	}

	override function update_( dt : Float ) : Void {
		// if( lastSize_ != collisionBoxes.length ) {
			// trace( "hello!!!" ) ;
			lastSize_ = collisionBoxes.length;

			// var cameraPos : Point = Global.getInstance().cameraPos;
			// trace( "cameraPos: " + cameraPos );
			var cameraPos : Point = new Point( 0, 0 );
			this.context.graphics.clear();
			this.context.graphics.lineStyle( 3, 0xFF0000 );
			for( box in collisionBoxes ) {
				if( box.isDead ) {
					continue;
				}
				// trace( "box: " + box );
				this.context.graphics.moveTo(	box.rect.x - cameraPos.x,
												box.rect.y - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x + box.rect.width - cameraPos.x,
												box.rect.y - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x + box.rect.width - cameraPos.x,
												box.rect.y + box.rect.height - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x - cameraPos.x,
												box.rect.y + box.rect.height - cameraPos.y );
				this.context.graphics.lineTo(	box.rect.x - cameraPos.x,
												box.rect.y - cameraPos.y );
			}
		// }

		for( boxA in collisionBoxes ) {
			for( boxB in collisionBoxes ) {
				if( boxA == boxB ) {
					continue;
				}
				if( boxA.isDead || boxB.isDead ) {
					continue;
				}
				if( boxA.owner == boxB.owner ) {
					continue;
				}
				if( boxA.owner.gameEntityType != EGameEntity.projectile &&
					boxB.owner.gameEntityType != EGameEntity.projectile ) {
					continue;
				}
				if( boxA.owner.gameEntityType == EGameEntity.projectile &&
					boxB.owner.gameEntityType == EGameEntity.projectile ) {
					continue;
				}
				// if( boxA.owner.gameEntityType == EGameEntity.ground ||
				// 	boxB.owner.gameEntityType == EGameEntity.ground ) {
				// 	continue;
				// }

				if( boxA.owner.gameEntityType == EGameEntity.projectile ) {
					var projectile : Projectile = cast( boxA.owner, Projectile );
					if( projectile.shooter == boxB.owner ) {
						continue;
					}
				}
				if( boxB.owner.gameEntityType == EGameEntity.projectile ) {
					var projectile : Projectile = cast( boxB.owner, Projectile );
					if( projectile.shooter == boxA.owner ) {
						continue;
					}
				}

				// if( boxA.owner != null &&
				// 	boxB.owner != null ) {
				// 	if(	boxA.owner.isEnemy &&
				// 		boxB.owner.isEnemy ) {
				// 		continue;
				// 	}
				// }

				if( hitTest(	boxA.rect.x, boxA.rect.y, boxA.rect.width, boxA.rect.height,
								boxB.rect.x, boxB.rect.y, boxB.rect.width, boxB.rect.height ) ) {
					// if( target != null && handler != null ) {
					// 	if( boxA.owner != null &&
					// 	boxB.owner != null ) {
					// 		if(	boxA.owner.playerType == ActorEntityType.victim ||
					// 			boxB.owner.playerType == ActorEntityType.victim ) {
					// 			if( Global.getInstance().sceneGame != null ) {
					// 				// trace( "gameWon" );
					// 				Global.getInstance().sceneGame.gameWon = true;
					// 			}
					// 		}
						// }

					// Reflect.callMethod( target, handler, [ boxA, boxB ] );
					// trace( boxA.owner.id + " touched " + boxB.owner.id );
					if( !( boxA.owner.isDead || boxB.owner.isDead ) ) {
						// if( Std.is( boxA.owner, Projectile ) || Std.is( boxB.owner, Projectile ) ) {
							// trace( "projectile collided!" );
							// boxA.owner.trigger();
							// box
						// }

						var targetGameEntity : GameEntity = null;
						var targetGameEntityBox : CollisionBox = null;
						var projectile : Projectile = null;
						var projectileBox : CollisionBox = null;

						if( boxA.owner.gameEntityType == EGameEntity.projectile ) {
							targetGameEntity = boxB.owner;
							targetGameEntityBox = boxB;
							projectileBox = boxA;
							projectile = cast( boxA.owner, Projectile );
						}
						if( boxB.owner.gameEntityType == EGameEntity.projectile ) {
							targetGameEntity = boxA.owner;
							targetGameEntityBox = boxA;
							projectileBox = boxB;
							projectile = cast( boxB.owner, Projectile );
						}

						Helper.assert( targetGameEntity != null, "invalid target game entity" );
						
						if( Std.is( targetGameEntity, Water ) ) {
							// trace( "break water from here" );
							// trace( "boxA: " + boxA );
							// trace( "boxB: " + boxB );
							// if( Point.distance( targetGameEntity.transform, projectile.transform ) <= 10 ) {
								var water : Water = cast( targetGameEntity, Water );
								water.trigger();
								if( water.isDead ) {
									targetGameEntityBox.isDead = true;
								}
								projectileBox.isDead = true;
								projectile.isDead = true;	
							// }
						} else if( Std.is( targetGameEntity, House ) ) {
							var house : House = cast( targetGameEntity, House );
							if( projectile.velocity.x > 0 && Helper.isZero( projectile.velocity.y ) ) {
								house.buildHouseDirection = EDirection.east;
							} else if( projectile.velocity.x < 0 && Helper.isZero( projectile.velocity.y ) ) {
								house.buildHouseDirection = EDirection.west;
							} else if( Helper.isZero( projectile.velocity.x ) && projectile.velocity.y > 0 ) {
								house.buildHouseDirection = EDirection.sourth;
							} else if( Helper.isZero( projectile.velocity.x ) && projectile.velocity.y < 0 ) {
								house.buildHouseDirection = EDirection.north;
							} else {
								trace( "unhandled case: " + projectile.velocity );
							}
							projectileBox.isDead = true;
							projectile.isDead = true;	
							house.trigger();
						} else if( Std.is( targetGameEntity, Ground ) ) {
							var ground : Ground = cast( targetGameEntity, Ground );
							// if( !ground.isProjectilePassBY( projectile ) && ground.onTop == null ) {
							// 	ground.addProjectilePassBY( projectile );
							// 	ground.buildFlower( 1 );
							// }
						} else {
							trace( "unhandled case: " + targetGameEntity );
						}
					}
				}
			}
		}

		{
			var index : Int = 0;
			var box : CollisionBox = null;
			while( index < this.collisionBoxes.length ) {
				box = this.collisionBoxes[index];
				if( box.isDead || box.owner.isDead ) {
					this.collisionBoxes.remove( box );
					--index;
				}

				++index;
			}
		}
	}

	// function hitTest( boxA : CollisionBox, boxB : CollisionBox ) : Bool {
 //  		return !(	( boxA.rect.x ) > ( boxB.rect.x + boxB.rect.width ) || 
	// 	           	( boxA.rect.x + boxA.rect.width ) < boxB.rect.x || 
	// 	           	( boxA.rect.y ) > ( boxB.rect.y + boxB.rect.height ) ||
	// 	           	( boxA.rect.y + boxA.rect.height ) < ( boxB.rect.y ));
	// }
	function hitTest( x_1 : Float, y_1 : Float, width_1 : Float, height_1 : Float, x_2 : Float, y_2 : Float, width_2 : Float, height_2 : Float ) : Bool {
		// return !(x_1 > x_2+width_2 || x_1+width_1 < x_2 || y_1 > y_2+height_2 || y_1+height_1 < y_2);
		return !(x_1 >= x_2+width_2 || x_1+width_1 <= x_2 || y_1 >= y_2+height_2 || y_1+height_1 <= y_2);
	}

    public function clickHandler( x : Float, y : Float ) : Void {
//        trace( "click handler, x: " + x + ", y: " + y );
        for( boxA in collisionBoxes ) {
            // trace( "boxA: " + boxA.rect );
//            for( boxB in collisionBoxes ) {

//                if( boxA == boxB ) {
//                    continue;
//                }
//                if( boxA.dead || boxB.dead ) {
//                    continue;
//                }
//                if( boxA.owner == boxB.owner ) {
//                    continue;
//                }


            if( hitTest(	boxA.rect.x, boxA.rect.y, boxA.rect.width, boxA.rect.height,
                            x, y, 1, 1 ) ) {
                if( boxA.owner != null  && Std.is( boxA.owner, Ground ) ) {
                	var ground : Ground = cast( boxA.owner, Ground );
                	if( ground.onTop == null || Std.is( ground.onTop, Water ) ) {
                   		boxA.owner.trigger();
                   	}
                }
                break;
            }
        }
    }

	static var s_canInit_ : Bool = false;
	static var s_instance_ : CollisionManager = null;
	public static function getInstance() : CollisionManager {
		if ( s_instance_ == null ) {
			s_canInit_ = true;
			s_instance_ = new CollisionManager();
			s_canInit_ = false;
		}

		return s_instance_;
	}
}