package ant.openfl;

import openfl.events.NetStatusEvent;
import openfl.events.AsyncErrorEvent;
import openfl.net.NetStream;
import openfl.net.NetConnection;
import openfl.media.Video;

class HTML5Video extends Video
{
    var onComplete:Null<Void->Void>;

    var connection:NetConnection;
    var stream:NetStream;

    public function new(?onComplete:Void->Void)
    {
        super();
        this.onComplete = onComplete;

        connection = new NetConnection();
        connection.connect(null);

        stream = new NetStream(connection);
        stream.client = {
            onMetaData: streamOnMetaData
        };

        stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, streamOnAsyncError);
        connection.addEventListener(NetStatusEvent.NET_STATUS, connectionOnNetStatus);
    }

    function streamOnMetaData(data:Dynamic)
    {
        attachNetStream(stream);
        width = videoWidth;
        height = videoHeight;
    }

    function streamOnAsyncError(event:AsyncErrorEvent):Void
    {
        trace('Failed to load video ($event)');
        
        if (onComplete != null)
            onComplete();
    }

    function connectionOnNetStatus(event:NetStatusEvent):Void
    {
        if (event.info.code == "NetStream.Play.Complete") 
        {
            if (onComplete != null)
                onComplete();
        }
    }
}
