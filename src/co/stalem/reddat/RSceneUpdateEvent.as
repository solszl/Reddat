package co.stalem.reddat 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RSceneUpdateEvent extends Event
	{
		public var id:int;
		
		private var _event:RSceneUpdateEvent;
		
		public function RSceneUpdateEvent( _id:int ) 
		{
			id = _id;
			_event = new RSceneUpdateEvent( _id );
		}
		
	}

}