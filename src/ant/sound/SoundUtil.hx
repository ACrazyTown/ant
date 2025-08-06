package ant.sound;

import flixel.FlxG;
import flixel.sound.FlxSound;
import ant.math.MathEx;

class SoundUtil
{
    public static function playSFX(path:String, ?volume:Float = 1.0, ?pitch:Float = 1.0):FlxSound
    {
        var sound = FlxG.sound.play(path, volume);
        sound.pitch = pitch;
        return sound;
    }

    public static function playSFXWithPitchRange(path:String, ?volume:Float = 1.0, ?pitchRangeStart:Float = 1.0, ?pitchRangeEnd:Float = 1.0):FlxSound
    {
        var sound = playSFX(path, volume);
        if (pitchRangeStart != 1 || pitchRangeEnd != 1)
            sound.pitch = MathEx.eerp(pitchRangeStart, pitchRangeEnd);

        return sound;
    }
}
