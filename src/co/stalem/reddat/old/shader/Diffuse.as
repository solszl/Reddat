package co.stalem.reddat.shader 
{
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Diffuse extends RMaterial
	{
		
		public function Diffuse() 
		{
			super();
			
			_vertProg = "m44 op, va0, vc0\n" +
						"mov v0, va1";
			_fragProg = "mov oc, v0";
		}
		
	}

}