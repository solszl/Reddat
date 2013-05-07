package co.stalem.reddat.environment 
{
	import flash.display.Stage;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import co.stalem.reddat;
	import co.stalem.reddat.geometry.Geometry;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Scene 
	{
		private var _stageRef	: Stage;
		private var _models		: Vector.<Model>;
		private var _cameras	: Vector.<Camera>;
		private var _lights		: Vector.<Light>;
		
		// Current camera being rendere
		private var _camera	: Camera;
		// Transformation buffer matrix
		private var _trans	: Matrix3D;
		// List of indexes of dirty but updated geometries
		private var _geomList	: Vector.<uint>;
		
		public function Scene ( stage:Stage ) 
		{
			_stageRef = stage;
			_trans = new Matrix3D();
			
			_models = new Vector.<Model>;
			_cameras = new Vector.<Camera>;
			_lights = new Vector.<Light>;
			
			this.addCamera( new Camera() );
		}
		
		/**
		 * Adds a camera to this scene unless it's not already added
		 * @param	cam	The camera to add to this scene
		 */
		public function addCamera ( cam:Camera ) : void
		{
			if (!cam.id)
			{
				cam.id = _cameras.length;
				updateDirtyCamera( cam );
				_cameras.push( cam );
			}
		}
		
		public function getCamera ( num:int = 0 ) : Camera
		{
			return _cameras[num];
		}
		
		/**
		 * Adds a model to this scene
		 * @param	model The model to add
		 */
		public function addModel ( model:Model ) : void
		{
			_models.push( model );
		}
		
		public function render ( cameraList:Vector.<uint> = null ) : void
		{
			if (cameraList == null)
				cameraList = Vector.<uint>([0]);
			
			_geomList = new Vector.<uint>;
			
			// Camera pass
			for (var i:int = 0; i < cameraList.length; i++)
			{
				_camera = _cameras[ cameraList[i] ];
				
				if (_camera._dirty)
					updateDirtyCamera(_camera);
				
				// Only continue if the camera has received a context
				if (_camera._context)
				{
					_camera._context.clear( .3, .3, .3 );
					
					// Model pass
					for ( var j:int = 0; j < _models.length; j++)
					{
						// Update geometry if dirty
						// and add to list of updated
						if (_models[j]._geometry._dirty)
						{
							_models[j]._geometry.uploadBuffers( _camera._context );
							_geomList.push(j);
						}
						
						// Update current models shader program
						if (_models[j].material.shader._dirty)
						{
							/*if (!_models[j]._shader._program)
								_models[j]._shader._program = _camera._context.createProgram();*/
								
							_models[j].material.shader.assemble( _camera );
							_geomList.push(j);
						}
						//_models[j]._shader.assemble(_camera._context, _camera._program);
						//_camera._context.setProgram( _models[j]._shader._program );
						
						// Apply transforms
						_trans.identity();
						_trans.appendRotation( _models[j].rotation.y, Vector3D.Y_AXIS );
						_trans.appendRotation( _models[j].rotation.z, Vector3D.Z_AXIS );
						_trans.appendRotation( _models[j].rotation.x, Vector3D.X_AXIS );
						_trans.appendTranslation( _models[j].position.x, _models[j].position.y, _models[j].position.z );
						//_trans.append( _models[j].transformation );
						_trans.append( _camera.transformation );
						_trans.append( _camera.projection );
						
						_camera._context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _trans, true);
						
						_camera._context.setVertexBufferAt( 0, _models[j]._geometry._vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3 );
						_camera._context.setVertexBufferAt( 1, _models[j]._geometry._vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2 );
						
						// Render the model
						_models[j].material.render( _models[j]._geometry, _camera );
					}
					
					_camera._context.present();
				}
			}	// End Camera pass
			
			// Mark dirty geometry as clean
			for (i = 0; i < _geomList.length; i++)
			{
				_models[ _geomList[i] ]._geometry._dirty = false;
				_models[ _geomList[i] ].material.shader._dirty = false;
			}
		}
		
		/**
		 * Updates a dirty camera
		 */
		private function updateDirtyCamera ( c:Camera ) : void
		{
			if (!c.viewport)
				c.viewport = _stageRef.stage3Ds[ c.id ];
			
			if (c._context)
				c._context.configureBackBuffer(c.width, c.height, 2);
			
			c._dirty = false;
		}
	}

}