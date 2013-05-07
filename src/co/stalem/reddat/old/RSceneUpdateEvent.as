package co.stalem.reddat 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RSceneUpdateEvent extends Event
	{
		public static const READY:String = "ReadyEvent";
		public static const UPDATE:String = "UpdateEvent";
		public var id:int;
		
		public function RSceneUpdateEvent( eventType:String, _id:int ) 
		{
			super(eventType);
			id = _id;
		}
		
	}

}