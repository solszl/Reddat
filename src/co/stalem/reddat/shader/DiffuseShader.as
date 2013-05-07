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
	public class DiffuseShader extends Shader
	{
		private var _color	: Color;
		
		public function DiffuseShader() 
		{
			super();
			
			this._color = new Color(.8, .8, .8);
			//this._shaderType = ShaderType.BACK_BUFFER;
			
			/*_vertexProgram		= "m44 op, va0, vc0\n" +
								  "mov v0, va1";*/
			_fragmentProgram	= "mov oc, fc0";	// Just output color
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