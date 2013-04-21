package co.stalem.reddat.shader 
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.AGALMacroAssembler;
	import flash.display3D.Program3D;
	import flash.display3D.Context3DProgramType;
	
	/**
	 * ...
	 * @author Emil Svensson
	 */
	public class RMaterial 
	{
		// Property values uploaded to the GPU
		protected var _propValues:Vector.<Vector.<Number>>;
		
		// Vertex shader program code
		protected var _vertProg:String;
		// Fragment shader program code
		protected var _fragProg:String;
		
		// Shader program
		protected var _program:Program3D;
		// AGAL assemblers
		private var _vertMiniAsm:AGALMiniAssembler;
		private var _fragMiniAsm:AGALMiniAssembler;
		private var _vertMacroAsm:AGALMacroAssembler;
		private var _fragMacroAsm:AGALMacroAssembler;
		
		private var _usingMacro:Boolean = 0;
		
		public function RMaterial() 
		{
			_propValues = new Vector.<Vector.<Number>>();
			
			_vertMiniAsm = new AGALMiniAssembler();
			_fragMiniAsm = new AGALMiniAssembler();
			_vertMacroAsm = new AGALMacroAssembler();
			_fragMacroAsm = new AGALMacroAssembler();
		}
		
		/**
		 * Assemble the shader code and upload it to the program
		 */
		public function assemble () : void
		{
			if (!_program)
				trace("No Program3D defined");
				return;
				
			if (!_vertProg || _vertProg = "")
				trace("No vertex program defined");
				return;
				
			if (!_fragProg || _fragProg = "")
				trace("No fragment program defined");
				return;
				
			if (_usingMacro)
			{
				_vertMacroAsm.assemble( Context3DProgramType.VERTEX, _vertProg );
				_fragMacroAsm.assemble( Context3DProgramType.FRAGMENT, _fragProg );
				_program.upload( _vertMacroAsm.agalcode, _fragMacroAsm.agalcode );
			}
			else
			{
				_vertMiniAsm.assemble( Context3DProgramType.VERTEX, _vertProg );
				_fragMiniAsm.assemble( Context3DProgramType.FRAGMENT, _fragProg );
				_program.upload( _vertMiniAsm.agalcode, _fragMiniAsm.agalcode );
			}
		}
		
		/*************	GETTERS / SETTERS
		 */
		
		public function set usingMacroAsm ( b:Boolean ) : void
		{
			_usingMacro = b;
			assemble();
		}
		public function get usingMacroAsm () : Boolean { return _usingMacro; }
	}

}