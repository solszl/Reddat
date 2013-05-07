package co.stalem.reddat.core 
{
	import co.stalem.reddat;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Object3D 
	{
		private var _rotation		: Vector3D;
		private var _position		: Vector3D;
		reddat var _transformation	: Matrix3D;
		reddat var _dirty			: Boolean;
		
		public function Object3D () 
		{
			_rotation = new Vector3D();
			_position = new Vector3D();
			_transformation = new Matrix3D();
			_dirty = true;
		}
		
		public function set transformation ( m:Matrix3D ) : void
		{
			_transformation = m;
			_dirty = true;
		}
		public function get transformation () : Matrix3D { return _transformation; }
		
		public function set rotation ( vec:Vector3D ) : void
		{
			//_dirty = true;
			_rotation = vec;
		}
		public function get rotation () : Vector3D { return _rotation; }
		
		public function set rotationX ( deg:Number ) : void
		{
			_dirty = true;
			_rotation.x = deg;
		}
		public function get rotationX () : Number { return _rotation.x; }
		
		public function set rotationY ( deg:Number ) : void
		{
			_dirty = true;
			_rotation.y = deg;
		}
		public function get rotationY () : Number { return _rotation.y; }
		
		public function set rotationZ ( deg:Number ) : void
		{
			_dirty = true;
			_rotation.z = deg;
		}
		public function get rotationZ () : Number { return _rotation.z; }
		
		public function set position ( vec:Vector3D ) : void
		{
			//_dirty = true;
			_position = vec;
		}
		public function get position () : Vector3D { return _position; }
		
		public function set x ( pos:Number ) : void
		{
			_position.x = pos;
		}
		public function get x () : Number { return _position.x; }
		
		public function set y ( pos:Number ) : void
		{
			_position.y = pos;
		}
		public function get y () : Number { return _position.y; }
		
		public function set z ( pos:Number ) : void
		{
			_position.z = pos;
		}
		public function get z () : Number { return _position.z; }
	}

}