package game;

class Settings {
	public inline static var GRID_SIZE : Int = 100;
	public static var SCREEN_WIDTH : Int = 0;
	public static var SCREEN_HEIGHT : Int = 0;
	// public inline static var GAME_WIDTH : Int = 480;
	// public inline static var GAME_HEIGHT : Int = 250;
	public inline static var GAME_WIDTH : Int = 960;
	public inline static var GAME_HEIGHT : Int = 500;
	public inline static var ROW_COUNT : Int = Math.ceil( Settings.GAME_HEIGHT / Settings.GRID_SIZE );
	public inline static var COLUMN_COUNT : Int = Math.ceil( Settings.GAME_WIDTH / Settings.GRID_SIZE );
	public inline static var GAME_WORLD_X : Int = 0;
	public inline static var GAME_WORLD_Y : Int = 140;
	public inline static var PLAY_BG_MUSIC : Bool = false;
	public inline static inline var MOTIONWELDER_PATH : String = "assets/motionwelder/";
	public inline static var ITEM_IMAGE_PATH : String ="assets/img/item/";
	public inline static var PLAYER_WALK_SPEED : Float = 60;
	// public inline static var PLAYER_WALK_SPEED : Float = 0;
	public inline static var COLUMN_SCROLL_SPEED : Float = 20;
	// public static var SHOW_CONTACT_INFO : Bool = false;
	
	public static function log() : Void {
		trace( "GRID_SIZE: " + GRID_SIZE );
		trace( "SCREEN_WIDTH: " + SCREEN_WIDTH );
		trace( "SCREEN_HEIGHT: " + SCREEN_HEIGHT );
		trace( "GAME_WIDTH: " + GAME_WIDTH );
		trace( "GAME_HEIGHT: " + GAME_HEIGHT );
		trace( "ROW_COUNT: " + ROW_COUNT );
		trace( "COLUMN_COUNT: " + COLUMN_COUNT );
	}
}