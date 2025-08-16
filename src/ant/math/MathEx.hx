package ant.math;

class MathEx
{
    /**
     * Returns the logarithm of `value` with respect to `base`.
     *
     * @param base The base of the logarithm.
     * @param value The value for which the logarithm is calculated.
     * @return The logarithm of `value` with respect to `base`.
     */
    public static inline function logBase(base:Float, value:Float):Float
    {
        return Math.log(value) / Math.log(base);
    }

    /**
     * Framerate independant linear interpolation
     * @see https://twitter.com/FreyaHolmer/status/1757836988495847568
     * @see https://twitter.com/FreyaHolmer/status/1757857332187324505
     *
     * @param base The base value
     * @param target The target value
     * @param ratio Interpolation ratio
     * @param elapsed Elapsed time since the last frame
     * @return Interpolated value
     */
    public static inline function fpsLerp(base:Float, target:Float, ratio:Float, ?elapsed:Float):Float
    {   
        #if flixel
        if (elapsed == null) elapsed = flixel.FlxG.elapsed;
        #end

        var h:Float = -(1/60) / logBase(2, 1 - ratio);
        return target + (base - target) * Math.pow(2, -elapsed / h);
    }

    /**
     * Exponential interpolation
     * @see https://twitter.com/FreyaHolmer/status/1813629237187817600
     *
     * @param a Minimum value of the range
     * @param b Maximum value of the range
     * @param t A value from 0.0 to 1.0, optional, by default will be a random value.
     */
    public static inline function eerp(a:Float, b:Float, ?t:Null<Float> = null):Float
    {
        if (t == null)
            t = Math.random();

        return a * Math.exp(t * Math.log(b / a));
    }

    /**
     * Clamps an integer value to a specified range.
     * @param v The value to clamp.
     * @param min Minimum allowed value.
     * @param max Maximum allowed value.
     * @return Clamped value.
     */
    overload extern public static inline function clamp(v:Int, min:Int, max:Int):Int
    {
        return v > max ? max : v < min ? min : v;
    }

    /**
     * Clamps a floating-point value to a specified range.
     * @param v The value to clamp.
     * @param min Minimum allowed value.
     * @param max Maximum allowed value.
     * @return Clamped value.
     */
    overload extern public static inline function clamp(v:Float, min:Float, max:Float):Float
    {
        return v > max ? max : v < min ? min : v;
    }
}
