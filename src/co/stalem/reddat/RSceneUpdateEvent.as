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
		
		public function RSceneUpdateEvent( _id:int ) 
		{
			id = _id;
		}
		
	}

}