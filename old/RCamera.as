package co.stalem.reddat 
{
	import com.adobe.utils.PerspectiveMatrix3D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RCamera 
	{
		protected var _viewport:Bitmap;
		internal var _viewportData:BitmapData;
		
		protected var _w:int;
		protected var _h:int;
		
		protected var _fov:Number;
		protected var _aspectRatio:Number;
		protected var _clipNear:Number = 0.1;
		protected var _clipFar:Number = 1000;
		
		protected var _perspectiveMatrix:PerspectiveMatrix3D;
		
		public function RCamera( width:int, height:int ) 
		{
			_w = width;
			_h = height;
			
			_viewportData = new BitmapData(_w, _h);
			_viewport = new Bitmap(_viewportData);
			
			_perspectiveMatrix = new PerspectiveMatrix3D();
			_perspectiveMatrix.perspectiveFieldOfViewLH(_fov = 45 * Math.PI / 180, _aspectRatio = _w / _h, _clipNear, _clipFar);
		}
		
		/*************	GETTERS / SETTERS
		 */
		
		public function set antiAliasing ( b:Boolean ) : void
		{
			_viewport.smoothing = b;
		}
		public function get antiAliasing () : Boolean { return _viewport.smoothing; }
		
		public function set width ( w:int ) : void
		{
			_w = w;
			_perspectiveMatrix.perspectiveFieldOfViewLH(_fov, _aspectRatio = _w / _h, _clipNear, _clipFar);
		}
		public function get width () : int { return _w; }
		
		public function set height ( h:int ) : void
		{
			_h = h;
			_perspectiveMatrix.perspectiveFieldOfViewLH(_fov, _aspectRatio = _w / _h, _clipNear, _clipFar);
		}
		public function get height () : int { return _h; }
		
		public function get viewport () : Bitmap { return _viewport; }
		public function get perspective () : PerspectiveMatrix3D { return _perspectiveMatrix; }
	}

}