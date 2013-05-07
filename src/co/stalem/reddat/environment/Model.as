package co.stalem.reddat.environment 
{
	import co.stalem.reddat;
	import co.stalem.reddat.core.Object3D;
	import co.stalem.reddat.geometry.Geometry;
	import co.stalem.reddat.material.Material;
	import co.stalem.reddat.material.DiffuseMaterial;
	import co.stalem.reddat.shader.DiffuseShader;
	import co.stalem.reddat.shader.Shader;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DVertexBufferFormat;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Model extends Object3D
	{
		reddat var _geometry	: Geometry;
		reddat var _material		: Material;
		
		private var _double		: Boolean = false;
		
		public function Model ( geometry:Geometry = null )
		{
			super();
			
			_geometry = geometry || new Geometry();
			_material = new DiffuseMaterial();
		}
		
		public function render ( context:Context3D ) : void
		{
			//_shader.prepareForContext( context );
			//context.setProgram( _material._program );
			
			context.setVertexBufferAt( 0, _geometry._vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3 );
			context.setVertexBufferAt( 1, _geometry._vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2 );
			context.drawTriangles(_geometry._indexBuffer, 0, _geometry.numIndices );
		}
		
		public function set doubleSided ( b:Boolean ) : void
		{
			if (_double && !b)
			{
				_geometry.indices = _geometry.indices.slice(0, _geometry.indices.length / 2);
				_double = b;
			}
			else if (!_double && b)
			{
				_geometry.indices = _geometry.indices.concat( _geometry.indices.slice(0, _geometry.indices.length).reverse() );
				_double = b;
			}
		}
		
		public function set material ( material:Material ) : void
		{
			// this._shader.dispose();
			this._material = material;
			this._material.shader._dirty = true;
		}
		public function get material () : Material { return this._material; }
	}
}