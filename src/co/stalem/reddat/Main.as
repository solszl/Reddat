package co.stalem.reddat
{
	import com.adobe.utils.AGALMiniAssembler;
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
	public class Main extends Sprite 
	{
		protected var context3D:Context3D;
		protected var vertexbuffer:VertexBuffer3D;
		protected var indexbuffer:IndexBuffer3D;
		protected var program:Program3D;
		
		public function Main():void 
		{
			init();
			
			stage.addEventListener(Event.ENTER_FRAME, onRender);
		}
		
		private function init ():void
		{
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, initMolehill);
			stage.stage3Ds[0].requestContext3D();
		}
		
		protected function initMolehill ( e:Event ) : void
		{
			context3D = stage.stage3Ds[0].context3D;
			context3D.configureBackBuffer(800, 600, 2, true);
			
			var vertices:Vector.<Number> = Vector.<Number>([
																-0.3,-0.3, 0, .7, .7, .75, // x, y, z, r, g, b
																-0.3, 0.3, 0, .7, .7, .75,
																 0.3, 0.3, 0, .7, .7, .75
															]);
															
			// Create VertexBuffer3D. 3 vertices, of 6 Numbers each
			vertexbuffer = context3D.createVertexBuffer(3, 6);
			// Upload VertexBuffer3D to GPU. Offset 0, 3 vertices
			vertexbuffer.uploadFromVector(vertices, 0, 3);
			
			var indices:Vector.<uint> = Vector.<uint>([0, 1, 2]);
			// Create IndexBuffer3D. Total of 3 indices. 1 triangle of 3 vertices
			indexbuffer = context3D.createIndexBuffer(3);			
			// Upload IndexBuffer3D to GPU. Offset 0, count 3
			indexbuffer.uploadFromVector (indices, 0, 3);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShaderAssembler.assemble( Context3DProgramType.VERTEX,
				"m44 op, va0, vc0\n" + // pos to clipspace
				"mov v0, va1" // copy color
			);			

			var fragmentShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentShaderAssembler.assemble( Context3DProgramType.FRAGMENT,
				"mov oc, v0 "
			);

			program = context3D.createProgram();
			program.upload( vertexShaderAssembler.agalcode, fragmentShaderAssembler.agalcode);
		}
		private var zp:Number = 0;
		protected function onRender ( e:Event = null ) : void
		{
			if (!context3D)
				return;
			
			context3D.clear(.067, .067, .17, 1);
			// vertex position to attribute register 0
			context3D.setVertexBufferAt (0, vertexbuffer, 0, 	Context3DVertexBufferFormat.FLOAT_3);
			// color to attribute register 1
			context3D.setVertexBufferAt(1, vertexbuffer, 3, 	Context3DVertexBufferFormat.FLOAT_3);
			// assign shader program
			context3D.setProgram(program);
			
			var m:Matrix3D = new Matrix3D();
			m.appendRotation(Math.sin(getTimer() / 800) * 180, Vector3D.Y_AXIS);
			m.appendRotation(Math.cos(getTimer() / 600) * 180, Vector3D.Z_AXIS);
			m.appendRotation(Math.cos(getTimer() / 400) * 180, Vector3D.X_AXIS);
			m.appendTranslation(0, 0, .5);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
			
			context3D.drawTriangles(indexbuffer);
	
			context3D.present();
		}
	}
	
}