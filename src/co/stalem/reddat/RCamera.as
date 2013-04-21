package co.stalem.reddat 
{
	import com.adobe.utils.PerspectiveMatrix3D;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RCamera 
	{
		protected var _w:Number;
		protected var _h:Number;
		
		protected var _fov:Number;
		protected var _aspectRatio:Number;
		protected var _clipNear:Number = 0.1;
		protected var _clipFar:Number = 1000;
		
		protected var _perspectiveMatrix:PerspectiveMatrix3D;
		
		public function RCamera( width:Number, height:Number ) 
		{
			_w = width;
			_h = height;
			
			_perspectiveMatrix = new PerspectiveMatrix3D();
			_perspectiveMatrix.perspectiveFieldOfViewLH(_fov = 45 * Math.PI / 180, _aspectRatio = _w / _h, _clipNear, _clipFar);
		}
		
	}

}