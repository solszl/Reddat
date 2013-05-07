package co.stalem.reddat.environment 
{
	import co.stalem.reddat.core.Object3D;
	import co.stalem.reddat.shader.Color;
	import de.nulldesign.nd2d.utils.ColorUtil;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Light extends Object3D
	{
		private var _intensity	: Number;
		private var _color		: Color;
		
		public function Light()
		{
			super();
			
			_intensity = .5;
			_color = new Color();
		}
		
	}

}