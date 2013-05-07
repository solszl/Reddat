package co.stalem.reddat.material 
{
	import co.stalem.reddat.environment.Camera;
	import co.stalem.reddat.geometry.Geometry;
	import co.stalem.reddat.shader.*;
	import flash.display3D.Context3D;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Material 
	{
		private var _shader	: Shader;
		
		public function Material() 
		{
			_shader = new BufferShader();
		}
		
		public function render ( geometry : Geometry, camera : Camera ) : void
		{
			_shader.render( geometry, camera );
		}
		
		public function get shader () : Shader { return _shader; }
	}

}