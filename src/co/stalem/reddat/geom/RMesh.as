package co.stalem.reddat.geom 
{
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RMesh 
	{
		protected var vertices:Vector.<Number>;
		protected var indices:Vector.<uint>;
		
		public function RMesh() 
		{
			vertices = Vector.<Number>();
			indices = Vector.<uint>();
		}
		
	}

}