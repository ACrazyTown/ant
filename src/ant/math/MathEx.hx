package ant.math;

import flixel.FlxG;

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
     * @return Interpolated value
     */
    public static inline function fpsLerp(base:Float, target:Float, ratio:Float):Float
    {   
        var h:Float = -(1/60) / logBase(2, 1 - ratio);
        return target + (base - target) * Math.pow(2, -FlxG.elapsed / h);
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
            t = FlxG.random.float();

        return a * Math.exp(t * Math.log(b / a));
    }
}
