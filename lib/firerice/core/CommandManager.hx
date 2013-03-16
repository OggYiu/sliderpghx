package firerice.core;
import nme.ui.Keyboard;
import nme.utils.Timer;
import nme.events.KeyboardEvent;
import nme.display.Stage;
import nme.Lib;
class CommandManager extends Process {
    static var LIMIT : Int = 5;
	public static var EMPTY : Int = 0;
    var commands( null, null ) : Hash<Command> = null;
    public var keymap( default, null ) : Hash<Bool> = null;
    public var keyHistory( default, null ) : Array<Int> = null;
    public var keyTimeHistory( default, null ) : Array<Float> = null;
    var lastKeyPressedTime( default, null ) : Float = 0;
	var keyRecorded( default, null ) : Bool = false;

    public function new() {
        super( "commandManager" );

        this.commands = new Hash<Command>();
        this.keymap = new Hash<Bool>();
        this.keyHistory = new Array<Int>();
        this.keyTimeHistory = new Array<Float>();
		this.keyRecorded = false;

        Lib.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        Lib.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

        // test
        addCommand( new Command( "ballget", [Keyboard.DOWN, Keyboard.RIGHT, Keyboard.SPACE], 0.5 ) );
        addCommand( new Command( "runRight", [Keyboard.RIGHT, Keyboard.RIGHT], 0.3 ) );
        addCommand( new Command( "runLeft", [Keyboard.LEFT, Keyboard.LEFT], 0.3 ) );
    }

    public function addCommand( command : Command ) : Void {
        this.commands.set( command.id, command );
    }

    function onKeyDown(event:KeyboardEvent) : Void {
        keymap.set( event.keyCode + "", true );
        if( this.keyHistory.length <= 0 ) {
            lastKeyPressedTime = haxe.Timer.stamp();
        }

		this.keyRecorded = true;
		
        this.keyHistory.push( event.keyCode );
        var curTime : Float = haxe.Timer.stamp();
        //trace( "curTime: " + curTime + ", lastKeyPressedTime: " + lastKeyPressedTime + ", " + ( curTime - lastKeyPressedTime ) );
        this.keyTimeHistory.push( curTime - lastKeyPressedTime );
        lastKeyPressedTime = curTime;

        updateCommandList();
    }

    function onKeyUp(event:KeyboardEvent) : Void {
        keymap.set( event.keyCode + "", false );
    }

    override function update_( dt : Float ) : Void {
        if( this.keyHistory.length > LIMIT ) {
            this.keyHistory = this.keyHistory.splice( 1, this.keyHistory.length - 1 );
            this.keyTimeHistory = this.keyTimeHistory.splice( 1, this.keyTimeHistory.length - 1 );
        }
		
		if ( !this.keyRecorded ) {
			if ( this.keyHistory.length > 0 ) {
				if ( this.keyHistory[this.keyHistory.length - 1] != EMPTY ) {
					this.keyHistory.push( EMPTY );
					var curTime : Float = haxe.Timer.stamp();
					this.keyTimeHistory.push( curTime - lastKeyPressedTime );
					lastKeyPressedTime = curTime;
				}
			}
		}
		this.keyRecorded = false;
		
//        trace( "this.keyHistory: " + this.keyHistory );
//        trace( "this.keyTimeHistory: " + this.keyTimeHistory );
//        trace( "" );
    }

    function updateCommandList() : Void {
        for( command in commands ) {
            command.test( this.keyHistory, this.keyTimeHistory );

            // testing
//            trace( "command.ready: " + command.ready );
            // if( command.ready ) {
                // trace( command.id + " is ready" );
            // }
        }
    }

    static var s_canInit_ : Bool = false;
    static var s_instance_ : CommandManager = null;
    public static function getInstance() : CommandManager {
        if ( s_instance_ == null ) {
            s_canInit_ = true;
            s_instance_ = new CommandManager();
            s_canInit_ = false;
        }

        return s_instance_;
    }

}
