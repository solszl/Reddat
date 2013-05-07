package co.stalem.reddat.core 
{
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RedMath 
	{
		public static const RADDEG : Number = 180 / Math.PI;
		public static const DEGRAD : Number = Math.PI / 180;
		
		public function RedMath() 
		{
			
		}
		
		public static function constraint ( v:Number, min:Number, max:Number ) : Number
		{
			return Math.min( Math.max( v, min ), max );
		}
	}

}