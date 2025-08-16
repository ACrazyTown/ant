package ant.sound;

import flixel.system.FlxAssets.FlxSoundAsset;
import flixel.FlxG;
import flixel.sound.FlxSound;
import ant.math.MathEx;

/**
 * Helper functions for playing sound.
 */
class SoundUtil
{
    /**
     * Helper function to play a sound.
     * @param asset The embedded sound resource you want to play.
     * @param volume The volume of the sound.
     * @param pitch The sound's pitch.
     * @return The instance of the played sound.
     */
    public static function playSFX(asset:FlxSoundAsset, ?volume:Float = 1.0, ?pitch:Float = 1.0):FlxSound
    {
        var sound = FlxG.sound.play(asset, volume);
        sound.pitch = pitch;
        return sound;
    }

    /**
     * Helper function to play a sound with a random pitch in a specified range.
     * @param asset The embedded sound resource you want to play.
     * @param volume The volume of the sound.
     * @param pitchRangeStart The start of the pitch range.
     * @param pitchRangeEnd  The end of the pitch range.
     * @return The instance of the played sound.
     */
    public static function playSFXWithPitchRange(asset:FlxSoundAsset, ?volume:Float = 1.0, ?pitchRangeStart:Float = 1.0, ?pitchRangeEnd:Float = 1.0):FlxSound
    {
        var sound = playSFX(asset, volume);
        if (pitchRangeStart != 1 || pitchRangeEnd != 1)
            sound.pitch = MathEx.eerp(pitchRangeStart, pitchRangeEnd);

        return sound;
    }
}
