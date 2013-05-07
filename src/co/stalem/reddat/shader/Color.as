package co.stalem.reddat.shader 
{
	import co.stalem.reddat.core.RedMath
	
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Color 
	{
		private var _r : Number;
		private var _g : Number;
		private var _b : Number;
		
		public function Color ( r:Number = .5, g:Number = .5, b:Number = .5 ) 
		{
			this.r = r;
			this.g = g;
			this.b = b;
		}
		
		public function set r ( v:Number ) : void
		{
			_r = RedMath.constraint( v, 0, 1 );
		}
		public function get r () : Number { return _r; }
		
		public function set g ( v:Number ) : void
		{
			_g = RedMath.constraint( v, 0, 1 );
		}
		public function get g () : Number { return _g; }
		
		public function set b ( v:Number ) : void
		{
			_b = RedMath.constraint( v, 0, 1 );
		}
		public function get b () : Number { return _b; }
	}

}