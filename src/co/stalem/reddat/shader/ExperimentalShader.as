package co.stalem.reddat.shader 
{
	import co.stalem.reddat;
	import co.stalem.reddat.environment.Camera;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class ExperimentalShader extends Shader
	{
		private var _color	: Color;
		
		public function ExperimentalShader() 
		{
			super();
			
			this._color = new Color(.8, .8, .8);
			
			_vertexProgram		= "m44 vt0, va0, vc0 \n" +
								  "mov v1, va1 \n" +
								  "mov v0, vt0 \n" +
								  "mov op, vt0";
			_fragmentProgram	= //"sat ft0, fc0 \n" +
								  "mov oc, fc0";
		}
		
		override reddat function prepareForRender ( camera : Camera ) : void
		{
			camera._context.setProgramConstantsFromVector( Context3DProgramType.FRAGMENT, 0, Vector.<Number>([_color.r, _color.g, _color.b, 1]) );
		}
		
		public function set color ( col:Color ) : void
		{
			this._color = col;
		}
		public function get color () : Color { return this._color; }
	}

}