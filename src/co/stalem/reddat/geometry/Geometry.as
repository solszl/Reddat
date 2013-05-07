package co.stalem.reddat.geometry 
{
	import co.stalem.reddat;
	import flash.display3D.Context3D;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Geometry 
	{
		public static const DATA_PER_VERTEX	: int = 5;
		
		reddat var _dirty	: Boolean = true;
		
		protected var _vertices	: Vector.<Number>;
		protected var _indices	: Vector.<uint>;
		
		reddat var _vertexBuffer	: VertexBuffer3D;
		reddat var _indexBuffer		: IndexBuffer3D;
		
		public function Geometry() 
		{
			_vertices = new Vector.<Number>;
			_indices = new Vector.<uint>;
		}
		
		/**
		 * Uploads the vertex and index buffers to the VRAM
		 * @param	context	Scope in which buffers will be uploaded
		 */
		reddat function uploadBuffers ( context:Context3D ) : void
		{
			_vertexBuffer = context.createVertexBuffer( _vertices.length / DATA_PER_VERTEX, DATA_PER_VERTEX );
			_vertexBuffer.uploadFromVector( _vertices, 0, _vertices.length / DATA_PER_VERTEX );
			
			_indexBuffer = context.createIndexBuffer( _indices.length );
			_indexBuffer.uploadFromVector( _indices, 0, _indices.length );
		}
		
		reddat function get numIndices () : uint { return _indices.length / 3; }
		
		public function set indices ( i:Vector.<uint> ) : void
		{
			this._indices = i;
			this._dirty = true;
		}
		public function get indices () : Vector.<uint> { return _indices; }
	}

}