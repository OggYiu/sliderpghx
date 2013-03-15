package firerice.components;
import firerice.core.triggers.TriggerKeyPress;
import firerice.types.EDirection;
import firerice.core.triggers.TriggerDirection;
import nme.ui.Keyboard;
import firerice.core.InputManager;
import firerice.core.Entity;
import nme.events.KeyboardEvent;
import nme.Lib;

/**
 * ...
 * @author oggyiu
 */

class CommandComponent extends Component
{
	public static var ID : String = "commandComponent.ID";
//    var commands( default, default ) : Array<Command> = null;
    var filePath( default, null ) : String = null;

	public function new( p_owner : Entity, p_filePath : String )
	{
		super( CommandComponent.ID, p_owner );
        p_filePath = filePath;
	}

    override function init_() : Void {
//        this.commands = new Array<Command>();
        //this.commands.push( new Command( this.owner , new TriggerKeyPress( null ), "idle" ) );
        //this.commands.push( new Command( this.owner , new TriggerKeyPress( [Keyboard.RIGHT] ), "walk" ) );
//        this.commands.push( new Command( this.owner , new TriggerKeyPress( [] ), "attack" ) );

//        this.commands.push( new Command( this.owner , [Keyboard.RIGHT], "walkRight" ) );
//        this.commands.push( new Command( this.owner , [Keyboard.LEFT], "walkLeft" ) );
//        this.commands.push( new Command( this.owner , [Keyboard.UP], "walkUp" ) );
//        this.commands.push( new Command( this.owner , [Keyboard.DOWN], "walkDown" ) );
//
//        this.commands.push( new Command( this.owner , [Keyboard.RIGHT, Keyboard.DOWN], "walkRightDown" ) );
//        this.commands.push( new Command( this.owner , [Keyboard.RIGHT, Keyboard.UP], "walkRightUp" ) );
//        this.commands.push( new Command( this.owner , [Keyboard.LEFT, Keyboard.DOWN], "walkLeftDown" ) );
//        this.commands.push( new Command( this.owner , [Keyboard.LEFT, Keyboard.UP], "walkLeftUp" ) );
    }

    override function update_( dt : Float ) : Void {
        super.update_( dt );

//        for( command in this.commands ) {
//            if( command.canTrigger() ) {
//                command.start();
//            }
//        }
    }
}