package game;

class Settings {
	public static var GRID_SIZE : Int = 50;
	public static var SCREEN_WIDTH : Int = 0;
	public static var SCREEN_HEIGHT : Int = 0;
	public static var GAME_WIDTH : Int = 480;
	public static var GAME_HEIGHT : Int = 250;
	public static var ROW_COUNT : Int = 0;
	public static var COLUMN_COUNT : Int = 0;
	public static var GAME_WORLD_X : Int = 0;
	public static var GAME_WORLD_Y : Int = 50;
	public static var PLAY_BG_MUSIC : Bool = false;
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