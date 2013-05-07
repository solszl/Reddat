package co.stalem.reddat 
{
	import co.stalem.reddat.geom.RMesh;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RScene extends EventDispatcher
	{
		protected var _id:int = -1;
		public var context3D:Context3D;
		
		// Contains all meshes
		public var meshes:Vector.<RMesh>;
		public var cameras:Vector.<RCamera>;
		
		// Buffers
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _vertices:Vector.<Number>;
		private var _indices:Vector.<uint>;
		
		public function RScene( id:int ) 
		{
			context3D.s
			_id = id;
			meshes = new Vector.<RMesh>();
			cameras = new Vector.<RCamera>();
		}
		
		/**
		 * Called when a Context3D is ready
		 * @param	e
		 */
		public function contextReady ( e:Event ) : void
		{
			this.dispatchEvent( new RSceneUpdateEvent(RSceneUpdateEvent.READY, _id) );
		}
		
		public function addMesh ( mesh:RMesh ) : void
		{
			meshes.push( mesh );
			
			update();
		}
		
		public function addCamera ( camera:RCamera ) : void
		{
			cameras.push( camera );
		}
		
		/**
		 * Updates the scene buffers and materials/shaders
		 */
		public function update () : void
		{
			var i:int;
			this.dispatchEvent( new RSceneUpdateEvent(RSceneUpdateEvent.UPDATE, _id) );
			
			/*_vertices = new Vector.<Number>;
			_indices = new Vector.<uint>;
			for (i = 0; i < meshes.length; i++)
			{
				if (meshes[i].material != null)
					meshes[i].material.program = context3D.createProgram();
				
				meshes[i].material.assemble();
				
				_indices = _indices.concat( meshes[i].indices.map(shiftVector, _indices.length) );
				_vertices = _vertices.concat( meshes[i].vertices );
			}
			
			if(_indices.length > 0)
				_indexBuffer = context3D.createIndexBuffer(_indices.length);
			
			if(_vertices.length > 0)
				_vertexBuffer = context3D.createVertexBuffer(_vertices.length, RMesh.VERTEX_DATA);*/
		}
		
		/**
		 * Shifts a vectors values by the length of a provided vector
		 */
		private function shiftVector ( item:int, index:int, vector:Vector.<uint> ) : uint
		{
			return item + Math.round( _vertices.length / RMesh.VERTEX_DATA );
		}
		
		/*************	GETTERS / SETTERS
		 */
		
		public function set id ( i:int ) : void
		{ 
			_id = Math.max(i, 0);
		}
		public function get id () : int { return _id; }
	}

}