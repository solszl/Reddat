package co.stalem.reddat.geometry 
{
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class PlaneGeometry extends Geometry
	{
		
		public function PlaneGeometry()
		{
			super();
			
			_vertices = Vector.<Number>([
				-1, -1, 0, 0, 0,
				 1, -1, 0, 1, 0,
				 1,  1, 0, 1, 1,
				-1,  1, 0, 0, 1
			]);
			
			_indices = Vector.<uint>([
				0, 2, 1,
				0, 3, 2
			]);
		}
		
	}

}