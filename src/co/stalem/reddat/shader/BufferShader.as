package co.stalem.reddat.shader 
{
	import co.stalem.reddat;
	import co.stalem.reddat.environment.Camera;
	import co.stalem.reddat.geometry.Geometry;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	
	use namespace reddat;
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class BufferShader extends Shader
	{
		
		public function BufferShader() 
		{
			super(1, 0);
			this._shaderType = ShaderType.BACK_BUFFER;
			
			_fragmentProgram =	"div ft0.x, v0.x, v0.w \n" +	// Divide vertex positions (v0.xy) with clips-space position (v0.w)
								"div ft0.y, v0.y, v0.w \n" +	// to obtain screen coordinates in -1,1
								"div ft0.z, v0.z, v0.w \n" +
								
								"mul ft0.x, ft0.x, fc0.x \n" +	// Multiply positions (ft0.xy) with 0.5 (fc0.x)
								"mul ft0.y, ft0.y, fc0.x \n" +	
								"mul ft0.z, ft0.z, fc0.x \n" +
								
								"add ft0.x, ft0.x, fc0.x \n" +	// Add 0.5 (fc0.x) to positions (ft0.xy) to finalize
								"add ft0.y, ft0.y, fc0.x \n" +	
								"add ft0.z, ft0.z, fc0.x \n" +	
								
								"tex ft1, ft0.xy, fs0 <2d, nearest, repeat, nomip> \n" +	// Simply copy the pixel at (ft0) from the render buffer (fs0)
								"mov oc, ft1";
		}
		
		override reddat function prepareForRender ( camera : Camera ) : void
		{
			camera._context.setProgramConstantsFromVector( Context3DProgramType.FRAGMENT, 0, Vector.<Number>([0.5, 0, 0, 0]) );
		}
		
		/**
		 * This override renders to the backbuffer instead of the texture buffer
		 * @param	geometry
		 * @param	context
		 */
		/*override public function render ( geometry : Geometry, context : Context3D ) : void
		{
			var i:int;
			
			// Render buffers for each connected Shader
			if (_inputs.length > 0)
			{
				for (i = 0; i < _inputs.length; i++)
				{
					// Only render if input shader exist
					if(_inputs[i])
						_inputs[i].render( geometry, context );
				}
				
				for (i = 0; i < _inputs.length; i++)
				{
					if(_inputs[i])
						context.setTextureAt(i, _inputs[i]._buffer);
				}
			}
			
			context.setProgram( _program );
			context.setRenderToBackBuffer();
			context.clear(.3, .3, .3);
			
			context.drawTriangles( geometry._indexBuffer, 0, geometry.numIndices );
			
			// Do any post render clean-up
			disposeForRender(context);
			
			// Finally clear out the input textures
			if (_inputs.length > 0)
			{
				for (i = 0; i < _inputs.length; i++)
				{
					context.setTextureAt(i, null);
				}
			}
		}*/
	}

}