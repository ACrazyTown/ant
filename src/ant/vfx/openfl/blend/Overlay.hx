package ant.vfx.openfl.blend;

import openfl.display.BitmapData;
import openfl.display.GraphicsShader;

/**
 * Blend Mode : Multiply or screen the color 
 * @author Jamie Owen https://github.com/jamieowen/glsl-blend
 * @author adapted by Loudo
 * @author small modifications by ACrazyTown
 * 
 * @see https://github.com/loudoweb/openfl-shaders/blob/master/openfl/shaders/blendMode/Overlay.hx
 */
class Overlay extends GraphicsShader
{
    public var foreground(get, set):BitmapData;
    public var alpha(get, set):Float;
    public var useScaledCoords(get, set):Bool;

    @:glFragmentSource("
        #pragma header

        uniform sampler2D _foreground;
        uniform vec2 _foregroundSize;

        uniform float _alpha;
        uniform bool _useScaledCoords;
        
        float blendOverlay(float base, float blend) 
        {
            return base<0.5?(2.0*base*blend):(1.0-2.0*(1.0-base)*(1.0-blend));
        }

        vec3 blendOverlay(vec3 base, vec3 blend) 
        {
            return vec3(blendOverlay(base.r, blend.r), blendOverlay(base.g, blend.g), blendOverlay(base.b, blend.b));
        }

        vec3 blendOverlay(vec3 base, vec3 blend, float opacity) 
        {
            return (blendOverlay(base, blend) + base * (1.0 - opacity));
        }
        
        void main() 
        {
            vec4 bgColor = texture2D(bitmap, openfl_TextureCoordv);

            vec2 fgCoordOffset = _useScaledCoords ? openfl_TextureSize / _foregroundSize : vec2(1.0);
            vec4 fgColor = texture2D(_foreground, openfl_TextureCoordv * fgCoordOffset);

            vec3 blendedColor = blendOverlay(bgColor.rgb, fgColor.rgb, fgColor.a * _alpha);

            gl_FragColor = vec4(blendedColor, bgColor.a) * openfl_Alphav;
        }
        
    ")
	public function new(foreground:BitmapData, ?alpha:Float = 1)
    {
        super();

		this.foreground = foreground;
        this.alpha = alpha;
        useScaledCoords = true;
	}

	@:noCompletion inline function get_foreground():BitmapData
		return _foreground.input;

    @:noCompletion function set_foreground(value:BitmapData):BitmapData
    {
        _foreground.input = value;
        _foregroundSize.value = [value.width, value.height];
        return value;
    }

	@:noCompletion inline function get_alpha():Float
		return _alpha.value[0];

	@:noCompletion function set_alpha(value:Float):Float 
    {
        _alpha.value = [value];
        return value;
    }

	@:noCompletion inline function get_useScaledCoords():Bool
		return _useScaledCoords.value[0];

	@:noCompletion function set_useScaledCoords(value:Bool):Bool
    {
		_useScaledCoords.value = [value];
		return value;
    }
}
