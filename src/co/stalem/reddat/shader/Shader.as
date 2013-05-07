package co.stalem.reddat.shader 
{
	import co.stalem.reddat;
	import co.stalem.reddat.environment.Camera;
	import co.stalem.reddat.geometry.Geometry;
	import flash.display3D.Context3D;
	import flash.display3D.Program3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.textures.Texture;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class Shader 
	{
		// Defines to what buffer this shader renders
		protected var _shaderType : uint = ShaderType.TEXTURE;
		
		protected var _inputs	: Vector.<Shader>;
		protected var _outputs	: Vector.<Shader>;
		
		// Buffer this shader renders to
		reddat var _buffer	: Texture;
		// Temp holder for current context being rendered
		protected var _context : Context3D;
		
		reddat var _dirty	: Boolean = true;
		reddat var _program : Program3D;
		
		private var _assembler		: REGALAssembler;
		
		protected var _fragmentProgram	: String;
		protected var _vertexProgram	: String;
		
		public function Shader( numInputs:uint = 0, numOutputs:uint = 0 )
		{
			_inputs = new Vector.<Shader>(numInputs, true);
			_outputs = new Vector.<Shader>(numOutputs, true);
			
			_assembler = new REGALAssembler();
			_fragmentProgram = "";
			_vertexProgram = "m44 vt0, va0, vc0\n" +		// Translate vertex positions (va0) using transformation matrix (vc0)
							 "mov op, vt0\n" +				// Move translate position (vt0) to output position
							 "mov v0, vt0\n" +				// Copy translated vertex position (vt0) to shared variable (v0)
							 "mov v1, va1";					// Copy UVs (va1) to shared variable (v1)
		}
		
		/**
		 * Assembles and uploads the program
		 */
		reddat function assemble ( camera:Camera ) : void
		{
			if (!_buffer)
				_buffer = camera._context.createTexture( camera.width, camera.height, Context3DTextureFormat.BGRA, true );
				
			if (!_program)
				_program = camera._context.createProgram();
			
			_assembler.assemble( _vertexProgram, _fragmentProgram );
			
			_program.upload(_assembler._vertexAssembler.agalcode, _assembler._fragmentAssembler.agalcode);
				
			// Assemble child shaders
			if (_inputs.length > 0)
			{
				for (var i:uint = 0; i < _inputs.length; i++)
				{
					// Only render if input shader exist
					if(_inputs[i])
						_inputs[i].assemble( camera );
				}
			}
		}
		
		/**
		 * Overridden by subclasses
		 */
		reddat function prepareForRender ( camera : Camera ) : void
		{
		}
		reddat function disposeForRender ( camera : Camera ) : void
		{
		}
		
		public function render ( geometry : Geometry, camera : Camera ) : void
		{
			//trace("rendering", this);
			var i:int;
			_context = camera._context;
			
			// Render buffers for each connected Shader
			if (_inputs.length > 0)
			{
				for (i = 0; i < _inputs.length; i++)
				{
					// Only render if input shader exist
					if(_inputs[i])
						_inputs[i].render( geometry, camera );
				}
				
				for (i = 0; i < _inputs.length; i++)
				{
					if(_inputs[i])
						_context.setTextureAt(i, _inputs[i]._buffer);
				}
			}
			
			// Render phase
			prepareForRender( camera );
			
			_context.setProgram( _program );
			
			if (this._shaderType == ShaderType.TEXTURE && this._buffer)
			{
				_context.setRenderToTexture( _buffer );
			}
			else if (this._shaderType == ShaderType.BACK_BUFFER || !this._buffer)
			{
				_context.setRenderToBackBuffer();
			}
			
			_context.clear(.3, .3, .3);
			
			/*context.setVertexBufferAt( 0, geometry._vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3 );
			context.setVertexBufferAt( 1, geometry._vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_2 );*/
			
			_context.drawTriangles( geometry._indexBuffer, 0, geometry.numIndices );
			
			// Do any post render clean-up
			disposeForRender( camera );
			
			// Finally clear out the input textures
			if (_inputs.length > 0)
			{
				for (i = 0; i < _inputs.length; i++)
				{
					_context.setTextureAt(i, null);
				}
			}
		}
		
		/**
		 * Assigns a shader to an input and discards any shaders already linked
		 */
		public function setInputShaderAt ( shader:Shader, index:uint ) : void
		{
			// Clamp index
			index = Math.min(index, _inputs.length);
			trace(index);
			_inputs[index] = shader;
		}
	}

}