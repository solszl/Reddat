package co.stalem.reddat.shader 
{
	import co.stalem.reddat;
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display3D.Program3D;
	import flash.display3D.Context3DProgramType;
	
	use namespace reddat;
	/**
	 * Assembles REGAL structures and code into AGAL
	 * @author Emil Svensson
	 */
	public class REGALAssembler 
	{
		reddat var _vertexAssembler	: AGALMiniAssembler;
		reddat var _fragmentAssembler	: AGALMiniAssembler;
		
		public function REGALAssembler() 
		{
			_vertexAssembler = new AGALMiniAssembler();
			_fragmentAssembler = new AGALMiniAssembler();
		}
		
		/**
		 * Assembles vertex and fragment programs
		 */
		reddat function assemble ( vertex:String, fragment:String ) : void
		{
			_vertexAssembler.assemble(Context3DProgramType.VERTEX, vertex);
			_fragmentAssembler.assemble(Context3DProgramType.FRAGMENT, fragment);
		}
	}

}