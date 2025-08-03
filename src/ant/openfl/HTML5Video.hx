package ant.openfl;

import openfl.media.SoundTransform;
import openfl.events.NetStatusEvent;
import openfl.events.AsyncErrorEvent;
import openfl.net.NetStream;
import openfl.net.NetConnection;
import openfl.media.Video;

class HTML5Video extends Video
{
    public var volume(get, set):Float;

    var onComplete:Null<Void->Void>;

    var _transform:SoundTransform;
    var _connection:NetConnection;
    var _stream:NetStream;

    public function new(?onComplete:Void->Void)
    {
        super();
        this.onComplete = onComplete;

        _transform = new SoundTransform();

        _connection = new NetConnection();
        _connection.connect(null);

        _stream = new NetStream(_connection);
        _stream.client = {
            onMetaData: _streamOnMetaData
        };

        _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, _streamOnAsyncError);
        _connection.addEventListener(NetStatusEvent.NET_STATUS, _connectionOnNetStatus);
    }

    public function play(url:String):Void
    {
        _stream.play(url);
    }

    function _streamOnMetaData(data:Dynamic)
    {
        attachNetStream(_stream);
        width = videoWidth;
        height = videoHeight;
    }

    function _streamOnAsyncError(event:AsyncErrorEvent):Void
    {
        trace('Failed to load video ($event)');
        
        if (onComplete != null)
            onComplete();
    }

    function _connectionOnNetStatus(event:NetStatusEvent):Void
    {
        if (event.info.code == "Net_stream.Play.Complete") 
        {
            if (onComplete != null)
                onComplete();
        }
    }

    function _updateTransform():Void
    {
        if (_stream != null)
            _stream.soundTransform = _transform;
    }

    @:noCompletion function set_volume(value:Float):Float 
    {
        _transform.volume = value;
        _updateTransform();

        return value;
    }

	@:noCompletion function get_volume():Float 
    {
		return _transform.volume;
	}
}
