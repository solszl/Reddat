package co.stalem.reddat.environment 
{
	import co.stalem.reddat;
	import co.stalem.reddat.core.Object3D;
	import co.stalem.reddat.core.RedMath;
	import com.adobe.utils.PerspectiveMatrix3D;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.Program3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Camera extends Object3D
	{
		reddat var id : uint;
		
		private var _viewport	: Stage3D;
		reddat var _context		: Context3D;
		reddat var _program		: Program3D;
		
		private var _projection	: PerspectiveMatrix3D;
		private var _width		: int;
		private var _height		: int;
		
		private var _fov		: Number;
		private var _aspectRatio: Number;
		private var _clipNear	: Number = 1;
		private var _clipFar	: Number = 1000;
		
		public function Camera ( width:int = 512, height:int = 512 )
		{
			super();
			
			_width = width;
			_height = height;
			
			_projection = new PerspectiveMatrix3D();
			_projection.perspectiveFieldOfViewLH(_fov = 45 * RedMath.DEGRAD, _aspectRatio = _width / _height, _clipNear, _clipFar);
		}
		
		/**
		 * Called when the Context3D is available
		 */
		private function contextCreated ( e:Event ) : void
		{
			_viewport.removeEventListener(Event.CONTEXT3D_CREATE, contextCreated);
			_viewport.removeEventListener(ErrorEvent.ERROR, contextCreationError);
			
			_context = _viewport.context3D;
			_context.enableErrorChecking = true;
			_context.setCulling(Context3DTriangleFace.BACK);
			
			_program = _context.createProgram();
			
			_dirty = true;
		}
		
		/**
		 * Called when the Context3D can not be created
		 */
		private function contextCreationError ( e:ErrorEvent ) : void
		{
			trace("Unable to create Context3D in " + this);
			
			_viewport.removeEventListener(Event.CONTEXT3D_CREATE, contextCreated);
			_viewport.removeEventListener(ErrorEvent.ERROR, contextCreationError);
			
			_dirty = true;
		}
		
		reddat function set viewport ( v:Stage3D ) : void
		{
			_viewport = v;
			
			_viewport.addEventListener(Event.CONTEXT3D_CREATE, contextCreated);
			_viewport.addEventListener(ErrorEvent.ERROR, contextCreationError);
			_viewport.requestContext3D();
		}
		reddat function get viewport () : Stage3D { return _viewport; }
		
		public function set width ( w:Number ) : void
		{
			_dirty = true;
			
			_width = w;
			_projection.perspectiveFieldOfViewLH(_fov, _aspectRatio = _width / _height, _clipNear, _clipFar);
		}
		public function get width () : Number { return _width; }
		
		public function set height ( h:Number ) : void
		{
			_dirty = true;
			
			_height = h;
			_projection.perspectiveFieldOfViewLH(_fov, _aspectRatio = _width / _height, _clipNear, _clipFar);
		}
		public function get height () : Number { return _height; }
		
		public function set fieldOfView ( degrees:Number ) : void
		{
			this._dirty = true;
			_projection.perspectiveFieldOfViewLH(_fov = degrees * RedMath.DEGRAD, _aspectRatio, _clipNear, _clipFar);
		}
		public function get fieldOfView () : Number { return _fov * RedMath.RADDEG; }
		
		public function set viewportX ( x:Number ) : void
		{
			if (_viewport)
				_viewport.x = x;
		}
		public function get viewportX () : Number
		{
			if (_viewport)
				return _viewport.x;
			return 0;
		}
		
		public function set viewportY ( y:Number ) : void
		{
			if (_viewport)
				_viewport.y = y;
		}
		public function get viewportY () : Number
		{
			if (_viewport)
				return _viewport.y;
			return 0;
		}
		
		public function get projection () : PerspectiveMatrix3D { return _projection; }
	}

}