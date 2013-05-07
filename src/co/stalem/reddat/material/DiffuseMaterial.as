package co.stalem.reddat.material 
{
	import co.stalem.reddat.shader.DiffuseShader;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class DiffuseMaterial extends Material
	{
		
		public function DiffuseMaterial() 
		{
			super();
			super.shader.setInputShaderAt( new DiffuseShader(), 0 );
		}
		
	}

}