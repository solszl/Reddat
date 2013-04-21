package co.stalem.reddat.geom 
{
	import co.stalem.reddat.shader.RMaterial;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RMesh 
	{
		public var material:RMaterial;
		
		// Contains vertex pos, colors, and uv's
		// In the format x, y, z, r, g, b, u, v
		public var vertices:Vector.<Number>;
		public var indices:Vector.<uint>;
		
		public function RMesh() 
		{
			vertices = Vector.<Number>();
			indices = Vector.<uint>();
		}
		
	}

}