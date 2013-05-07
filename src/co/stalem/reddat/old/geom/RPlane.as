package co.stalem.reddat.geom 
{
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RPlane extends RMesh
	{
		
		public function RPlane() 
		{
			super();
			vertices = Vector.<Number>([
												-.5,-.5, 0.5, 1, 0, 0, 0, 0,
												-.5, .5, 0.5, 1, 0, 0, 0, 1,
												 .5, .5, 0.5, 1, 0, 0, 1, 1,
												 .5,-.5, 0.5, 1, 0, 0, 1, 0
											]);
			indices = Vector.<uint>([0, 1, 2, 0, 2, 3]);
		}
		
	}

}