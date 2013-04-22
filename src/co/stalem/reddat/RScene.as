package co.stalem.reddat 
{
	import co.stalem.reddat.geom.RMesh;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RScene extends EventDispatcher
	{
		private var _id:int = -1;
		
		// Contains all meshes
		protected var _meshes:Vector.<RMesh>;
		protected var _cameras:Vector.<RCamera>;
		
		public function RScene( id:int ) 
		{
			_id = id;
			_meshes = new Vector.<RMesh>();
			_cameras = new Vector.<RCamera>();
		}
		
		/*************	GETTERS / SETTERS
		 */
		
		public function get id () : int { return _id; }
	}

}