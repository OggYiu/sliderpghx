package firerice.core;
class Command {
    public var id( default, null ) : String = "";
    public var keys( default, null ) : Array<Int> = null;
    public var time( default, null ) : Float = -1;
    public var ready( default, null ) : Bool = false;

    public function new( p_id : String, p_keys : Array<Int>, p_time : Float ) {
        this.id = p_id;
        this.keys = p_keys;
        this.time = p_time;
    }

    public function test( p_keyCodeHistory : Array<Int>,
                          p_keyTimeHistory : Array<Float> ) : Bool {

        this.ready = false;

        if( this.keys.length > p_keyCodeHistory.length ) {
//            this.ready = false;
            return false;
        }

        var commandIndex : Int = this.keys.length - 1;
        var keyHistoryIndex : Int = p_keyCodeHistory.length - 1;
        var timeHistoryIndex : Int = p_keyTimeHistory.length;
        var totalTime : Float = 0;
        var lastCorrectKey : Int = -1;

//        trace( "." );
//        trace( "start test, id: " + this.id );
//        trace( "this.keys: " + this.keys );
//        trace( "p_keyCodeHistory: " + p_keyCodeHistory );
//        trace( "time: " + this.time );
//        trace( "p_keyTimeHistory: " + p_keyTimeHistory );
        while( commandIndex >= 0 ) {
//            trace( "test 1" );
            if( this.keys[commandIndex] != p_keyCodeHistory[keyHistoryIndex] ) {
//                trace( "test 2" );
                if( lastCorrectKey < 0 ) {
//                    trace( "test 3" );
                    return false;
                }

                if( p_keyCodeHistory[keyHistoryIndex] != lastCorrectKey ) {
//                    trace( "test 4" );
                    return false;
                }
            }

            if( this.time >= 0 ) {
                if( timeHistoryIndex < p_keyTimeHistory.length ) {
                    totalTime += p_keyTimeHistory[timeHistoryIndex];
                    // trace( "test 5a, totalTime : " + totalTime  );
                    if( totalTime > time ) {
                        // trace( "test 5b" );
                        return false;
                    }
                }
            }

//            trace( "test 6" );
            lastCorrectKey = this.keys[commandIndex];
            --commandIndex;
            --keyHistoryIndex;
            --timeHistoryIndex;
        }

//        trace( "test 7" );
        this.ready = true;
        return true;
    }
}
