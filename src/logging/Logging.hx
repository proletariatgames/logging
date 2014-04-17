package logging;

#if haxe3
import haxe.CallStack;
#end
import haxe.PosInfos;

class Logging
{
    public static var manager:Manager;

    // static function __init__()
    // {
    //     var logger = getLogger("");
    //     logger.addHandler(new logging.handlers.StreamHandler());
    // }
    static inline function checkStack(stack:Array<StackItem>) : Array<StackItem> {
        if (stack == null) {
            stack = haxe.CallStack.callStack();
            stack.shift();
        }
        return stack;
    }

    static public inline function info(message:String, arguments:Dynamic=null,
                                       ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        log(Level.INFO, message, arguments, checkStack(stack), pos);
    }

    static public inline function debug(message:String, arguments:Dynamic=null,
                                        ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        log(Level.DEBUG, message, arguments, checkStack(stack), pos);
    }

    static public inline function warning(message:String, arguments:Dynamic=null,
                                          ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        log(Level.WARNING, message, arguments, checkStack(stack), pos);
    }

    static public inline function warn(message:String, arguments:Dynamic=null,
                                       ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        log(Level.WARNING, message, arguments, checkStack(stack), pos);
    }

    static public inline function error(message:String, arguments:Dynamic=null,
                                        ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        log(Level.ERROR, message, arguments, checkStack(stack), pos);
    }

    static public inline function critical(message:String, arguments:Dynamic=null,
                                           ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        log(Level.CRITICAL, message, arguments, checkStack(stack), pos);
    }

    @:keep
    static public inline function fatal(message:String, arguments:Dynamic=null,
                                        ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        log(Level.CRITICAL, message, arguments, checkStack(stack), pos);
    }

    static public inline function log(level:Int, message:String, arguments:Dynamic=null,
                                      ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).log(level, message, arguments, checkStack(stack), pos);
    }

    static public function getLogger(name:String):ILogger
    {
        if (null == Logger.root)
            Logger.root = new RootLogger(0);
        if (null == Logging.manager) {
            Logging.manager = new Manager(Logger.root);
            Logger.root.manager = Logging.manager;
        }

        var logger:ILogger;
        if (null == name || "" == name)
            logger = manager.root;
        else
            logger = manager.getLogger(name);

        return logger;
    }
}