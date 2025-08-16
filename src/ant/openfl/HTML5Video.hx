package ant.openfl;

import ant.math.MathEx;
import openfl.media.SoundTransform;
import openfl.events.NetStatusEvent;
import openfl.events.AsyncErrorEvent;
import openfl.net.NetStream;
import openfl.net.NetConnection;
import openfl.media.Video;

/**
 * OpenFL class that allows for playing a video on HTML5.
 */
class HTML5Video extends Video
{
    /**
     * The video's volume (from 0.0 to 1.0).
     */
    public var volume(get, set):Float;

    var onComplete:Null<Void->Void>;

    var _transform:SoundTransform;
    var _connection:NetConnection;
    var _stream:NetStream;

    /**
     * Creates a `HTML5Video` instance.
     * @param onComplete A callback fired when the video finishes playing.
     */
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

    /**
     * Plays the video.
     * @param url The source of the video (File path). 
     */
    public function play(url:Dynamic):Void
    {
        _stream.play(url);
    }

    function _streamOnMetaData(data:Dynamic):Void
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

    @:noCompletion inline function get_volume():Float 
		return _transform.volume;

    @:noCompletion function set_volume(value:Float):Float 
    {
        _transform.volume = MathEx.clamp(value, 0, 1);
        _updateTransform();

        return value;
    }
}
