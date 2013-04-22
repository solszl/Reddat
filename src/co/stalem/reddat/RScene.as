package co.stalem.reddat 
{
	import co.stalem.reddat.geom.RMesh;
	import flash.display3D.Context3D;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RScene extends EventDispatcher
	{
		private var _id:int = -1;
		private var _event:RSceneUpdateEvent;
		
		// Contains all meshes
		protected var _meshes:Vector.<RMesh>;
		protected var _cameras:Vector.<RCamera>;
		
		protected var _context3D:Context3D;
		
		public function RScene( id:int ) 
		{
			_id = id;
			_meshes = new Vector.<RMesh>();
			_cameras = new Vector.<RCamera>();
			
			this.dispatchEvent( _event = new RSceneUpdateEvent( _id ) );
		}
		
		/*************	GETTERS / SETTERS
		 */
		
		public function get id () : int { return _id; }
	}

}