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

    static public function info(message:String, arguments:Dynamic=null,
                                ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).info(message, arguments, stack, pos);
    }

    static public function debug(message:String, arguments:Dynamic=null,
                                 ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).debug(message, arguments, stack, pos);
    }

    static public function warning(message:String, arguments:Dynamic=null,
                                   ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).warning(message, arguments, stack, pos);
    }

    static public function warn(message:String, arguments:Dynamic=null,
                                ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).warn(message, arguments, stack, pos);
    }

    static public function error(message:String, arguments:Dynamic=null,
                                 ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).error(message, arguments, stack, pos);
    }

    static public function critical(message:String, arguments:Dynamic=null,
                                    ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).critical(message, arguments, stack, pos);
    }

    static public function fatal(message:String, arguments:Dynamic=null,
                                 ?stack:Array<StackItem>, ?pos:PosInfos):Void
    {
        getLogger(null).fatal(message, arguments, stack, pos);
    }

    static public function log(level:Int, message:String, 
                               ?stack:Array<StackItem>, arguments:Dynamic=null,
                               ?pos:PosInfos):Void
    {
        getLogger(null).log(level, message, arguments, stack, pos);
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