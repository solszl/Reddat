package co.stalem.reddat.geom 
{
	import co.stalem.reddat.shader.RMaterial;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RMesh 
	{
		public static const VERTEX_DATA:uint = 8;
		
		public var material:RMaterial;
		
		// Contains vertex pos, colors, and uv's
		// In the format x, y, z, r, g, b, u, v
		public var vertices:Vector.<Number>;
		public var indices:Vector.<uint>;
		
		// Mesh rotational and positional offsets
		public var rotation:Vector3D;
		public var position:Vector3D;
		
		public function RMesh() 
		{
			rotation = new Vector3D();
			position = new Vector3D();
			
			material = new RMaterial();
			vertices = new Vector.<Number>();
			indices = new Vector.<uint>();
		}
		
	}

}