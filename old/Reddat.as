package co.stalem.reddat
{
	import co.stalem.reddat.geom.RMesh;
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.Stage;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.display.Sprite;
	import flash.display3D.*;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Reddat extends Sprite
	{
		protected var context3D:Context3D;
		protected var vertexbuffer:VertexBuffer3D;
		protected var indexbuffer:IndexBuffer3D;
		protected var program:Program3D;
		
		/**
		 * Render pass variables
		 */
		
		// Used for each mesh transformation
		private var _transform:Matrix3D;
		// Current camera reference
		private var _camera:RCamera;
		// Current mesh reference
		private var _mesh:RMesh;
		// Used for frame time measurement
		private var _start:uint;
		
		private var _stage:Stage;
		private var _scenes:Vector.<RScene>;
		
		public function Reddat( _stage:Stage ):void
		{
			this._stage = _stage;
			_scenes = new Vector.<RScene>();
		}
		
		private function onSceneUpdate ( e:RSceneUpdateEvent ) : void
		{
			var scene:RScene = _scenes[e.id];
			
			
			for (var j:int = 0; j < scene.meshes.length; j++)
			{	
				_mesh = scene.meshes[j];
				_transform = new Matrix3D();
				
				// Create and upload vertex buffer
				vertexbuffer = scene.context3D.createVertexBuffer(_mesh.vertices.length / RMesh.VERTEX_DATA, RMesh.VERTEX_DATA);
				vertexbuffer.uploadFromVector(_mesh.vertices, 0, _mesh.vertices.length / RMesh.VERTEX_DATA);
				
				// Create and upload index buffer
				indexbuffer = scene.context3D.createIndexBuffer(_mesh.indices.length);
				indexbuffer.uploadFromVector (_mesh.indices, 0, _mesh.indices.length);
				
				// Material pass
				if (!_mesh.material.program)
					_mesh.material.program = scene.context3D.createProgram();
				
				_mesh.material.assemble();
			}
			/*context3D = stage.stage3Ds[0].context3D;
			context3D.configureBackBuffer(800, 600, 2, true);
			
			var vertices:Vector.<Number> = Vector.<Number>([
																-0.3,-0.3, 0, .7, .7, .75, // x, y, z, r, g, b
																-0.3, 0.3, 0, .4, .4, .45,
																 0.3, 0.3, 0, .1, .1, .15,
																 0.3,-0.3, 0, .4, .4, .45
															]);
															
			// Create VertexBuffer3D. 3 vertices, of 6 Numbers each
			vertexbuffer = context3D.createVertexBuffer(4, 6);
			// Upload VertexBuffer3D to GPU. Offset 0, 3 vertices
			vertexbuffer.uploadFromVector(vertices, 0, 4);
			
			var indices:Vector.<uint> = Vector.<uint>([0, 1, 2, 2, 3, 0]);
			// Create IndexBuffer3D. Total of 3 indices. 1 triangle of 3 vertices
			indexbuffer = context3D.createIndexBuffer(6);			
			// Upload IndexBuffer3D to GPU. Offset 0, count 3
			indexbuffer.uploadFromVector (indices, 0, 6);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble( Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" + // pos to clipspace
				"mov v0, va1" // copy color
			);			

			var fragmentShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentShaderAssembler.assemble( Context3DProgramType.FRAGMENT,
				"mov oc, v0"
			);

			program = context3D.createProgram();
			program.upload( vertexShaderAssembler.agalcode, fragmentShaderAssembler.agalcode);*/
			
		}
		
		/**
		 * Request a scene instance
		 */
		public function requestScene () : RScene
		{
			var s:RScene = new RScene( _scenes.length );
			_scenes.push(s);
			s.addEventListener( RSceneUpdateEvent.READY, onSceneReady );
			s.addEventListener( RSceneUpdateEvent.UPDATE, onSceneUpdate );
			
			_stage.stage3Ds[s.id].addEventListener(Event.CONTEXT3D_CREATE, s.contextReady);
			_stage.stage3Ds[s.id].requestContext3D();
			
			return s;
		}
		
		private function onSceneReady ( e:RSceneUpdateEvent ) : void
		{
			_scenes[e.id].context3D = _stage.stage3Ds[e.id].context3D;
		}
		
		/**
		 * Renders each camera in the provided scene
		 * @param	scene RScene object
		 */
		public function renderScene ( scene:RScene ) : void
		{
			if (!scene.context3D)
			{
				trace("renderScene: Provided RScene has no Context3D.");
				return;
			}
			
			_start = getTimer();
			
			// Camera pass
			for (var i:int = 0; i < scene.cameras.length; i++)
			{
				_camera = scene.cameras[i];
				
				scene.context3D.configureBackBuffer(_camera.width, _camera.height, 2, true);
				scene.context3D.clear(.067, .067, .17);
				
				// Mesh pass
				for (var j:int = 0; j < scene.meshes.length; j++)
				{	
					_mesh = scene.meshes[j];
					_transform = new Matrix3D();
					
					// Create and upload vertex buffer
					/*vertexbuffer = scene.context3D.createVertexBuffer(_mesh.vertices.length / RMesh.VERTEX_DATA, RMesh.VERTEX_DATA);
					vertexbuffer.uploadFromVector(_mesh.vertices, 0, _mesh.vertices.length / RMesh.VERTEX_DATA);
					
					// Create and upload index buffer
					indexbuffer = scene.context3D.createIndexBuffer(_mesh.indices.length);
					indexbuffer.uploadFromVector (_mesh.indices, 0, _mesh.indices.length);
					
					// Material pass
					if (!_mesh.material.program)
						_mesh.material.program = scene.context3D.createProgram();
					
					_mesh.material.assemble();*/
					
					// Define vertex data buffers
					scene.context3D.setVertexBufferAt (0, vertexbuffer, 0, 	Context3DVertexBufferFormat.FLOAT_3);	// xyz
					scene.context3D.setVertexBufferAt (1, vertexbuffer, 3, 	Context3DVertexBufferFormat.FLOAT_3);	// rgb
					scene.context3D.setVertexBufferAt (2, vertexbuffer, 6, 	Context3DVertexBufferFormat.FLOAT_2);	// uv
					
					// Assign shader
					scene.context3D.setProgram(_mesh.material.program);
					
					// Create mesh transformations
					_transform.appendRotation( _mesh.rotation.y, Vector3D.Y_AXIS);
					_transform.appendRotation( _mesh.rotation.z, Vector3D.Z_AXIS);
					_transform.appendRotation( _mesh.rotation.x, Vector3D.X_AXIS);
					_transform.appendTranslation( 
													_mesh.position.x,
													_mesh.position.y,
													_mesh.position.z
												);
					
					// Append camera projection
					_transform.append( _camera.perspective );
					// Upload mesh transformations
					scene.context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _transform, true);
					
					// Render
					scene.context3D.drawTriangles( indexbuffer );
				}
				
				scene.context3D.present();
			}	// End amera pass
			//trace(getTimer() - _start);
		}
	}
	
}